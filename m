From: David Miller <davem@davemloft.net>
Date: Mon, 03 Dec 2012 19:30:49 +0000
Subject: [PATCH] sparc64: exit_group should kill register windows just like plain exit.
Message-Id: <20121203.143049.901444782954231849.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sys32.S      |  2 +-
 arch/sparc/kernel/syscalls.S   | 14 ++++++++++++--
 arch/sparc/kernel/systbls_64.S |  2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index 44025f4..8475a47 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -47,7 +47,7 @@ STUB:	sra	REG1, 0, REG1; \
 	sra	REG4, 0, REG4
 
 SIGN1(sys32_exit, sparc_exit, %o0)
-SIGN1(sys32_exit_group, sys_exit_group, %o0)
+SIGN1(sys32_exit_group, sparc_exit_group, %o0)
 SIGN1(sys32_wait4, compat_sys_wait4, %o2)
 SIGN1(sys32_creat, sys_creat, %o1)
 SIGN1(sys32_mknod, sys_mknod, %o1)
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 7f5f65d..bf23477 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -118,10 +118,20 @@ ret_from_syscall:
 	ba,pt	%xcc, ret_sys_call
 	 ldx	[%sp + PTREGS_OFF + PT_V9_I0], %o0
 
+	.globl	sparc_exit_group
+	.type	sparc_exit_group,#function
+sparc_exit_group:
+	sethi	%hi(sys_exit_group), %g7
+	ba,pt	%xcc, 1f
+	 or	%g7, %lo(sys_exit_group), %g7
+	.size	sparc_exit_group,.-sparc_exit_group
+
 	.globl	sparc_exit
 	.type	sparc_exit,#function
 sparc_exit:
-	rdpr	%pstate, %g2
+	sethi	%hi(sys_exit), %g7
+	or	%g7, %lo(sys_exit), %g7
+1:	rdpr	%pstate, %g2
 	wrpr	%g2, PSTATE_IE, %pstate
 	rdpr	%otherwin, %g1
 	rdpr	%cansave, %g3
@@ -129,7 +139,7 @@ sparc_exit:
 	wrpr	%g3, 0x0, %cansave
 	wrpr	%g0, 0x0, %otherwin
 	wrpr	%g2, 0x0, %pstate
-	ba,pt	%xcc, sys_exit
+	jmpl	%g7, %g0
 	 stb	%g0, [%g6 + TI_WSAVED]
 	.size	sparc_exit,.-sparc_exit
 
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index 1c9af9f..017b74a 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -133,7 +133,7 @@ sys_call_table:
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys_getdents
 	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
 /*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, sys_nis_syscall, sys_ni_syscall
-	.word sys_setpgid, sys_fremovexattr, sys_tkill, sys_exit_group, sys_newuname
+	.word sys_setpgid, sys_fremovexattr, sys_tkill, sparc_exit_group, sys_newuname
 /*190*/	.word sys_init_module, sys_sparc64_personality, sys_remap_file_pages, sys_epoll_create, sys_epoll_ctl
 	.word sys_epoll_wait, sys_ioprio_set, sys_getppid, sys_nis_syscall, sys_sgetmask
 /*200*/	.word sys_ssetmask, sys_nis_syscall, sys_newlstat, sys_uselib, sys_nis_syscall
-- 
1.7.12.2.dirty

