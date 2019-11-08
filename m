From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 08 Nov 2019 21:07:23 +0000
Subject: [PATCH 03/23] y2038: vdso: change timeval to __kernel_old_timeval
Message-Id: <20191108210824.1534248-3-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de>
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, linuxppc-dev@lists.ozlabs.org

The gettimeofday() function in vdso uses the traditional 'timeval'
structure layout, which will be incompatible with future versions of
glibc on 32-bit architectures that use a 64-bit time_t.

This interface is problematic for y2038, when time_t overflows on 32-bit
architectures, but the plan so far is that a libc with 64-bit time_t
will not call into the gettimeofday() vdso helper at all, and only
have a method for entering clock_gettime().  This means we don't have
to fix it here, though we probably want to add a new clock_gettime()
entry point using a 64-bit version of 'struct timespec' at some point.

Changing the vdso code to use __kernel_old_timeval helps isolate
this usage from the other ones that still need to be fixed properly,
and it gets us closer to removing the 'timeval' definition from the
kernel sources.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/kernel/vdso/gettimeofday.c |  6 +++---
 arch/powerpc/kernel/asm-offsets.c     |  8 ++++----
 arch/sparc/vdso/vclock_gettime.c      | 12 ++++++------
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/um/vdso/um_vdso.c            |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
index b02581891c33..1e69fd5b067b 100644
--- a/arch/nds32/kernel/vdso/gettimeofday.c
+++ b/arch/nds32/kernel/vdso/gettimeofday.c
@@ -230,10 +230,10 @@ notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
 	return 0;
 }
 
-static notrace inline int gettimeofday_fallback(struct timeval *_tv,
+static notrace inline int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 						struct timezone *_tz)
 {
-	register struct timeval *tv asm("$r0") = _tv;
+	register struct __kernel_old_timeval *tv asm("$r0") = _tv;
 	register struct timezone *tz asm("$r1") = _tz;
 	register int ret asm("$r0");
 
@@ -246,7 +246,7 @@ static notrace inline int gettimeofday_fallback(struct timeval *_tv,
 	return ret;
 }
 
-notrace int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	struct timespec ts;
 	struct vdso_data *vdata;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 484f54dab247..827f4c354e13 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -393,8 +393,8 @@ int main(void)
 	OFFSET(CFG_DCACHE_LOGBLOCKSZ, vdso_data, dcache_log_block_size);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_SYSCALL_MAP64, vdso_data, syscall_map_64);
-	OFFSET(TVAL64_TV_SEC, timeval, tv_sec);
-	OFFSET(TVAL64_TV_USEC, timeval, tv_usec);
+	OFFSET(TVAL64_TV_SEC, __kernel_old_timeval, tv_sec);
+	OFFSET(TVAL64_TV_USEC, __kernel_old_timeval, tv_usec);
 	OFFSET(TVAL32_TV_SEC, old_timeval32, tv_sec);
 	OFFSET(TVAL32_TV_USEC, old_timeval32, tv_usec);
 	OFFSET(TSPC64_TV_SEC, timespec, tv_sec);
@@ -402,8 +402,8 @@ int main(void)
 	OFFSET(TSPC32_TV_SEC, old_timespec32, tv_sec);
 	OFFSET(TSPC32_TV_NSEC, old_timespec32, tv_nsec);
 #else
-	OFFSET(TVAL32_TV_SEC, timeval, tv_sec);
-	OFFSET(TVAL32_TV_USEC, timeval, tv_usec);
+	OFFSET(TVAL32_TV_SEC, __kernel_old_timeval, tv_sec);
+	OFFSET(TVAL32_TV_USEC, __kernel_old_timeval, tv_usec);
 	OFFSET(TSPC32_TV_SEC, timespec, tv_sec);
 	OFFSET(TSPC32_TV_NSEC, timespec, tv_nsec);
 #endif
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index fc5bdd14de76..a20c5030578d 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -74,7 +74,7 @@ notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 	return o0;
 }
 
-notrace static long vdso_fallback_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	register long num __asm__("g1") = __NR_gettimeofday;
 	register long o0 __asm__("o0") = (long) tv;
@@ -304,7 +304,7 @@ __vdso_clock_gettime_stick(clockid_t clock, struct timespec *ts)
 }
 
 notrace int
-__vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+__vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	struct vvar_data *vvd = get_vvar_data();
 
@@ -312,7 +312,7 @@ __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 		if (likely(tv != NULL)) {
 			union tstv_t {
 				struct timespec ts;
-				struct timeval tv;
+				struct __kernel_old_timeval tv;
 			} *tstv = (union tstv_t *) tv;
 			do_realtime(vvd, &tstv->ts);
 			/*
@@ -336,11 +336,11 @@ __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 	return vdso_fallback_gettimeofday(tv, tz);
 }
 int
-gettimeofday(struct timeval *, struct timezone *)
+gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
 notrace int
-__vdso_gettimeofday_stick(struct timeval *tv, struct timezone *tz)
+__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	struct vvar_data *vvd = get_vvar_data();
 
@@ -348,7 +348,7 @@ __vdso_gettimeofday_stick(struct timeval *tv, struct timezone *tz)
 		if (likely(tv != NULL)) {
 			union tstv_t {
 				struct timespec ts;
-				struct timeval tv;
+				struct __kernel_old_timeval tv;
 			} *tstv = (union tstv_t *) tv;
 			do_realtime_stick(vvd, &tstv->ts);
 			/*
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e7c596dea947..76e62bcb8d87 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -184,7 +184,7 @@ bool emulate_vsyscall(unsigned long error_code,
 	 */
 	switch (vsyscall_nr) {
 	case 0:
-		if (!write_ok_or_segv(regs->di, sizeof(struct timeval)) ||
+		if (!write_ok_or_segv(regs->di, sizeof(struct __kernel_old_timeval)) ||
 		    !write_ok_or_segv(regs->si, sizeof(struct timezone))) {
 			ret = -EFAULT;
 			goto check_fault;
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 891868756a51..845336c11364 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -25,7 +25,7 @@ int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
 int clock_gettime(clockid_t, struct timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	long ret;
 
@@ -34,7 +34,7 @@ int __vdso_gettimeofday(struct timeval *tv, struct timezone *tz)
 
 	return ret;
 }
-int gettimeofday(struct timeval *, struct timezone *)
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
 
 time_t __vdso_time(time_t *t)
-- 
2.20.0
