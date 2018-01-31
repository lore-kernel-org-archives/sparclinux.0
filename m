From: James Hogan <jhogan@kernel.org>
Date: Wed, 31 Jan 2018 22:24:46 +0000
Subject: [PATCH 2/2] sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}
Message-Id: <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
Cc: linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Corentin Labbe <clabbe.montjoie@gmail.com>, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org

Now that USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC are moved
outside of the USB_SUPPORT conditional, simply select them from
SPARC_LEON rather than by the symbol's defaults in drivers/usb/Kconfig,
similar to how it is done for USB_EHCI_BIG_ENDIAN_MMIO and
USB_EHCI_BIG_ENDIAN_DESC.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: sparclinux@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 arch/sparc/Kconfig  | 2 ++
 drivers/usb/Kconfig | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 6bf594ace663..8767e45f1b2b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -430,6 +430,8 @@ config SPARC_LEON
 	depends on SPARC32
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_DESC
+	select USB_UHCI_BIG_ENDIAN_MMIO
+	select USB_UHCI_BIG_ENDIAN_DESC
 	---help---
 	  If you say Y here if you are running on a SPARC-LEON processor.
 	  The LEON processor is a synthesizable VHDL model of the
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 65812a2f60b4..148f3ee70286 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -21,11 +21,9 @@ config USB_EHCI_BIG_ENDIAN_DESC
 
 config USB_UHCI_BIG_ENDIAN_MMIO
 	bool
-	default y if SPARC_LEON
 
 config USB_UHCI_BIG_ENDIAN_DESC
 	bool
-	default y if SPARC_LEON
 
 menuconfig USB_SUPPORT
 	bool "USB support"
-- 
git-series 0.9.1
