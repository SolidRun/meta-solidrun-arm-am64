# Add this layer to SRC_URI search path
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-2024.04:"

# Add SolidRun patches
SRC_URI += "file://0001-lib-add-tlv_eeprom-library.patch \
            file://0002-mvebu-clearfog-convert-tlv-parsing-to-use-new-librar.patch \
            file://0003-cmd-tlv_eeprom-port-to-new-shared-tlv-library.patch \
            file://0004-lib-tlv_eeprom-add-getters-for-vendor-extension-fiel.patch \
            file://0005-arm-mach-k3-am642_init-support-spl_boot_device-in-u-.patch \
            file://0006-net-eth-uclass-add-board-file-function-to-retrieve-m.patch \
            file://0007-board-solidrun-add-initial-support-for-AM64-SoM.patch \
            file://0008-board-solidrun-am64som-minor-corrections-in-non-func.patch \
            file://0009-net-phy-add-support-for-a-driver-defined-software-re.patch \
            file://0010-net-phy-ti-dp83869-implement-software-reset.patch \
            file://0011-configs-am64som-enable-dp83869-phy-driver.patch \
            file://0012-board-solidrun-am64som-regenerate-dram-config-with-l.patch \
            file://0013-board-solidrun-am64som-add-dram-configuration-for-16.patch \
            file://0014-configs-am64som-disable-unused-features-to-shrink-sp.patch \
            file://0015-board-solidrun-am64som-support-dram-and-board-detect.patch \
            file://0016-board-solidrun-hummingboard-t-enable-access-to-usb-d.patch \
            file://0017-board-solidrun-hummingboard-t-enable-support-for-leg.patch \
            file://0018-board-solidrun-am64som-update-for-TI-SDK-10.01.10.patch \
            file://0019-include-env-ti_common-bootcmd_ti_mmc-only-boot-if-lo.patch \
"

# find board-cfg.yaml in am64 evm
EXTRA_OEMAKE += "BINMAN_INDIRS='${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware ${S}/board/ti/am64x'"
