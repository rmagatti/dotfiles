#!/usr/bin/env -S rust-script
//! ```cargo
//! [dependencies]
//! anyhow = "1"
//! serde = { version = "1", features = ["derive"] }
//! serde_json = "1"
//! ```
//! Fetch open PRs authored by @me and output as Markdown or JSON.
//! Default scope: current repository via `gh pr list`.
//   Optional: `--all-repos` scans across all repositories using `gh search prs`.
//
// Usage:
//   ./gh-open-prs.rs                 # Markdown, current repo
//   ./gh-open-prs.rs --json          # JSON, current repo
//   ./gh-open-prs.rs --all-repos     # Markdown, across all repos
//   ./gh-open-prs.rs --all-repos --json
//
// Notes:
// - Requires GitHub CLI (`gh`) to be installed and authenticated.
// - Avoids unwraps; uses anyhow for error handling.

use anyhow::{anyhow, Context, Result};
use serde::Deserialize;
use std::process::Command;

#[derive(Debug, Deserialize, serde::Serialize)]
struct Pr {
    title: String,
    url: String,
}

enum OutputFormat {
    Markdown,
    Json,
}

fn main() -> Result<()> {
    let mut format = OutputFormat::Markdown;
    let mut all = false;

    for arg in std::env::args().skip(1) {
        match arg.as_str() {
            "--json" | "-j" => format = OutputFormat::Json,
            "--md" | "--markdown" => format = OutputFormat::Markdown,
            "--all" | "--all-repos" => all = true,
            "--help" | "-h" => {
                print_usage();
                return Ok(());
            }
            _ => {
                // Ignore unknown args for simplicity; could error-out if preferred.
            }
        }
    }

    let prs = if all {
        fetch_prs_across_all()?
    } else {
        fetch_prs_current_repo()?
    };

    match format {
        OutputFormat::Json => {
            let json = serde_json::to_string_pretty(&prs).context("failed to serialize JSON")?;
            println!("{}", json);
        }
        OutputFormat::Markdown => print_markdown(&prs),
    }

    Ok(())
}

fn print_usage() {
    eprintln!("Usage: gh-open-prs.rs [--json|--markdown] [--all-repos]");
    eprintln!("Default output: markdown. Default scope: current repo via 'gh pr list'.");
    eprintln!("--all-repos scans across all repos using 'gh search prs' with '--author @me --state open'.");
}

fn fetch_prs_current_repo() -> Result<Vec<Pr>> {
    let output = Command::new("gh")
        .args([
            "pr",
            "list",
            "--author",
            "@me",
            "--state",
            "open",
            "--json",
            "title,url",
        ])
        .output()
        .with_context(|| "failed to execute 'gh pr list'")?;

    if !output.status.success() {
        let stderr = String::from_utf8_lossy(&output.stderr);
        let code = output.status.code().unwrap_or(-1);
        return Err(anyhow!("'gh pr list' failed (exit {}): {}", code, stderr));
    }

    let prs: Vec<Pr> = serde_json::from_slice(&output.stdout)
        .with_context(|| "failed to parse JSON from 'gh pr list'")?;
    Ok(prs)
}

fn fetch_prs_across_all() -> Result<Vec<Pr>> {
    // Use 'gh search prs' to span all repos and return PRs.
    let output = Command::new("gh")
        .args([
            "search",
            "prs",
            "--author",
            "@me",
            "--state",
            "open",
            "--json",
            "title,url",
            "--limit",
            "1000",
        ])
        .output()
        .with_context(|| "failed to execute 'gh search prs'")?;

    if !output.status.success() {
        let stderr = String::from_utf8_lossy(&output.stderr);
        let code = output.status.code().unwrap_or(-1);
        return Err(anyhow!(
            "'gh search prs' failed (exit {}): {}",
            code,
            stderr
        ));
    }

    let prs: Vec<Pr> = serde_json::from_slice(&output.stdout)
        .with_context(|| "failed to parse JSON from 'gh search prs'")?;
    Ok(prs)
}

fn print_markdown(prs: &[Pr]) {
    println!("# PRs");
    if prs.is_empty() {
        println!("- No open PRs found");
        return;
    }
    for pr in prs {
        println!("- {}", pr.title);
        println!("  {}", pr.url);
    }
}
