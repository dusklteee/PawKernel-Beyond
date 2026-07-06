<div align="center">

![PawKernel banner](assets/banner.jpg)

# PawKernel, A custom kernel for the **Samsung Galaxy S10 series** (Exynos 9820) Featuring
KernelSU Next and SuSFS Built-in.

![Version](https://img.shields.io/badge/version-1.0b-2e7d32?style=flat-square)
![Linux](https://img.shields.io/badge/Linux-4.14.356-orange?style=flat-square)
![Android](https://img.shields.io/badge/Android-14_–_16-3ddc84?style=flat-square)
![SoC](https://img.shields.io/badge/Exynos-9820-1565c0?style=flat-square)
![License](https://img.shields.io/badge/license-GPLv2-blue?style=flat-square)

</div>

---

## 💬 About PawKernel
> 🇺🇸 PawKernel is a custom kernel i compiled for **my own S10 Plus** that i thought it would be a good idea to make it public so anyone could try it. Due to it being a personal project, **don't** be surprised if this repository ever get **archived, deleted or stop receiving updates in an near or far future.** Any feedback or issue reported are welcome, but **don't** expect it to be fixed fast or be actually fixed.

> 🇧🇷 O PawKernel é um custom kernel que eu compilei para o **meu S10 Plus** que achei que seria uma boa ideia fazer do projeto público para que qualquer pessoa pudesse testar no seu S10. Por conta de ser um projeto pessoal, **não fique surpreso se esse repositório for arquivado, apagado ou parar de receber atualizações em um futuro próximo ou distante.** Qualquer feedback ou bug reportado é bem vindo, mas **não** espere que o problema seja resolvido com rapidez ou que seja realmente corrigido.

> [!WARNING]
> **DISCLAIMER:**
>Flashing a custom kernel requires an **unlocked bootloader**,
>Make a backup if you're doing it for the first time. You do this at your own risk:
> 
> * Your warranty is now void.
> * I am not responsible for bricked devices, dead SD cards,
>   thermonuclear war, or you getting fired because the alarm app failed. Please
>   do some research if you have any concerns about doing this to your device.
> * **YOU** are choosing to make these modifications, and if
>   you **point the finger at me** for messing up your device, I will laugh at you.

</div>

---

## ✨ Features and Tweaks

- **KernelSU-Next** (`3.2.0-Legacy`, Non-GKI) — root with a manual/ioctl supercall
  hook.
- **SuSFS `1.5.5`** + **SUS Mount / SUS_MAP** reimplementation
- **Touch and fingerprint boost** — lower input latency on scroll/unlock without
  pinning the clocks to max (battery-friendly).
- **Networking** — BBR congestion control + FQ qdisc by default.
- **Memory** — ZSTD ZRAM with writeback of cold pages.
- **Deblobbed** & cleaned defconfig (debug overhead removed) for a smaller image file.

> [!WARNING]
>**AOSP-based ROMs only** (LineageOS, EvolutionX, etc.) — Do not try on One UI, ur phone may bootloop.

---

## 📱 Supported devices

Each model gets its own dedicated build —
**do not** flash a zip meant for a different codename.

| Device | Codename | Status |
|---|---|---|
| S10e | `beyond0lte` | ✅ **Tested, working** |
| S10+ | `beyond2lte` | ✅ **Tested, working** |
| S10 | `beyond1lte` | 🧪 **Experimental** — Not tested yet. |
| S10 5G | `beyondx` | 🧪 **Experimental** — Not tested yet. |

> [!NOTE]
> "Experimental" means the kernel was built with the correct model-specific
> drivers, but it has **not been tested on the physical device**. 
> Only `boot` and the kernel `Image` are touched.
>
> If you face a bootloop, while flashing the kernel, reflash your custom rom
> without wiping /data or reflash the previous kernel and report the issue + the model.

> ⚠️ **Not supported:** 
> Galaxy Note 10 (Exynos 9825) and any
> **Snapdragon** variant (models ending in U / W / 1 — are **not** supported).

---

## 📦 Installation

**Requirements**
- A Galaxy S10 (Exynos 9820) running an **AOSP-based ROM**, From android 14–16 (QPR2 Supported).
- A custom recovery (e.g. LineageOS recovery / TWRP).

**Steps**
1. Download the zip matching **your exact device** from the
   [Releases](../../releases) page (e.g. `PawKernel-Beyond-S10+-...zip` for a
   `beyond2lte`) — flashing the wrong one will refuse to install
   (device-check) or, worse, boot with the wrong drivers.
2. Reboot into your custom recovery.
3. Flash the zip using ADB Sideload or "Select from disk/Install menu (if using TWRP).
4. Reboot to system.
5. Install the [**KernelSU-Next Manager**](https://github.com/KernelSU-Next/KernelSU-Next/releases/tag/v3.2.0) app to manage root.

## 🧱 Built from source

PawKernel is a set of patches on top of the LineageOS kernel tree:

- **Base:** [LineageOS/android_kernel_samsung_exynos9820](https://github.com/LineageOS/android_kernel_samsung_exynos9820) (`lineage-23.2`)
- **Toolchain:** Neutron Clang 23 (`LLVM=1 LLVM_IAS=1`)

The full, GPL-compliant kernel source lives in its own repository:
**[android_kernel_samsung_exynos9820](https://github.com/dusklteee/android_kernel_samsung_exynos9820)**.

Every change made on top of the base is summarized in the
[Highlights](#-highlights) above; the full release history is in
[`docs/CHANGELOG.md`](docs/CHANGELOG.md).

The flashable zip is produced with [AnyKernel3](https://github.com/osm0sis/AnyKernel3)
(the customized installer lives in [`installer/`](installer/)).

---

## 📦 Credits

- [**LineageOS**](https://github.com/LineageOS) — the kernel base.
- [**KernelSU-Next**](https://github.com/KernelSU-Next/KernelSU-Next) — root solution.
- [**simonpunk/susfs4ksu**](https://gitlab.com/simonpunk/susfs4ksu) — SuSFS.
- [**Sultanxda**](https://github.com/kerneltoast) — original CPU input boost / fp-boost tweak.
- [**osm0sis/AnyKernel3**](https://github.com/osm0sis/AnyKernel3) — installer framework.

---

## 📄 License

PawKernel is derived from the Linux kernel and is released under the
**GNU General Public License v2.0** — see [`LICENSE`](LICENSE).
