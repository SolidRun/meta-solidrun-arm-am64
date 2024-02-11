# Yocto BSP Layer for SolidRun AM64 SoM

This is a yocto meta layer for adding SolidRun AM64 SoM support to TI Yocto SDK.

## HW Compatibility

- AM642 SoM (standalone, enough to boot)
- AM642 SoM on HummingBoard-T

## TI Documentation

- [Yocto SDK user manual](https://software-dl.ti.com/processor-sdk-linux/esd/AM64X/09_01_00_08/exports/docs/devices/AM64X/linux/Overview.html)
- [Yocto Build Instructions](https://software-dl.ti.com/processor-sdk-linux/esd/AM64X/09_01_00_08/exports/docs/linux/Overview_Building_the_SDK.html)
- [Yocto Software Manifest](https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-yXgchBCk98/09.01.00.08/software_manifest_64_non_rt.htm)

## Compile base image

Please refer to TI's [Yocto SDK user manual](https://software-dl.ti.com/processor-sdk-linux/esd/AM64X/09_01_00_08/exports/docs/devices/AM64X/linux/Overview.html) for build instructions.

To support SolidRun AM64 SoM substitute some of TI's instructions according to the information below:

### "1.2.2.2. Build Steps"

Substitute the git clone command for `oe-layersetup.git` / `tisdk`:

```diff
-git clone https://git.ti.com/git/arago-project/oe-layersetup.git tisdk
+git clone -b tisdk https://github.com/SolidRun/meta-solidrun-arm-am64.git tisdk
 cd tisdk
 ./oe-layertool-setup.sh -f configs/processor-sdk/<oeconfig-file>
 cd build
 . conf/setenv
 MACHINE=<machine> bitbake -k tisdk-default-image
```

### "1.2.3.2. Build Options"

SolidRun BSP supports the following Yocto machines:

| MACHINE       | Supported Devices                              |
|---------------|------------------------------------------------|
| am64xx-evm    | AM64x EVM - HS-FS, HS-SE                       |
| am64xx-sr-som | AM642 SoM, AM642 HummingBoard-T - HS-FS, HS-SE |

## Install Image to SD-Card

Successful default build generates a bootable sdcard image in `deploy-ti/images/am64xx-sr-som/` folder, e.g.:
- `deploy-ti/images/am64xx-sr-som/tisdk-default-image-am64xx-sr-som.wic.xz`
- `deploy-ti/images/am64xx-sr-som/tisdk-default-image-am64xx-sr-som.wic.xz.bmap`

### with bmaptool (recommended)

    sudo bmaptool copy deploy-ti/images/am64xx-sr-som/tisdk-default-image-am64xx-sr-som.wic.xz /dev/sdX

Substitute "sdX" with the correct name of sd-card reader.
Note that device numbering can change, writing to the wrong device **will delete your data**.

Especially on Ubuntu ensure the sdcard is not already mounted in the system, check `mount | grep sdX`.

See also [Yocto Guide to Flashing Images Using bmaptool](https://docs.yoctoproject.org/dev/dev-manual/bmaptool.html#flashing-images-using-bmaptool).

### with etcher (recommended)

[Etcher](https://etcher.io/) is a user-friendly graphical tool for writing disk images to removable drives across all major operating systems.
It supports xz-compressed images directly - simply point it at e.g. `tisdk-default-image-am64xx-sr-som.wic.xz` and write to SD card.

### with dd

xzcat deploy-ti/images/am64xx-sr-som/tisdk-default-image-am64xx-sr-som-20240107211204.rootfs.wic.xz | sudo dd bs=4M conv=fsync of=/dev/sdX

Substitute "sdX" with the correct name of sd-card reader.
Note that device numbering can change, writing to the wrong device **will delete your data**.

Especially on Ubuntu ensure the sdcard is not already mounted in the system, check `mount | grep sdX`.

## Common Issues

### does not boot on silicon 1.0-GP / 2.0-HS-SE

AM64 Silicon revisions and secure-boot configurations require different firmware for initialisation.
Only one bootable disk image is generated, and the default is SR2.0-HS-FS.

The default image does however contain binaries for the non-default configurations.
After writing bootable image to SD-Card non-default configurations can be activated by renaming files on the first partition:

- `tiboot3-am64x-gp-sr-som.bin` (SR1.0-GP)
- `tiboot3-am64x_sr2-hs-fs-sr-som.bin` (SR2.0-HS-FS)
- `tiboot3-am64x_sr2-hs-sr-som.bin` (SR2.0-HS-SE)

to `tiboot3.bin`.

### make version 4.2.1 is known to have issues

```
ERROR:  OE-core's config sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker (see sanity.conf).
    Following is the list of potential problems / advisories:

    make version 4.2.1 is known to have issues on Centos/OpenSUSE and other non-Ubuntu systems. Please use a buildtools-make-tarball or a newer version of make.
```

Prebuilt buildtools with compatible versions are available for download from the yocto project: [x86_64-buildtools-nativesdk-standalone-4.0.15.sh](https://downloads.yoctoproject.org/releases/yocto/yocto-4.0.15/buildtools/x86_64-buildtools-nativesdk-standalone-4.0.15.sh)
Follow the Yocto Instructions on [Downloading a Pre-Built buildtools Tarball](https://www.rpsys.net/yocto-docs/ref-manual/ref-system-requirements.html#downloading-a-pre-built-buildtools-tarball).

## Maintainer Notes

### When updating to new TI SDK:

1. In case of major release or incompatibilities create new meta-layer branch, e.g. `kirkstone-tisdk-10`
2. merge TI changes from [TI oe-layersetup.git](https://git.ti.com/git/arago-project/oe-layersetup.git) into branch `tisdk`
3. add this repository and meta-layer branch to ti sdk config file, e.g. `configs/processor-sdk/processor-sdk-10.00.00-config.txt`

### Patching Linux / U-Boot:

Development is done in [ti_am64x_build](https://github.com/SolidRun/ti_am64x_build) first, it serves as the reference BSP for HW validation.
Patches should be copied without changes from ti_am64x_build to this layer.
