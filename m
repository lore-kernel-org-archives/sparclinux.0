From: Robert Reif <reif@earthlink.net>
Date: Fri, 11 May 2007 10:55:08 +0000
Subject: [PATCH] add missing syscalls
Message-Id: <46444B8C.4000000@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040409040303080209050803"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409040303080209050803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add some missing syscalls.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------040409040303080209050803
Content-Type: text/x-diff;
 name="newsyscall.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newsyscall.diff"

diff --git a/arch/sparc/kernel/systbls.S b/arch/sparc/kernel/systbls.S
index e3f5b8e..9d15e21 100644
--- a/arch/sparc/kernel/systbls.S
+++ b/arch/sparc/kernel/systbls.S
@@ -80,7 +80,7 @@ sys_call_table:
 /*295*/	.long sys_fchmodat, sys_faccessat, sys_pselect6, sys_ppoll, sys_unshare
 /*300*/	.long sys_set_robust_list, sys_get_robust_list, sys_migrate_pages, sys_mbind, sys_get_mempolicy
 /*305*/	.long sys_set_mempolicy, sys_kexec_load, sys_move_pages, sys_getcpu, sys_epoll_pwait
-/*310*/	.long sys_utimensat
+/*310*/	.long sys_utimensat, sys_setresuid, sys_getresuid, sys_setresgid, sys_getresgid
 
 #ifdef CONFIG_SUNOS_EMUL
 	/* Now the SunOS syscall table. */
@@ -197,6 +197,6 @@ sunos_sys_table:
 	.long sunos_nosys, sunos_nosys, sunos_nosys
 	.long sunos_nosys, sunos_nosys, sunos_nosys
 	.long sunos_nosys
-/*310*/	.long sunos_nosys
-
+/*310*/	.long sunos_nosys, sunos_nosys, sunos_nosys
+        .long sunos_nosys, sunos_nosys
 #endif
diff --git a/include/asm-sparc/unistd.h b/include/asm-sparc/unistd.h
index da9bdc5..76c1b89 100644
--- a/include/asm-sparc/unistd.h
+++ b/include/asm-sparc/unistd.h
@@ -327,8 +327,12 @@ #define __NR_move_pages		307
 #define __NR_getcpu		308
 #define __NR_epoll_pwait	309
 #define __NR_utimensat		310
+#define __NR_setresuid		311
+#define __NR_getresuid		312
+#define __NR_setresgid		313
+#define __NR_getresgid		314
 
-#define NR_SYSCALLS		311
+#define NR_SYSCALLS		315
 
 #ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION

--------------040409040303080209050803--

