From: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Wed, 02 Mar 2005 05:10:05 +0000
Subject: [PATCH] procfs: fix printk format warning
Message-Id: <20050301211005.6a23f2b4.rddunlap@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: fix printk format warning:
fs/proc/proc_misc.c:195: warning: long unsigned int format, unsigned int arg (arg 23)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat: include/asm-sparc/vaddrs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./include/asm-sparc/vaddrs.h~proc_misc_printk ./include/asm-sparc/vaddrs.h
--- ./include/asm-sparc/vaddrs.h~proc_misc_printk	2004-12-24 13:33:49.000000000 -0800
+++ ./include/asm-sparc/vaddrs.h	2005-03-01 16:58:02.249595144 -0800
@@ -35,10 +35,10 @@
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe600000
+#define VMALLOC_START		0xfe600000UL
 
 /* XXX Alter this when I get around to fixing sun4c - Anton */
-#define VMALLOC_END		0xffc00000
+#define VMALLOC_END		0xffc00000UL
 
 /*
  * On the sun4/4c we need a place

---
