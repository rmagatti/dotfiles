#!/usr/bin/env -S rust-script
//! ```cargo
//! [dependencies]
//! anyhow = "1"
//! walkdir = "2"
//! colored = "2"
//! ```
//! Find and optionally delete Rust target directories to free up disk space.
//!
//! Usage:
//!   ./clean-rust-targets.rs                # Search current directory
//!   ./clean-rust-targets.rs ~/Projects     # Search specific directory
//!   ./clean-rust-targets.rs --dry-run      # Show what would be deleted without deleting
//!   ./clean-rust-targets.rs --no-confirm   # Skip confirmation prompt
//!
//! Only deletes 'target' directories that have a Cargo.toml in their parent directory.

use anyhow::{Context, Result};
use colored::*;
use std::fs;
use std::io::{self, Write};
use std::path::{Path, PathBuf};
use std::process::Command;
use walkdir::WalkDir;

struct TargetDir {
    path: PathBuf,
    size_bytes: u64,
}

struct DiskTool {
    name: String,
    available: bool,
}

fn main() -> Result<()> {
    let mut search_path = PathBuf::from(".");
    let mut dry_run = false;
    let mut no_confirm = false;

    for arg in std::env::args().skip(1) {
        match arg.as_str() {
            "--dry-run" | "-n" => dry_run = true,
            "--no-confirm" | "-y" => no_confirm = true,
            "--help" | "-h" => {
                print_usage();
                return Ok(());
            }
            _ => {
                search_path = PathBuf::from(arg);
            }
        }
    }

    if !search_path.exists() {
        anyhow::bail!("Path does not exist: {}", search_path.display());
    }

    let disk_tool = detect_disk_tool();

    println!(
        "{} {}",
        "🔍 Searching for Rust target directories in:".blue(),
        search_path.display().to_string().cyan()
    );
    println!();

    let target_dirs = find_rust_targets(&search_path)?;

    if target_dirs.is_empty() {
        println!("{}", "No Rust target directories found.".yellow());
        return Ok(());
    }

    println!(
        "{}",
        format!("Found {} Rust target director(ies):", target_dirs.len()).green()
    );
    println!();

    let total_size = display_targets(&target_dirs);

    println!();
    println!(
        "{}",
        format!("Total size: {}", format_bytes(total_size)).blue()
    );
    println!();

    // Show detailed breakdown if dust is available and not too many directories
    if disk_tool.name == "dust" && disk_tool.available && target_dirs.len() <= 10 {
        show_dust_breakdown(&target_dirs);
    }

    if dry_run {
        println!("{}", "Dry run - no directories were deleted.".yellow());
        return Ok(());
    }

    // Ask for confirmation unless --no-confirm
    if !no_confirm {
        if !confirm_deletion()? {
            println!("{}", "Aborted. No directories were deleted.".yellow());
            return Ok(());
        }
    }

    delete_targets(&target_dirs)?;

    Ok(())
}

fn print_usage() {
    eprintln!("Usage: clean-rust-targets.rs [OPTIONS] [PATH]");
    eprintln!();
    eprintln!("Options:");
    eprintln!("  -n, --dry-run      Show what would be deleted without deleting");
    eprintln!("  -y, --no-confirm   Skip confirmation prompt");
    eprintln!("  -h, --help         Show this help message");
    eprintln!();
    eprintln!("Arguments:");
    eprintln!("  PATH               Directory to search (default: current directory)");
}

fn detect_disk_tool() -> DiskTool {
    if Command::new("dust").arg("--version").output().is_ok() {
        return DiskTool {
            name: "dust".to_string(),
            available: true,
        };
    }
    if Command::new("dua").arg("--version").output().is_ok() {
        return DiskTool {
            name: "dua".to_string(),
            available: true,
        };
    }
    DiskTool {
        name: "du".to_string(),
        available: true,
    }
}

fn find_rust_targets(search_path: &Path) -> Result<Vec<TargetDir>> {
    let mut targets = Vec::new();

    for entry in WalkDir::new(search_path)
        .follow_links(false)
        .into_iter()
        .filter_map(|e| e.ok())
    {
        let path = entry.path();

        // Check if this is a directory named "target"
        if path.is_dir() && path.file_name().and_then(|n| n.to_str()) == Some("target") {
            // Check if parent has Cargo.toml
            if let Some(parent) = path.parent() {
                let cargo_toml = parent.join("Cargo.toml");
                if cargo_toml.exists() {
                    // Calculate size
                    if let Ok(size) = get_dir_size(path) {
                        targets.push(TargetDir {
                            path: path.to_path_buf(),
                            size_bytes: size,
                        });
                    }
                }
            }
        }
    }

    Ok(targets)
}

fn get_dir_size(path: &Path) -> Result<u64> {
    let mut total_size = 0u64;

    for entry in WalkDir::new(path)
        .follow_links(false)
        .into_iter()
        .filter_map(|e| e.ok())
    {
        if entry.file_type().is_file() {
            total_size += entry.metadata()?.len();
        }
    }

    Ok(total_size)
}

fn display_targets(targets: &[TargetDir]) -> u64 {
    let mut total_size = 0u64;

    for target in targets {
        total_size += target.size_bytes;
        println!(
            "  {} - {}",
            format_bytes(target.size_bytes).yellow(),
            target.path.display()
        );
    }

    total_size
}

fn format_bytes(bytes: u64) -> String {
    const KB: u64 = 1024;
    const MB: u64 = KB * 1024;
    const GB: u64 = MB * 1024;

    if bytes >= GB {
        format!("{:.2} GB", bytes as f64 / GB as f64)
    } else if bytes >= MB {
        format!("{:.2} MB", bytes as f64 / MB as f64)
    } else if bytes >= KB {
        format!("{:.2} KB", bytes as f64 / KB as f64)
    } else {
        format!("{} B", bytes)
    }
}

fn show_dust_breakdown(targets: &[TargetDir]) {
    println!("{}", "Detailed breakdown (largest directories):".blue());
    for target in targets {
        println!();
        println!("{}", target.path.display().to_string().yellow());
        let _ = Command::new("dust")
            .args(["-d", "2", "-n", "5"])
            .arg(&target.path)
            .status();
    }
    println!();
}

fn confirm_deletion() -> Result<bool> {
    print!("{}", "Delete all these directories? [y/N]: ".red().bold());
    io::stdout().flush()?;

    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .context("Failed to read user input")?;

    let input = input.trim().to_lowercase();
    Ok(input == "y" || input == "yes")
}

fn delete_targets(targets: &[TargetDir]) -> Result<()> {
    println!();
    println!("{}", "🗑️  Deleting target directories...".blue());
    println!();

    let mut deleted_count = 0;
    let mut deleted_size = 0u64;

    for target in targets {
        if target.path.exists() {
            println!("  Deleting: {}", target.path.display());
            fs::remove_dir_all(&target.path)
                .with_context(|| format!("Failed to delete {}", target.path.display()))?;
            deleted_count += 1;
            deleted_size += target.size_bytes;
        }
    }

    println!();
    println!(
        "{}",
        format!("✅ Successfully deleted {} director(ies)", deleted_count).green()
    );
    println!(
        "{}",
        format!("💾 Freed up: {}", format_bytes(deleted_size)).green()
    );

    Ok(())
}
