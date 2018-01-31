From: James Hogan <jhogan@kernel.org>
Date: Wed, 31 Jan 2018 22:24:44 +0000
Subject: [PATCH 0/2] usb: Move USB_UHCI_BIG_ENDIAN_* and select from SPARC_LEON
Message-Id: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
Cc: linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Corentin Labbe <clabbe.montjoie@gmail.com>, linux-usb@vger.kernel.org, sparclinux@vger.kernel.org

This series moves USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC
to a place where they can be easily selected from architecture code,
like USB_EHCI_BIG_ENDIAN_* are.

Patch 1 is primarily to fix MIPS generic platform warnings when this
patch ("MIPS: fix typo BIG_ENDIAN to CPU_BIG_ENDIAN") is applied:

https://patchwork.linux-mips.org/patch/18495/

It'd be awesome if this could get included in 4.16 so that the MIPS
patch can also be included without introducing warnings.

Patch 2 allows SPARC_LEON to do the same thing as MIPS_GENERIC does,
which seemed like a natural progression.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: linux-usb@vger.kernel.org
Cc: sparclinux@vger.kernel.org

James Hogan (2):
  usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
  sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}

 arch/sparc/Kconfig       | 2 ++
 drivers/usb/Kconfig      | 6 ++++++
 drivers/usb/host/Kconfig | 8 --------
 3 files changed, 8 insertions(+), 8 deletions(-)

base-commit: 6045f241b48f07b2fb80905bf49671f457a8c037
-- 
git-series 0.9.1
