# Home Assistant Debug Notes

Date: 2026-05-11

## Host

- Home Assistant host: `192.168.68.85` / `homeassistant.local`
- Platform: Home Assistant OS 17.3 on Odroid N2 (`aarch64`)
- Core version observed: `2026.5.1`
- Supervisor version observed: `2026.04.2`
- SSH key created locally: `~/.ssh/homeassistant_ed25519`

## Main Finding

Home Assistant is running out of memory. The failure is not just frontend lag.

Evidence:

- Previous boot journal showed repeated `Under memory pressure, flushing caches`.
- Docker health checks timed out under memory pressure.
- The host/Supervisor restarted around `01:16`, not just Core.
- Core reached about `3G` memory peak plus about `1004M` swap peak in host logs.
- Current measurements repeatedly showed Core as the dominant memory consumer.

Memory breakdown observed after restart:

- Home Assistant Core: roughly `2.3-2.8 GB`
- Supervisor: roughly `226 MB`
- Grafana: roughly `106 MB`
- Matter Server: roughly `45 MB`
- VS Code: roughly `41 MB`
- Mosquitto: roughly `18 MB`
- Other add-ons: small

Conclusion: the problem is inside Home Assistant Core, likely an integration/custom component or startup task, not add-on memory usage.

Update after additional checks on 2026-05-11:

- Host still responds to ping.
- SSH on port 22 accepts TCP but times out during SSH banner exchange.
- HA frontend on port 8123 accepts TCP but returns no HTTP bytes before timeout.
- Observer on port 4357 accepts TCP but returns no HTTP bytes before timeout.
- HAOS debug SSH on port 22222 is not open.
- This is the same wedge pattern seen previously under memory pressure.

Upstream comparison:

- Open Home Assistant Core issue `home-assistant/core#170341` closely matches this system:
  - HAOS `17.3`
  - `aarch64`
  - Core `2026.5.1`
  - uncontrolled Core memory growth
  - Safe Mode still affected
  - add-ons not responsible
  - Core `2026.3.4` reported stable
- GitHub releases currently show `2026.5.1` as latest, so there is no newer Core patch to try first.
- Current recommended stabilization step is to downgrade Core to `2026.3.4` after the HA host is rebooted and SSH/CLI access returns.

Downgrade result after physical reboot:

- Physical reboot restored SSH/Observer/CLI access.
- Initial Core version after reboot was still `2026.5.1`.
- First downgrade attempts failed because Supervisor had an active `home_assistant_core_start` job.
- `ha jobs info --raw-json` showed active job `home_assistant_core_start` created at `2026-05-11T17:59:39Z`.
- The job cleared around `12:01:48 MDT`; downgrade then succeeded with:
  - `ha core update --version 2026.3.4`
- Confirmed after downgrade:
  - Core version `2026.3.4`
  - HA state `running`
  - Observer responsive
  - Frontend responsive
  - No active Supervisor jobs

Post-downgrade memory:

- Core memory initially confirmed around `1.30 GB`.
- 10 samples from `12:09:38` to `12:11:35 MDT` stayed roughly flat around `1.27-1.30 GB`.
- Host memory available stayed around `2.0 GB`.
- Swap still contained about `235 MB` from earlier pressure but was not increasing during the short watch.
- This is a strong improvement versus `2026.5.1`, where Core climbed rapidly toward `2.5+ GB` and swap pressure increased.

Important downgrade side effect:

- ZHA/zigpy now logs schema mismatch:
  - `This zigpy release uses database schema v14 but the database is v15. Downgrading zigpy is not recommended and may result in data loss. Use at your own risk.`
- Interpretation: Core `2026.5.1`/newer ZHA likely migrated `/config/zigbee.db` to schema `v15`; Core `2026.3.4` expects schema `v14`.
- Current ZHA may not function correctly until the Zigbee DB is restored to a compatible pre-migration copy or Core is upgraded again after an upstream fix.
- Current v15 Zigbee DB files were backed up non-destructively to:
  - `/config/zigbee-db-backups/zigbee.db.v15-after-downgrade-202605111212`
  - `/config/zigbee-db-backups/zigbee.db-shm.v15-after-downgrade-202605111212`
  - `/config/zigbee-db-backups/zigbee.db-wal.v15-after-downgrade-202605111212`
- Best-looking pre-migration backup candidate is NAS backup slug `6c2e5705`:
  - Date: `2026-05-05T10:54:09Z`
  - Name: `Automatic backup 2026.1.1`
  - Predates May 6+ backups named `Automatic backup 2026.4.4`
- Do not overwrite `/config/zigbee.db` without user confirmation because restoring from May 5 may lose Zigbee changes made after that backup.

## Actions Already Taken

### InfluxDB

- Disabled the YAML `influxdb:` block in `/config/configuration.yaml`.
- Backup created on HA host:
  - `/config/configuration.yaml.bak-disable-influxdb-20260511002828`
- Disabled the HA config entry for InfluxDB by setting `disabled_by: user`.
- Stopped the InfluxDB add-on.
- Did not uninstall InfluxDB and did not delete its data.
- InfluxDB add-on was already in `unknown` state.
- InfluxDB add-on info showed `boot: manual`.

### MQTT / Frigate Startup Issue

- Mosquitto was running, but HA initially had only an ignored MQTT config entry (`source: ignore`).
- Frigate custom integration was failing with:
  - `KeyError: 'mqtt'`
  - `Cannot subscribe to topic 'frigate/...'`
- MQTT integration was then installed via UI.
- Core was restarted afterward so MQTT existed before Frigate loaded.
- Mosquitto logs later showed HA connecting as `homeassistant`.

### Disabled Heavy/Suspicious HA Config Entries

Backed up `/config/.storage/core.config_entries` before disabling entries.

Backup created on HA host:

- `/config/.storage/core.config_entries.bak-disable-heavy-20260511093855`

Entries set to `disabled_by: user`:

- `ecovacs` / Deebot
- `petlibro`
- `influxdb`

Later disabled after manual host reboot:

- `frigate`
- all `reolink` config entries

After disabling, these entries were confirmed as disabled:

```text
ecovacs    clarafrancabandiera@hotmail.com    385d2a358b649056fd5e6388cfc92259    user
petlibro   ronniemagatti@gmail.com            01K59N4R8AFKN6WZFZBAHR8X40          user
influxdb   homeassistant (localhost)          01KQWBGQH7QAFGMHRC4470MWXM          user
```

Additional backups created on HA host:

- `/config/.storage/core.config_entries.bak-disable-frigate-20260511113521`
- `/config/.storage/core.config_entries.bak-disable-reolink-20260511114118`

Frigate disabled entry:

```text
frigate    192.168.68.76:5000    01KE7PJ1FWY8BH9KS4AHXKSAJE    user
```

Reolink disabled entries:

```text
reolink    Mud Room Camera    01KE2V7WNNXD2AXM2QM4VJ3WYM    user
reolink    Living Room        01KET5BBVXCZCK2ESPG83D3DNV    user
reolink    Garage             01KF0AYQ8Q6S5321F531XF73VP    user
reolink    Bedroom            01KF6R7E2FTSTXBYAS1EPSFFJS    user
```

Result after disabling Frigate and Reolink:

- UI and Observer still responsive.
- Core memory still climbed to roughly `2.5-2.75 GB`.
- Swap still climbed quickly, reaching roughly `786 MB` used in one sample.
- Therefore Frigate/Reolink were not the main memory cause.

## Current Suspicious Areas

### Assist Microphone / Wyoming

User identified likely matching upstream issue:

- `home-assistant/core#167971`
- Title: `Wyoming Protocol / Assist Microphone leaking memory since last HA Core (2026.4) or possibly HA OS (17.2) update`
- Issue reports Assist Microphone / Wyoming slowly consuming memory until crash, and memory stabilizing when the integration is disabled.

This matches the local environment enough to test because:

- Assist Microphone add-on was installed and running.
- Add-on slug: `core_assist_microphone`
- HA config entry: `wyoming / Assist Microphone / 01JPVSDC395FXW4VGGWKBZME1F`
- We do not actively use the microphone.

Actions taken on 2026-05-11:

- Stopped Assist Microphone add-on:
  - `ha apps stop core_assist_microphone`
- Set Assist Microphone add-on boot mode to manual via Supervisor API.
- Disabled the `wyoming` config entry for `Assist Microphone` by setting `disabled_by: user`.
- Backup created before editing config entries:
  - `/config/.storage/core.config_entries.bak-disable-wyoming-20260511121953`
- Restarted Core on `2026.3.4` so disabled entry was loaded.
- Upgraded Core back to `2026.5.1`:
  - `ha core update --version 2026.5.1`

Confirmed after the test:

- Core version: `2026.5.1`
- HA state: `running`
- Assist Microphone add-on:
  - state: `error` / not running
  - boot: `manual`
- Wyoming config entry:
  - `wyoming    Assist Microphone    01JPVSDC395FXW4VGGWKBZME1F    user`

Memory result after upgrading to `2026.5.1` with Assist Microphone disabled:

- 20 samples from `12:27:08` to `12:32:13 MDT` stayed roughly flat around `1.146-1.160 GB` Core memory.
- Final sample: Core `1.162 GB`, host available memory around `2.0 GB`, swap around `221 MB` and not increasing.
- This is very different from earlier `2026.5.1` behavior where Core climbed rapidly toward `2.5+ GB` and swap pressure increased.
- Current conclusion: Assist Microphone / Wyoming is the strongest confirmed cause of the severe memory climb.

Remaining log clue after microphone disable:

- Google Assistant report-state tasks still delay startup/wrap-up:
  - `sync_google`
  - `report_states`
- However, with Assist Microphone disabled, these warnings did not correspond to rapid memory growth during the short monitoring window.

### Google Assistant / Cloud

Core logs showed startup not wrapping up cleanly and waiting on Google Assistant report-state tasks:

```text
AbstractConfig.async_initialize.<locals>.sync_google
async_enable_report_state.<locals>.report_states
```

This may be contributing to slow startup or event-loop pressure.

This signal persisted after disabling Ecovacs, Petlibro, InfluxDB, Frigate, and Reolink. Current strongest suspect is Google Assistant / Nabu Casa report state, or another integration causing Google report-state sync to hold many states/tasks.

### Frigate

Frigate custom integration still logs timeouts fetching:

```text
http://192.168.68.76:5000/api/stats
```

Frigate entity count observed: about `110` entities.

Frigate was disabled and memory remained high, so it is unlikely to be the primary memory cause.

### Reolink

Reolink has about `180` entities and logged session errors, including:

```text
RuntimeError: Session is closed
```

Reolink was disabled and memory remained high, so it is unlikely to be the primary memory cause.

### Re-enabled Diagnostic Disables

After confirming Assist Microphone / Wyoming as the likely memory leak trigger, the diagnostic integration disables were reverted on 2026-05-11.

Backup created before re-enabling:

- `/config/.storage/core.config_entries.bak-reenable-diagnostic-20260511123821`

Entries re-enabled:

```text
ecovacs    clarafrancabandiera@hotmail.com    385d2a358b649056fd5e6388cfc92259    enabled
frigate    192.168.68.76:5000                01KE7PJ1FWY8BH9KS4AHXKSAJE          enabled
influxdb   homeassistant (localhost)          01KQWBGQH7QAFGMHRC4470MWXM          enabled
petlibro   ronniemagatti@gmail.com            01K59N4R8AFKN6WZFZBAHR8X40          enabled
reolink    Bedroom                            01KF6R7E2FTSTXBYAS1EPSFFJS          enabled
reolink    Garage                             01KF0AYQ8Q6S5321F531XF73VP          enabled
reolink    Living Room                        01KET5BBVXCZCK2ESPG83D3DNV          enabled
reolink    Mud Room Camera                    01KE2V7WNNXD2AXM2QM4VJ3WYM          enabled
```

Still intentionally disabled:

```text
wyoming    Assist Microphone                  01JPVSDC395FXW4VGGWKBZME1F          user
```

Not touched because they were not part of this diagnostic work:

```text
accuweather    Home                           8b82ac66e65cfed52d740088004aecbc   user
github                                        01JEK12DK19285WX1DAZD1X9DH          user
```

Notes:

- Core was restarted after re-enabling entries.
- HA remained `running` on Core `2026.5.1`.
- 16 memory samples from `12:41:01` to `12:45:01 MDT` stayed roughly flat around `0.989-0.998 GB` Core memory.
- Swap stayed flat around `220.6 MB`.
- Re-enabling these integrations did not reproduce the previous memory climb.
- InfluxDB config entry was briefly re-enabled in this diagnostic batch, but user confirmed InfluxDB was also causing crashes and should stay disabled.
- InfluxDB was disabled again after this batch.

### InfluxDB Left Disabled

User confirmed InfluxDB should remain disabled because it had caused crashes previously.

Actions taken on 2026-05-11:

- Disabled the HA `influxdb` config entry again by setting `disabled_by: user`.
- Backup created before the edit:
  - `/config/.storage/core.config_entries.bak-disable-influxdb-again-20260511125523`
- Confirmed disabled entries:

```text
influxdb    homeassistant (localhost)    01KQWBGQH7QAFGMHRC4470MWXM    user
wyoming     Assist Microphone            01JPVSDC395FXW4VGGWKBZME1F    user
```

- InfluxDB add-on remains:
  - state: `unknown`
  - boot: `manual`
- YAML `influxdb:` block remains disabled in `/config/configuration.yaml`.
- Core restarted after disabling InfluxDB again.
- HA remained `running` on Core `2026.5.1`; Core memory around `1.0 GB` immediately after restart.

### Mobile App Entity Count

Mobile app entities are high:

```text
mobile_app: 609 entities
```

This is not proven as the cause, but it is notable.

## Blind Issue Notes

Left blind entity:

- Entity: `cover.left_blind_cover`
- Device: IKEA FYRTUR block-out roller blind
- IEEE: `68:0a:e2:ff:fe:6f:d8:de`
- Battery observed in restore state: `94%`
- Firmware: `0x24040013`

Right blind entity:

- Entity: `cover.right_blind_cover`
- Device: IKEA FYRTUR block-out roller blind
- IEEE: `68:0a:e2:ff:fe:7f:9d:91`
- Battery observed in restore state: `45%`
- Firmware: `0x24040013`

Observed left blind behavior:

- Open command: no reaction once.
- Close command: audible reaction/click, but no movement.

Interpretation:

- Because the blind sometimes audibly reacts, HA/Zigbee may be delivering the command.
- No movement after reaction could be calibration/endstop/mechanical or motor refusal.
- Do not over-focus on blind diagnostics until the Core memory/restart issue is stabilized.

ZHA notes:

- Earlier cover command failure was seen for `cover.right_blind_cover`:
  - `ZHAException: Failed to send request: device did not respond`
- Some Zigbee APS no-ack warnings were observed.
- ZHA config warnings exist for deprecated OTA provider keys.

## Useful Commands

SSH into HA:

```sh
ssh -i "$HOME/.ssh/homeassistant_ed25519" -o IdentitiesOnly=yes root@192.168.68.85
```

If SSH host key changes after add-on restarts:

```sh
ssh-keygen -R 192.168.68.85
```

Check memory and Core stats:

```sh
free -h
ha core stats
ha supervisor stats
```

Check add-on memory:

```sh
for slug in core_mosquitto a0d7b954_vscode a0d7b954_grafana a0d7b954_influxdb core_configurator core_ssh core_assist_microphone core_matter_server a0d7b954_ssh; do
  printf "%s\t" "$slug"
  curl -fsS -H "Authorization: Bearer $SUPERVISOR_TOKEN" "http://supervisor/addons/$slug/stats" 2>/dev/null | jq -r 'if .result == "ok" then [.data.cpu_percent, .data.memory_usage, .data.memory_percent] | @tsv else . end' 2>/dev/null || true
  printf "\n"
done
```

Check previous boot for memory pressure:

```sh
ha host logs boots
ha host logs --boot -1 --lines 1500 | grep -Ei 'oom|out of memory|killed process|watchdog|reboot|shutdown|power|voltage|thermal|panic|hung|blocked for|i/o error|mmc|ext4|docker.*homeassistant|homeassistant|supervisor|error|failed|warning|under memory pressure'
```

Check active/disabled config entries:

```sh
jq -r '.data.entries[] | [.domain,.title,.entry_id,(.disabled_by//"enabled")] | @tsv' /config/.storage/core.config_entries | sort
```

Disable specific HA config entries manually, after stopping Core and backing up:

```sh
ha core stop
cp /config/.storage/core.config_entries /config/.storage/core.config_entries.bak-$(date +%Y%m%d%H%M%S)
jq '(.data.entries[] | select(.domain == "ecovacs" or .domain == "petlibro" or .domain == "influxdb") | .disabled_by) = "user"' /config/.storage/core.config_entries > /tmp/core.config_entries
mv /tmp/core.config_entries /config/.storage/core.config_entries
ha core start
```

## Recommended Next Steps

1. Monitor Core memory on `2026.3.4` for a longer period.
2. Decide how to handle ZHA after the zigpy schema mismatch:
   - keep Core `2026.3.4` and restore a pre-2026.4 `zigbee.db` backup, likely from backup slug `6c2e5705`; or
   - leave ZHA broken/disabled temporarily and wait for a fixed Core release that can use schema `v15`; or
   - upgrade again only after an upstream fix is available.
3. If memory remains stable, keep heavy integrations disabled initially, then re-enable them one at a time.
4. If memory still grows on `2026.3.4`, temporarily disable Google Assistant / Cloud report-state path and restart Core, then compare memory.
5. Consider reducing or pruning very large entity groups, especially `mobile_app` entities.
6. Once memory and ZHA are stable, return to diagnosing the FYRTUR blind calibration/mechanical/ZHA routing issue.
