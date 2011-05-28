From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 28 May 2011 07:39:56 +0000
Subject: [PATCH] sparc: Do not select GENERIC_HARDIRQS_NO_DEPRECATED
Message-Id: <1306568396-10438-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, Daniel Hellstrom <daniel@gaisler.com>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Config option GENERIC_HARDIRQS_NO_DEPRECATED was removed in commit
78c89825649a9a5ed526c507603196f467d781a5 ("genirq: Remove the now obsolete
config options and select statements"), but the select was accidentally
reintroduced in commit 6baa9b20a68a88c2fd751cbe8d7652009379351b
("sparc32: genirq support")

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sparc/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index af32e17..789e178 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -26,7 +26,6 @@ config SPARC
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_HARDIRQS_NO_DEPRECATED
 	select GENERIC_IRQ_SHOW
 	select USE_GENERIC_SMP_HELPERS if SMP
 
-- 
1.7.0.4

