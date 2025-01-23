# Add this layer to SRC_URI search path
FILESEXTRAPATHS:prepend := "${THISDIR}/linux-ti-staging-6.6:"

# Enable non-default kernel configs required for reference board
SRC_URI:append = " file://k3-am642-hummingboard-t.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/k3-am642-hummingboard-t.cfg"

# Add SolidRun patches
SRC_URI += "file://0001-dt-bindings-arm-ti-Add-bindings-for-SolidRun-AM642-H.patch \
            file://0002-arm64-dts-add-description-for-solidrun-am642-som-and.patch \
            file://0003-arm64-dts-ti-hummingboard-t-add-overlays-for-m.2-pci.patch \
            file://0004-arm64-dts-ti-k3-am642-hummingboard-t-correct-rs485-r.patch \
            file://0005-arm64-dts-ti-k3-am642-hummingboard-t-Convert-overlay.patch \
            file://0006-arm64-dts-ti-k3-am642-hummingboard-t-fix-sdcard-dete.patch \
            file://0007-arm64-dts-ti-k3-am64-main-icssg0_mdio-fix-clock-refe.patch \
            file://0008-arm64-dts-ti-k3-am64-main-icssg1_mdio-fix-clock-refe.patch \
            file://0009-arm64-dts-ti-k3-am64-main-icssg-hack-fix-deferred-pr.patch \
            file://0010-arm64-dts-ti-k3-am642-sr-som-link-icssg1-statistics-.patch \
            file://0011-arm64-dts-ti-k3-am642-sr-som-add-reserved-memory-reg.patch \
"
