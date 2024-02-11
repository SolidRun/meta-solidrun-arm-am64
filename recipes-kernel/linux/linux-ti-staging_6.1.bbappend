# Add this layer to SRC_URI search path
FILESEXTRAPATHS:prepend := "${THISDIR}/linux-ti-staging-6.1:"

# Enable non-default kernel configs required for reference board
SRC_URI:append = " file://k3-am642-hummingboard-t.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/k3-am642-hummingboard-t.cfg"

# Add SolidRun patches
SRC_URI += "file://0001-pci-j721e-assert-reset-gpio-before-deassertion-to-en.patch \
            file://0002-arm64-dts-ti-k3-am64-main-fix-pci-e-gic-interrupt-nu.patch \
            file://0003-mmc-core-disable-voltage-switch-from-same-voltage.patch \
            file://0004-arm64-dts-add-description-for-solidrun-am64-som-and-.patch \
            file://0005-arm64-dts-ti-k3-am642-sr-som-add-reserved-memory-reg.patch \
            file://0006-arm64-dts-ti-k3-am64-main-icssg0_mdio-fix-clock-refe.patch \
            file://0007-arm64-dts-ti-k3-am64-main-icssg1_mdio-fix-clock-refe.patch \
            file://0008-arm64-dts-ti-k3-am64-main-icssg-hack-fix-deferred-pr.patch \
"
