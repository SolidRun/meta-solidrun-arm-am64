# Add this layer to SRC_URI search path
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}-2023.04:"

# Add SolidRun patches
SRC_URI += "file://0001-lib-add-tlv_eeprom-library.patch \
            file://0002-mvebu-clearfog-convert-tlv-parsing-to-use-new-librar.patch \
            file://0003-cmd-tlv_eeprom-port-to-new-shared-tlv-library.patch \
            file://0004-lib-tlv_eeprom-add-getters-for-vendor-extension-fiel.patch \
            file://0005-arm-mach-k3-am642_init-support-spl_boot_device-in-u-.patch \
            file://0006-net-eth-uclass-add-board-file-function-to-retrieve-m.patch \
            file://0007-board-solidrun-add-initial-support-for-AM64-SoM.patch \
            file://0008-board-solidrun-am64som-minor-corrections-in-non-func.patch \
"

# find board-cfg.yaml in am64 evm
EXTRA_OEMAKE += "BINMAN_INDIRS='${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware ${S}/board/ti/am64x'"
