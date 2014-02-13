From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 13 Feb 2014 18:57:44 +0000
Subject: [PATCH] sparc32: fix build failure for arch_jump_label_transform
Message-Id: <1392317864-24746-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

In arch/sparc/Kernel/Makefile, we see:

   obj-$(CONFIG_SPARC64)   += jump_label.o

However, the Kconfig selects HAVE_ARCH_JUMP_LABEL unconditionally
for all SPARC.  This in turn leads to the following failure when
doing allmodconfig coverage builds:

kernel/built-in.o: In function `__jump_label_update':
jump_label.c:(.text+0x8560c): undefined reference to `arch_jump_label_transform'
kernel/built-in.o: In function `arch_jump_label_transform_static':
(.text+0x85cf4): undefined reference to `arch_jump_label_transform'
make: *** [vmlinux] Error 1

Change HAVE_ARCH_JUMP_LABEL to be conditional on SPARC64 so that it
matches the Makefile.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[This appears to be nothing new ; I checked out 3.0 and the
 same Makefile/Kconfig mismatch existed back then as well.]

 arch/sparc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c51efdcd07a2..7d8b7e94b93b 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -27,7 +27,7 @@ config SPARC
 	select RTC_DRV_M48T59
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
-	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL if SPARC64
 	select GENERIC_IRQ_SHOW
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select GENERIC_PCI_IOMAP
-- 
1.8.5.2

