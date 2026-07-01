# Changelog

All notable changes to PawKernel are documented here.

## [1.0b] — 2026-07-01

Dedicated per-model builds. Each codename now ships its own flashable zip
built from its own `defconfig`, instead of a single `beyond2lte` binary
shared across the whole S10 line.

### Device support
- `beyond1lte` (S10) and `beyondx` (S10 5G) defconfigs now carry the same
  root/perf changes as `beyond2lte`/`beyond0lte` (KernelSU-Next, SuSFS
  1.5.5 + SUS_MAP, boost, BBR, ZRAM, debug removed) — they previously
  shipped without any of it.
- `beyond0lte` (S10e) gets its first dedicated build, with the correct
  `S6E3FA7` panel / `ET5XX` fingerprint / `TCS3407` sensor drivers instead
  of the S10+'s.
- Every model's hardware-driver selection was cross-checked against
  FreeRunnerKernel v3.7 (a shipping Exynos 9820 kernel covering the same
  four codenames) — all four matched exactly.
- Device-check in each zip is now locked to its own codename; flashing the
  wrong zip on the wrong device is refused instead of silently allowed.
- Tier: `beyond2lte` remains the only kernel tested on real hardware. The
  other three are config-validated but **not device-tested** — treat as
  experimental.

### Removed
- The separate `dtb.img` flash (and its GPU DVFS "up-threshold" tweak,
  100 → 95 at the 702 MHz step) was dropped entirely. Traced the tweak
  into `gpu_dvfs_governor.c`: the field is only read when the GPU is
  *below* its top step, which structurally never applies to the top row
  itself — the tweak had zero real effect on the interactive governor in
  use. `dtb`/`dtbo` now stay 100% stock on every device; only the kernel
  `Image` is flashed, matching FreeRunnerKernel's approach.

## [1.0 Stable] — 2026-06-29

First stable release. `uname` reports `-PawKernel-1.0-SuSFS`.

### Root stack
- KernelSU-Next `3.2.0-Legacy` (Non-GKI) with a manual/ioctl supercall hook
  (Samsung RKP blocks kprobes on Exynos 9820).
- SuSFS `1.5.5` with a custom **SUS Mount / SUS_MAP** reimplementation.

### Performance
- Touch input boost (`cpu_input_boost`) — raises each cluster's `policy->min`
  to 65% of max for 200 ms on touch.
- Fingerprint boost (`fp-boost`) — faster unlock from deep sleep.
- BBR congestion control + FQ qdisc by default.
- ZSTD ZRAM with writeback of cold pages.
- GPU DVFS up-threshold lowered (100 → 95) at the 702 MHz step for faster ramp-up.
- Extra cpufreq governors (powersave, userspace, ondemand, conservative).

### Build / hygiene
- Debug overhead removed from defconfig (SLUB_DEBUG, DEBUG_INFO, etc.) for a
  smaller, leaner image.
- Clean `uname` string (host/user/compiler stripped).
- Deblobbed; AOSP-based ROMs only.

### Notes
- GPU overclock (753 MHz) introduced in an earlier beta was **reverted** in v11
  due to undervolt-induced reboots under 3D load. Final clock is a stable 702 MHz.

---

### Development history (pre-release betas)

A long beta cycle (v1 → v16) preceded this release. Key milestones:

- **v1–v6** — KernelSU-Next integration; switch to manual hook (RKP-safe).
- **v7–v10** — banner/cosmetic cleanup, performance tweaks, universal S10 packaging.
- **v11** — GPU fix (reverted the 753 MHz overclock → stable 702 MHz).
- **v12–v13** — SuSFS `1.5.5` ported and tested.
- **v14–v16** — SUS_MAP reimplementation, manager/ksud fixes.
- **v16 → 1.0** — promoted to stable; version strings and installer finalized.
