From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 07 May 2006 15:23:49 +0000
Subject: [PATCH] sparc: Remove duplicate symbol exports
Message-Id: <20060507152349.GA3410@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch resolves the following build warnings seen in 2.6.17-rc3:
WARNING: vmlinux: 'sys_close' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strstr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strnlen' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strrchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncpy' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcpy' exported twice. Previous export was in vmlinux

Please apply.
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---

--- linux-2.6.17-rc3/arch/sparc/kernel/sparc_ksyms.c.orig	2006-05-06 18:36:16.000000000 +0100
+++ linux-2.6.17-rc3/arch/sparc/kernel/sparc_ksyms.c	2006-05-06 18:38:14.000000000 +0100
@@ -251,19 +251,9 @@
 EXPORT_SYMBOL(__prom_getsibling);
 
 /* sparc library symbols */
-EXPORT_SYMBOL(memchr);
 EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
-EXPORT_SYMBOL(strcpy);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(page_kernel);
 
 /* Special internal versions of library functions. */
@@ -317,6 +307,3 @@
 
 /* Sun Power Management Idle Handler */
 EXPORT_SYMBOL(pm_idle);
-
-/* Binfmt_misc needs this */
-EXPORT_SYMBOL(sys_close);
