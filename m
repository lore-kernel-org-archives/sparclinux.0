From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 04:54:40 +0000
Subject: [PATCH 2.6] Missing sparc32 ksyms
Message-Id: <1109912080.17038.49.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-xx/n9D0YMnmZ3/v4CImG"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-xx/n9D0YMnmZ3/v4CImG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds some missing sparc32 ksyms that are needed.
Specifically, ___rw_read_enter, ___rw_read_exit, ___rw_write_enter, and
sys_close.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-xx/n9D0YMnmZ3/v4CImG
Content-Disposition: attachment; filename=linux-2.6.11-sparc-fixksyms.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-fixksyms.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/arch/sparc/kernel/sparc_ksyms.c.BAD	2005-03-03 23:46:45.415759563 -0500
+++ linux-2.6.11/arch/sparc/kernel/sparc_ksyms.c	2005-03-03 23:49:07.580147291 -0500
@@ -20,6 +20,7 @@
 #include <linux/in6.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
+#include <linux/syscalls.h>
 #ifdef CONFIG_PCI
 #include <linux/pci.h>
 #endif
@@ -89,6 +90,9 @@ extern void ___atomic24_sub(void);
 extern void ___set_bit(void);
 extern void ___clear_bit(void);
 extern void ___change_bit(void);
+extern void ___rw_read_enter(void);
+extern void ___rw_read_exit(void);
+extern void ___rw_write_enter(void);
 
 /* Alias functions whose names begin with "." and export the aliases.
  * The module references will be fixed up by module_frob_arch_sections.
@@ -121,9 +125,9 @@ EXPORT_SYMBOL(_do_write_unlock);
 #endif
 #else
 // XXX find what uses (or used) these.
-// EXPORT_SYMBOL_PRIVATE(_rw_read_enter);
-// EXPORT_SYMBOL_PRIVATE(_rw_read_exit);
-// EXPORT_SYMBOL_PRIVATE(_rw_write_enter);
+EXPORT_SYMBOL(___rw_read_enter);
+EXPORT_SYMBOL(___rw_read_exit);
+EXPORT_SYMBOL(___rw_write_enter);
 #endif
 /* semaphores */
 EXPORT_SYMBOL(__up);
@@ -331,3 +335,6 @@ EXPORT_SYMBOL(do_BUG);
 
 /* Sun Power Management Idle Handler */
 EXPORT_SYMBOL(pm_idle);
+
+/* Binfmt_misc needs this */
+EXPORT_SYMBOL(sys_close);

--=-xx/n9D0YMnmZ3/v4CImG--

