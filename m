From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Jan 2004 22:12:19 +0000
Subject: [PATCH] Add sys_close to sparc64_ksyms.c
Message-Id: <1073340739.22653.275.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-xE0UqmOKR3mQY8m6V/g0"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-xE0UqmOKR3mQY8m6V/g0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In order for Solaris emulation to compile in the 2.6 sparc64 tree, the
sys_close symbol needs to be exported in sparc64_ksyms.c. This patch
adds it.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-xE0UqmOKR3mQY8m6V/g0
Content-Disposition: attachment; filename=linux-2.6.0-sys_close.patch
Content-Type: text/x-patch; name=linux-2.6.0-sys_close.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test11/arch/sparc64/kernel/sparc64_ksyms.c.BAD	2003-12-18 22:27:22.000000000 -0500
+++ linux-2.6.0-test11/arch/sparc64/kernel/sparc64_ksyms.c	2003-12-18 22:29:25.000000000 -0500
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/fs_struct.h>
+#include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/socket.h>
 #include <linux/percpu.h>
@@ -96,6 +97,7 @@
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char * filename, int flags, int mode);
 extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space);
+extern long sys_close(unsigned int);
                 
 extern int __ashrdi3(int, int);
 
@@ -324,6 +326,7 @@
 EXPORT_SYMBOL(sys_ioctl);
 EXPORT_SYMBOL(compat_sys_ioctl);
 EXPORT_SYMBOL(sparc32_open);
+EXPORT_SYMBOL(sys_close);
 #endif
 
 /* Special internal versions of library functions. */

--=-xE0UqmOKR3mQY8m6V/g0--

