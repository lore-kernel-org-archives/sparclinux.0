From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Jan 2009 10:14:49 +0000
Subject: [PATCH] sparc64: fix modpost failure
Message-Id: <20090116101449.GA20332@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Previously PeeCeeI.o was a library but it
was always pulled in due to insw and friends being exported
(at least for a modular kernel).

But this resulted in modpost failures if there where no in-kernel
users because then insw & friends were not linked in.

Fix this by including PeeCeeI.o in the kernel unconditionally.

The only drawback for this solution is that a nonmodular kernel
will always include insw & friends no matter if they are in use or not.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

I have no good suggestion how to fix this if we do not accept
that they are always pulled in.

	Sam

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 273fc85..e75faf0 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -18,7 +18,7 @@ lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
 lib-y                 += rwsem_$(BITS).o
 lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 
-lib-$(CONFIG_SPARC64) += PeeCeeI.o copy_page.o clear_page.o bzero.o
+lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
 lib-$(CONFIG_SPARC64) += VISsave.o
 lib-$(CONFIG_SPARC64) += bitops.o
@@ -43,3 +43,4 @@ lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o
 obj-y                 += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o
 obj-y                 += ksyms.o
+obj-$(CONFIG_SPARC64) += PeeCeeI.o
