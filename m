From: Joe Perches <joe@perches.com>
Date: Thu, 10 Mar 2016 23:21:43 +0000
Subject: [PATCH] sparc: Convert naked unsigned uses to unsigned int
Message-Id: <9a3bb519110397a1c70b4020577ddcef8810cb77.1457651534.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use the more normal kernel definition/declaration style.

Done via:

$ git ls-files arch/sparc | \
  xargs ./scripts/checkpatch.pl -f --fix-inplace --types=unspecified_int

Signed-off-by: Joe Perches <joe@perches.com>
---

Dunno if you want this, I was just testing an updated version of checkpatch.

Cross-compiled with gcc 4.6.3, allyesconfig, untested

 arch/sparc/include/asm/compat_signal.h |  8 ++++----
 arch/sparc/include/asm/obio.h          | 32 ++++++++++++++++----------------
 arch/sparc/include/asm/openprom.h      | 10 +++++-----
 arch/sparc/include/asm/sigcontext.h    |  2 +-
 arch/sparc/include/uapi/asm/stat.h     |  4 ++--
 arch/sparc/kernel/audit.c              | 12 ++++++------
 arch/sparc/kernel/compat_audit.c       | 12 ++++++------
 arch/sparc/kernel/kernel.h             | 12 ++++++------
 arch/sparc/kernel/process_64.c         |  2 +-
 arch/sparc/kernel/setup_32.c           |  2 +-
 arch/sparc/kernel/setup_64.c           |  2 +-
 arch/sparc/kernel/signal32.c           |  2 +-
 arch/sparc/kernel/sys_sparc_64.c       |  4 ++--
 arch/sparc/kernel/unaligned_64.c       |  4 ++--
 arch/sparc/mm/fault_32.c               |  8 ++++----
 15 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/sparc/include/asm/compat_signal.h b/arch/sparc/include/asm/compat_signal.h
index 9ed1f12..4b027b1 100644
--- a/arch/sparc/include/asm/compat_signal.h
+++ b/arch/sparc/include/asm/compat_signal.h
@@ -6,17 +6,17 @@
 
 #ifdef CONFIG_COMPAT
 struct __new_sigaction32 {
-	unsigned		sa_handler;
+	unsigned int		sa_handler;
 	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+	unsigned int		sa_restorer;     /* not used by Linux/SPARC yet */
 	compat_sigset_t 	sa_mask;
 };
 
 struct __old_sigaction32 {
-	unsigned		sa_handler;
+	unsigned int		sa_handler;
 	compat_old_sigset_t  	sa_mask;
 	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+	unsigned int		sa_restorer;     /* not used by Linux/SPARC yet */
 };
 #endif
 
diff --git a/arch/sparc/include/asm/obio.h b/arch/sparc/include/asm/obio.h
index 910c1d9..426ad75 100644
--- a/arch/sparc/include/asm/obio.h
+++ b/arch/sparc/include/asm/obio.h
@@ -117,9 +117,9 @@ static inline void bw_clear_intr_mask(int sbus_level, int mask)
 			      "i" (ASI_M_CTL));
 }
 
-static inline unsigned bw_get_prof_limit(int cpu)
+static inline unsigned int bw_get_prof_limit(int cpu)
 {
-	unsigned limit;
+	unsigned int limit;
 	
 	__asm__ __volatile__ ("lda [%1] %2, %0" :
 			      "=r" (limit) :
@@ -128,7 +128,7 @@ static inline unsigned bw_get_prof_limit(int cpu)
 	return limit;
 }
 
-static inline void bw_set_prof_limit(int cpu, unsigned limit)
+static inline void bw_set_prof_limit(int cpu, unsigned int limit)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (limit),
@@ -136,9 +136,9 @@ static inline void bw_set_prof_limit(int cpu, unsigned limit)
 			      "i" (ASI_M_CTL));
 }
 
-static inline unsigned bw_get_ctrl(int cpu)
+static inline unsigned int bw_get_ctrl(int cpu)
 {
-	unsigned ctrl;
+	unsigned int ctrl;
 	
 	__asm__ __volatile__ ("lda [%1] %2, %0" :
 			      "=r" (ctrl) :
@@ -147,7 +147,7 @@ static inline unsigned bw_get_ctrl(int cpu)
 	return ctrl;
 }
 
-static inline void bw_set_ctrl(int cpu, unsigned ctrl)
+static inline void bw_set_ctrl(int cpu, unsigned int ctrl)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (ctrl),
@@ -155,9 +155,9 @@ static inline void bw_set_ctrl(int cpu, unsigned ctrl)
 			      "i" (ASI_M_CTL));
 }
 
-static inline unsigned cc_get_ipen(void)
+static inline unsigned int cc_get_ipen(void)
 {
-	unsigned pending;
+	unsigned int pending;
 	
 	__asm__ __volatile__ ("lduha [%1] %2, %0" :
 			      "=r" (pending) :
@@ -166,7 +166,7 @@ static inline unsigned cc_get_ipen(void)
 	return pending;
 }
 
-static inline void cc_set_iclr(unsigned clear)
+static inline void cc_set_iclr(unsigned int clear)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (clear),
@@ -174,9 +174,9 @@ static inline void cc_set_iclr(unsigned clear)
 			      "i" (ASI_M_MXCC));
 }
 
-static inline unsigned cc_get_imsk(void)
+static inline unsigned int cc_get_imsk(void)
 {
-	unsigned mask;
+	unsigned int mask;
 	
 	__asm__ __volatile__ ("lduha [%1] %2, %0" :
 			      "=r" (mask) :
@@ -185,7 +185,7 @@ static inline unsigned cc_get_imsk(void)
 	return mask;
 }
 
-static inline void cc_set_imsk(unsigned mask)
+static inline void cc_set_imsk(unsigned int mask)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (mask),
@@ -193,9 +193,9 @@ static inline void cc_set_imsk(unsigned mask)
 			      "i" (ASI_M_MXCC));
 }
 
-static inline unsigned cc_get_imsk_other(int cpuid)
+static inline unsigned int cc_get_imsk_other(int cpuid)
 {
-	unsigned mask;
+	unsigned int mask;
 	
 	__asm__ __volatile__ ("lduha [%1] %2, %0" :
 			      "=r" (mask) :
@@ -204,7 +204,7 @@ static inline unsigned cc_get_imsk_other(int cpuid)
 	return mask;
 }
 
-static inline void cc_set_imsk_other(int cpuid, unsigned mask)
+static inline void cc_set_imsk_other(int cpuid, unsigned int mask)
 {
 	__asm__ __volatile__ ("stha %0, [%1] %2" : :
 			      "r" (mask),
@@ -212,7 +212,7 @@ static inline void cc_set_imsk_other(int cpuid, unsigned mask)
 			      "i" (ASI_M_CTL));
 }
 
-static inline void cc_set_igen(unsigned gen)
+static inline void cc_set_igen(unsigned int gen)
 {
 	__asm__ __volatile__ ("sta %0, [%1] %2" : :
 			      "r" (gen),
diff --git a/arch/sparc/include/asm/openprom.h b/arch/sparc/include/asm/openprom.h
index 47eaafa..63374c4 100644
--- a/arch/sparc/include/asm/openprom.h
+++ b/arch/sparc/include/asm/openprom.h
@@ -29,12 +29,12 @@ struct linux_dev_v0_funcs {
 /* V2 and later prom device operations. */
 struct linux_dev_v2_funcs {
 	phandle (*v2_inst2pkg)(int d);	/* Convert ihandle to phandle */
-	char * (*v2_dumb_mem_alloc)(char *va, unsigned sz);
-	void (*v2_dumb_mem_free)(char *va, unsigned sz);
+	char * (*v2_dumb_mem_alloc)(char *va, unsigned int sz);
+	void (*v2_dumb_mem_free)(char *va, unsigned int sz);
 
 	/* To map devices into virtual I/O space. */
-	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned paddr, unsigned sz);
-	void (*v2_dumb_munmap)(char *virta, unsigned size);
+	char * (*v2_dumb_mmap)(char *virta, int which_io, unsigned int paddr, unsigned int sz);
+	void (*v2_dumb_munmap)(char *virta, unsigned int size);
 
 	int (*v2_dev_open)(char *devpath);
 	void (*v2_dev_close)(int d);
@@ -50,7 +50,7 @@ struct linux_dev_v2_funcs {
 struct linux_mlist_v0 {
 	struct linux_mlist_v0 *theres_more;
 	unsigned int start_adr;
-	unsigned num_bytes;
+	unsigned int num_bytes;
 };
 
 struct linux_mem_v0 {
diff --git a/arch/sparc/include/asm/sigcontext.h b/arch/sparc/include/asm/sigcontext.h
index fc2df1e..f4eb630 100644
--- a/arch/sparc/include/asm/sigcontext.h
+++ b/arch/sparc/include/asm/sigcontext.h
@@ -25,7 +25,7 @@ struct sigcontext32 {
 	int sigc_oswins;       /* outstanding windows */
 
 	/* stack ptrs for each regwin buf */
-	unsigned sigc_spbuf[__SUNOS_MAXWIN];
+	unsigned int sigc_spbuf[__SUNOS_MAXWIN];
 
 	/* Windows to restore after signal */
 	struct reg_window32 sigc_wbuf[__SUNOS_MAXWIN];
diff --git a/arch/sparc/include/uapi/asm/stat.h b/arch/sparc/include/uapi/asm/stat.h
index a232e9e..2f0583a 100644
--- a/arch/sparc/include/uapi/asm/stat.h
+++ b/arch/sparc/include/uapi/asm/stat.h
@@ -6,13 +6,13 @@
 #if defined(__sparc__) && defined(__arch64__)
 /* 64 bit sparc */
 struct stat {
-	unsigned   st_dev;
+	unsigned int st_dev;
 	ino_t   st_ino;
 	mode_t  st_mode;
 	short   st_nlink;
 	uid_t   st_uid;
 	gid_t   st_gid;
-	unsigned   st_rdev;
+	unsigned int st_rdev;
 	off_t   st_size;
 	time_t  st_atime;
 	time_t  st_mtime;
diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
index 24361b4..2585c1e 100644
--- a/arch/sparc/kernel/audit.c
+++ b/arch/sparc/kernel/audit.c
@@ -5,27 +5,27 @@
 
 #include "kernel.h"
 
-static unsigned dir_class[] = {
+static unsigned int dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-static unsigned read_class[] = {
+static unsigned int read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-static unsigned write_class[] = {
+static unsigned int write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-static unsigned chattr_class[] = {
+static unsigned int chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-static unsigned signal_class[] = {
+static unsigned int signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
@@ -39,7 +39,7 @@ int audit_classify_arch(int arch)
 	return 0;
 }
 
-int audit_classify_syscall(int abi, unsigned syscall)
+int audit_classify_syscall(int abi, unsigned int syscall)
 {
 #ifdef CONFIG_COMPAT
 	if (abi = AUDIT_ARCH_SPARC)
diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
index 7062263..e5611cd 100644
--- a/arch/sparc/kernel/compat_audit.c
+++ b/arch/sparc/kernel/compat_audit.c
@@ -2,32 +2,32 @@
 #include <asm/unistd.h>
 #include "kernel.h"
 
-unsigned sparc32_dir_class[] = {
+unsigned int sparc32_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-unsigned sparc32_chattr_class[] = {
+unsigned int sparc32_chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-unsigned sparc32_write_class[] = {
+unsigned int sparc32_write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-unsigned sparc32_read_class[] = {
+unsigned int sparc32_read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-unsigned sparc32_signal_class[] = {
+unsigned int sparc32_signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
 
-int sparc32_classify_syscall(unsigned syscall)
+int sparc32_classify_syscall(unsigned int syscall)
 {
 	switch(syscall) {
 	case __NR_open:
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index e7f652b..5057ec2 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -54,12 +54,12 @@ void do_signal32(struct pt_regs * regs);
 asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp);
 
 /* compat_audit.c */
-extern unsigned sparc32_dir_class[];
-extern unsigned sparc32_chattr_class[];
-extern unsigned sparc32_write_class[];
-extern unsigned sparc32_read_class[];
-extern unsigned sparc32_signal_class[];
-int sparc32_classify_syscall(unsigned syscall);
+extern unsigned int sparc32_dir_class[];
+extern unsigned int sparc32_chattr_class[];
+extern unsigned int sparc32_write_class[];
+extern unsigned int sparc32_read_class[];
+extern unsigned int sparc32_signal_class[];
+int sparc32_classify_syscall(unsigned int syscall);
 #endif
 
 #ifdef CONFIG_SPARC32
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index 46a5964..c16ef1a 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -103,7 +103,7 @@ static void show_regwindow32(struct pt_regs *regs)
 	mm_segment_t old_fs;
 	
 	__asm__ __volatile__ ("flushw");
-	rw = compat_ptr((unsigned)regs->u_regs[14]);
+	rw = compat_ptr((unsigned int)regs->u_regs[14]);
 	old_fs = get_fs();
 	set_fs (USER_DS);
 	if (copy_from_user (&r_w, rw, sizeof(r_w))) {
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index baef495..69d75ff 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -109,7 +109,7 @@ unsigned long cmdline_memory_size __initdata = 0;
 unsigned char boot_cpu_id = 0xff; /* 0xff will make it into DATA section... */
 
 static void
-prom_console_write(struct console *con, const char *s, unsigned n)
+prom_console_write(struct console *con, const char *s, unsigned int n)
 {
 	prom_write(s, n);
 }
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f3185e2..26db95b 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -77,7 +77,7 @@ struct screen_info screen_info = {
 };
 
 static void
-prom_console_write(struct console *con, const char *s, unsigned n)
+prom_console_write(struct console *con, const char *s, unsigned int n)
 {
 	prom_write(s, n);
 }
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 4eed773..3c25241 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -144,7 +144,7 @@ void do_sigreturn32(struct pt_regs *regs)
 	compat_uptr_t fpu_save;
 	compat_uptr_t rwin_save;
 	unsigned int psr;
-	unsigned pc, npc;
+	unsigned int pc, npc;
 	sigset_t set;
 	compat_sigset_t seta;
 	int err, i;
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index b489e97..fe8b8ee 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -337,10 +337,10 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 		switch (call) {
 		case SEMOP:
 			err = sys_semtimedop(first, ptr,
-					     (unsigned)second, NULL);
+					     (unsigned int)second, NULL);
 			goto out;
 		case SEMTIMEDOP:
-			err = sys_semtimedop(first, ptr, (unsigned)second,
+			err = sys_semtimedop(first, ptr, (unsigned int)second,
 				(const struct timespec __user *)
 					     (unsigned long) fifth);
 			goto out;
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index d89e97b..9aacb91 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -209,8 +209,8 @@ static inline int do_int_store(int reg_num, int size, unsigned long *dst_addr,
 	if (size = 16) {
 		size = 8;
 		zero = (((long)(reg_num ?
-		        (unsigned)fetch_reg(reg_num, regs) : 0)) << 32) |
-			(unsigned)fetch_reg(reg_num + 1, regs);
+		        (unsigned int)fetch_reg(reg_num, regs) : 0)) << 32) |
+			(unsigned int)fetch_reg(reg_num + 1, regs);
 	} else if (reg_num) {
 		src_val_p = fetch_reg_addr(reg_num, regs);
 	}
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index c399e7b..b6c559c 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -303,10 +303,10 @@ no_context:
 		fixup = search_extables_range(regs->pc, &g2);
 		/* Values below 10 are reserved for other things */
 		if (fixup > 10) {
-			extern const unsigned __memset_start[];
-			extern const unsigned __memset_end[];
-			extern const unsigned __csum_partial_copy_start[];
-			extern const unsigned __csum_partial_copy_end[];
+			extern const unsigned int __memset_start[];
+			extern const unsigned int __memset_end[];
+			extern const unsigned int __csum_partial_copy_start[];
+			extern const unsigned int __csum_partial_copy_end[];
 
 #ifdef DEBUG_EXCEPTIONS
 			printk("Exception: PC<%08lx> faddr<%08lx>\n",
-- 
2.6.3.368.gf34be46

