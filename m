From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 16 Sep 2004 23:53:01 +0000
Subject: [PATCH 2.6] Fix "cannot allocate memory for cgsix" warning on
Message-Id: <1095378781.16982.21.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-GvDzm3Z7GVbcXCAawYl2"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-GvDzm3Z7GVbcXCAawYl2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch has been floating around for about 6 or more months, Keith
wrote it when he was the sparc32 maintainer... it resolves the
framebuffer errors on some older sparc32s (we triggered it on a
SparcStation 2). 

Please commit, thanks.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-GvDzm3Z7GVbcXCAawYl2
Content-Disposition: attachment; filename=linux-2.6.7-sparc-vaddrsfix.patch
Content-Type: text/x-patch; name=linux-2.6.7-sparc-vaddrsfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.7/include/asm-sparc/vaddrs.h.BAD	2004-08-10 19:19:13.874580096 -0400
+++ linux-2.6.7/include/asm-sparc/vaddrs.h	2004-08-10 19:19:45.186819912 -0400
@@ -33,9 +33,9 @@
 
 #define SUN4M_IOBASE_VADDR	0xfd000000 /* Base for mapping pages */
 #define IOBASE_VADDR		0xfe000000
-#define IOBASE_END		0xfe300000
+#define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe300000
+#define VMALLOC_START		0xfe600000
 
 /* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END		0xffc00000

--=-GvDzm3Z7GVbcXCAawYl2--

