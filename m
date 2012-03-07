From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 07 Mar 2012 00:30:38 +0000
Subject: [PATCH 3/3] ARM: Allow the user to enable UIMAGE_KERNEL_NOLOAD
Message-Id: <1331080238-1524-3-git-send-email-swarren@wwwdotorg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Marek <mmarek@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>

When AUTO_ZRELADDR is enabled, ARM zImages are relocatable, and hence
the user may use mkimage's -T kernel_noload option if their bootloader
supports it.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4040796..5459b2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2055,6 +2055,7 @@ config CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
+	select ALLOW_UIMAGE_KERNEL_NOLOAD
 	depends on !ZBOOT_ROM && !ARCH_U300
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
-- 
1.7.0.4

