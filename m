Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3B28A719;
	Mon,  7 Jul 2025 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899657; cv=none; b=Dm6k9kmJmtrqKnEuqaUeuoBrfAT8xSer1c4afATLrH1mTD4iubTzubsuwtECh6v11+mOIHeRoaFREZsvIKbJ2pZkcBuwK4vn/wP+RWXzq484lBl8CffHQNHYtPfrVV5fIjcL1LC8JK21/XDMjF4oZ8Ui04py+UrZuxVwYXWvtT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899657; c=relaxed/simple;
	bh=4HcOfy707OG55VeVgpKtouKWBNahOrANSe2wUBYfC70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5eWq/CWlyVvaYKTuEwaJeHa6QLFS7uBA0nBdDRehRonMBRWZetmmL6TPKGhhuNYAq+tJ4YpHTWxVVSF3Iq2WeXXjyf47n4KttioIAisbEcVEbSF8fOWrD3w9tjH7heuE5yPYzV+52Xopy/DKn0C/ARKxnWkIkWzL2fjFUZghgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPjGTfCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPjGTfCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3027FC4CEF4;
	Mon,  7 Jul 2025 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751899656;
	bh=4HcOfy707OG55VeVgpKtouKWBNahOrANSe2wUBYfC70=;
	h=From:To:Cc:Subject:Date:From;
	b=CPjGTfCEnu63KMz33dYAC+f8vvmdmysSEdWwZuR1FOKQz0h8yDHXc+yCFkkJB3x9T
	 f1GUsTXRb3aPdvCtqdBc8yYglIcAxCYxNiIrlQ+mWjTAP1XtR3DbWUEB5t25/DtcpP
	 /xCaefSNjgDHMhcK4qepnlweAQOkxm5GSqIc+Fadjoo/JscZSZSHz/xrBhQ2BLoKIb
	 ah3lu+VOj8knU0eNTXATvpGwUPekn2k8+5B4KggmC5JAnfNo5WJUgHEbM7K18llp1D
	 91HUWxuZ5opwvm/p0VDGKITjOq/z6BKoNLxESm/VmNmbyREgTDrqIwsPsknEUdwa6k
	 6i0jvMZ08K9gw==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	shuah <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@google.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Date: Mon,  7 Jul 2025 16:46:37 +0200
Message-Id: <20250707144726.4008707-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

sparc64 is the only remaining architecture that has its own implementation
of the vdso clock_gettime/gettimeofday helpers in place of the generic
code. This causes a number of issues:

 - Changes to the vdso interfaces require adding sparc64 specific hacks
   even when nothing else needs them

 - The prototypes in <vdso/gettime.h> don't match the function implementation,
   and not including that header to avoid the build error from that causes
   another warning:

  arch/sparc/vdso/vclock_gettime.c:274:1: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
    274 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
        | ^~~~~~~~~~~~~~~~~~~~

 - Nobody has ever implemented the clock_gettime64() vdso that is required for
   32-bit compat tasks

 - The warning about the missing executable-stack flag was missed:

  sparc-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
  sparc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Most of the removed code only exists on sparc in order to dynamically
patch the vdso based on the presence of the tick vs vtick based
clocksource.

Rip out the whole thing and replace it with a minimal stub as we do
on parisc and uml. This introduces a small performance regression when
using a libc that is aware of the vdso (glibc-2.29 or higher).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/Kconfig                  |   1 -
 arch/sparc/include/asm/vvar.h       |  75 ------
 arch/sparc/kernel/Makefile          |   1 -
 arch/sparc/kernel/vdso.c            |  69 ------
 arch/sparc/vdso/Makefile            |   2 +-
 arch/sparc/vdso/vclock_gettime.c    | 341 +++-------------------------
 arch/sparc/vdso/vdso.lds.S          |   2 -
 arch/sparc/vdso/vdso32/vdso32.lds.S |   3 +-
 arch/sparc/vdso/vma.c               | 265 +--------------------
 9 files changed, 31 insertions(+), 728 deletions(-)
 delete mode 100644 arch/sparc/include/asm/vvar.h
 delete mode 100644 arch/sparc/kernel/vdso.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index dcfdb7f1dae9..776ce79ef188 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -101,7 +101,6 @@ config SPARC64
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
-	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
diff --git a/arch/sparc/include/asm/vvar.h b/arch/sparc/include/asm/vvar.h
deleted file mode 100644
index 6eaf5cfcaae1..000000000000
--- a/arch/sparc/include/asm/vvar.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
- */
-
-#ifndef _ASM_SPARC_VVAR_DATA_H
-#define _ASM_SPARC_VVAR_DATA_H
-
-#include <asm/clocksource.h>
-#include <asm/processor.h>
-#include <asm/barrier.h>
-#include <linux/time.h>
-#include <linux/types.h>
-
-struct vvar_data {
-	unsigned int seq;
-
-	int vclock_mode;
-	struct { /* extract of a clocksource struct */
-		u64	cycle_last;
-		u64	mask;
-		int	mult;
-		int	shift;
-	} clock;
-	/* open coded 'struct timespec' */
-	u64		wall_time_sec;
-	u64		wall_time_snsec;
-	u64		monotonic_time_snsec;
-	u64		monotonic_time_sec;
-	u64		monotonic_time_coarse_sec;
-	u64		monotonic_time_coarse_nsec;
-	u64		wall_time_coarse_sec;
-	u64		wall_time_coarse_nsec;
-
-	int		tz_minuteswest;
-	int		tz_dsttime;
-};
-
-extern struct vvar_data *vvar_data;
-extern int vdso_fix_stick;
-
-static inline unsigned int vvar_read_begin(const struct vvar_data *s)
-{
-	unsigned int ret;
-
-repeat:
-	ret = READ_ONCE(s->seq);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	smp_rmb(); /* Finish all reads before we return seq */
-	return ret;
-}
-
-static inline int vvar_read_retry(const struct vvar_data *s,
-					unsigned int start)
-{
-	smp_rmb(); /* Finish all reads before checking the value of seq */
-	return unlikely(s->seq != start);
-}
-
-static inline void vvar_write_begin(struct vvar_data *s)
-{
-	++s->seq;
-	smp_wmb(); /* Makes sure that increment of seq is reflected */
-}
-
-static inline void vvar_write_end(struct vvar_data *s)
-{
-	smp_wmb(); /* Makes the value of seq current before we increment */
-	++s->seq;
-}
-
-
-#endif /* _ASM_SPARC_VVAR_DATA_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 36f2727e1445..7a063cd4b6d3 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_SPARC32)   += systbls_32.o
 obj-y                   += time_$(BITS).o
 obj-$(CONFIG_SPARC32)   += windows.o
 obj-y                   += cpu.o
-obj-$(CONFIG_SPARC64)	+= vdso.o
 obj-$(CONFIG_SPARC32)   += devices.o
 obj-y                   += ptrace_$(BITS).o
 obj-y                   += unaligned_$(BITS).o
diff --git a/arch/sparc/kernel/vdso.c b/arch/sparc/kernel/vdso.c
deleted file mode 100644
index 0e27437eb97b..000000000000
--- a/arch/sparc/kernel/vdso.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- *  Copyright 2003 Andi Kleen, SuSE Labs.
- *
- *  Thanks to hpa@transmeta.com for some useful hint.
- *  Special thanks to Ingo Molnar for his early experience with
- *  a different vsyscall implementation for Linux/IA32 and for the name.
- */
-
-#include <linux/time.h>
-#include <linux/timekeeper_internal.h>
-
-#include <asm/vvar.h>
-
-void update_vsyscall_tz(void)
-{
-	if (unlikely(vvar_data == NULL))
-		return;
-
-	vvar_data->tz_minuteswest = sys_tz.tz_minuteswest;
-	vvar_data->tz_dsttime = sys_tz.tz_dsttime;
-}
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	struct vvar_data *vdata = vvar_data;
-
-	if (unlikely(vdata == NULL))
-		return;
-
-	vvar_write_begin(vdata);
-	vdata->vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
-	vdata->clock.cycle_last = tk->tkr_mono.cycle_last;
-	vdata->clock.mask = tk->tkr_mono.mask;
-	vdata->clock.mult = tk->tkr_mono.mult;
-	vdata->clock.shift = tk->tkr_mono.shift;
-
-	vdata->wall_time_sec = tk->xtime_sec;
-	vdata->wall_time_snsec = tk->tkr_mono.xtime_nsec;
-
-	vdata->monotonic_time_sec = tk->xtime_sec +
-				    tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_snsec = tk->tkr_mono.xtime_nsec +
-				      (tk->wall_to_monotonic.tv_nsec <<
-				       tk->tkr_mono.shift);
-
-	while (vdata->monotonic_time_snsec >=
-	       (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		vdata->monotonic_time_snsec -=
-				((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		vdata->monotonic_time_sec++;
-	}
-
-	vdata->wall_time_coarse_sec = tk->xtime_sec;
-	vdata->wall_time_coarse_nsec =
-			(long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
-
-	vdata->monotonic_time_coarse_sec =
-		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_coarse_nsec =
-		vdata->wall_time_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-
-	while (vdata->monotonic_time_coarse_nsec >= NSEC_PER_SEC) {
-		vdata->monotonic_time_coarse_nsec -= NSEC_PER_SEC;
-		vdata->monotonic_time_coarse_sec++;
-	}
-
-	vvar_write_end(vdata);
-}
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index fdc4a8f5a49c..e8315c6acb74 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -103,4 +103,4 @@ quiet_cmd_vdso = VDSO    $@
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined -z noexecstack
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 79607804ea1b..8b4773fa782c 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -15,11 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/string.h>
-#include <asm/io.h>
 #include <asm/unistd.h>
-#include <asm/timex.h>
-#include <asm/clocksource.h>
-#include <asm/vvar.h>
+#include <vdso/gettime.h>
 
 #ifdef	CONFIG_SPARC64
 #define SYSCALL_STRING							\
@@ -44,26 +41,9 @@
 	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
 	"cc", "memory"
 
-/*
- * Compute the vvar page's address in the process address space, and return it
- * as a pointer to the vvar_data.
- */
-notrace static __always_inline struct vvar_data *get_vvar_data(void)
-{
-	unsigned long ret;
-
-	/*
-	 * vdso data page is the first vDSO page so grab the PC
-	 * and move up a page to get to the data page.
-	 */
-	__asm__("rd %%pc, %0" : "=r" (ret));
-	ret &= ~(8192 - 1);
-	ret -= 8192;
-
-	return (struct vvar_data *) ret;
-}
-
-notrace static long vdso_fallback_gettime(long clock, struct __kernel_old_timespec *ts)
+#if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
+notrace int
+__vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
 	register long num __asm__("g1") = __NR_clock_gettime;
 	register long o0 __asm__("o0") = clock;
@@ -74,320 +54,51 @@ notrace static long vdso_fallback_gettime(long clock, struct __kernel_old_timesp
 	return o0;
 }
 
-notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
+notrace int
+__vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
 {
-	register long num __asm__("g1") = __NR_gettimeofday;
-	register long o0 __asm__("o0") = (long) tv;
-	register long o1 __asm__("o1") = (long) tz;
+	register long num __asm__("g1") = __NR_clock_gettime64;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
 
 	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
 			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
 	return o0;
 }
 
-#ifdef	CONFIG_SPARC64
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	return val >> amt;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	u64	ret;
-
-	__asm__ __volatile__("rd %%tick, %0" : "=r" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
-{
-	u64	ret;
+int
+clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_gettime64")));
 
-	__asm__ __volatile__("rd %%asr24, %0" : "=r" (ret));
-	return ret;
-}
 #else
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	u64 ret;
-
-	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
-			     "srl %L1, 0, %L1\n\t"
-			     "or %%g1, %L1, %%g1\n\t"
-			     "srlx %%g1, %2, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret)
-			     : "r" (val), "r" (amt)
-			     : "g1");
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	register unsigned long long ret asm("o4");
-
-	__asm__ __volatile__("rd %%tick, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
+notrace int
+__vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	register unsigned long long ret asm("o4");
+	register long num __asm__("g1") = __NR_clock_gettime;
+	register long o0 __asm__("o0") = clock;
+	register long o1 __asm__("o1") = (long) ts;
 
-	__asm__ __volatile__("rd %%asr24, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=r" (ret));
-	return ret;
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
 }
 #endif
 
-notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
-{
-	u64 v;
-	u64 cycles;
-
-	cycles = vread_tick();
-	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
-	return v * vvar->clock.mult;
-}
-
-notrace static __always_inline u64 vgetsns_stick(struct vvar_data *vvar)
-{
-	u64 v;
-	u64 cycles;
-
-	cycles = vread_tick_stick();
-	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
-	return v * vvar->clock.mult;
-}
-
-notrace static __always_inline int do_realtime(struct vvar_data *vvar,
-					       struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->wall_time_sec;
-		ns = vvar->wall_time_snsec;
-		ns += vgetsns(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
-						     struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->wall_time_sec;
-		ns = vvar->wall_time_snsec;
-		ns += vgetsns_stick(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
-						struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->monotonic_time_sec;
-		ns = vvar->monotonic_time_snsec;
-		ns += vgetsns(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
-						      struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->monotonic_time_sec;
-		ns = vvar->monotonic_time_snsec;
-		ns += vgetsns_stick(vvar);
-		ns = __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
-
-	return 0;
-}
-
-notrace static int do_realtime_coarse(struct vvar_data *vvar,
-				      struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->wall_time_coarse_sec;
-		ts->tv_nsec = vvar->wall_time_coarse_nsec;
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-	return 0;
-}
-
-notrace static int do_monotonic_coarse(struct vvar_data *vvar,
-				       struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-
-	do {
-		seq = vvar_read_begin(vvar);
-		ts->tv_sec = vvar->monotonic_time_coarse_sec;
-		ts->tv_nsec = vvar->monotonic_time_coarse_nsec;
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	return 0;
-}
-
-notrace int
-__vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
-{
-	struct vvar_data *vvd = get_vvar_data();
-
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_realtime(vvd, ts);
-	case CLOCK_MONOTONIC:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_monotonic(vvd, ts);
-	case CLOCK_REALTIME_COARSE:
-		return do_realtime_coarse(vvd, ts);
-	case CLOCK_MONOTONIC_COARSE:
-		return do_monotonic_coarse(vvd, ts);
-	}
-	/*
-	 * Unknown clock ID ? Fall back to the syscall.
-	 */
-	return vdso_fallback_gettime(clock, ts);
-}
 int
 clock_gettime(clockid_t, struct __kernel_old_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
-notrace int
-__vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
-{
-	struct vvar_data *vvd = get_vvar_data();
-
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_realtime_stick(vvd, ts);
-	case CLOCK_MONOTONIC:
-		if (unlikely(vvd->vclock_mode == VCLOCK_NONE))
-			break;
-		return do_monotonic_stick(vvd, ts);
-	case CLOCK_REALTIME_COARSE:
-		return do_realtime_coarse(vvd, ts);
-	case CLOCK_MONOTONIC_COARSE:
-		return do_monotonic_coarse(vvd, ts);
-	}
-	/*
-	 * Unknown clock ID ? Fall back to the syscall.
-	 */
-	return vdso_fallback_gettime(clock, ts);
-}
-
 notrace int
 __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	struct vvar_data *vvd = get_vvar_data();
+	register long num __asm__("g1") = __NR_gettimeofday;
+	register long o0 __asm__("o0") = (long) tv;
+	register long o1 __asm__("o1") = (long) tz;
 
-	if (likely(vvd->vclock_mode != VCLOCK_NONE)) {
-		if (likely(tv != NULL)) {
-			union tstv_t {
-				struct __kernel_old_timespec ts;
-				struct __kernel_old_timeval tv;
-			} *tstv = (union tstv_t *) tv;
-			do_realtime(vvd, &tstv->ts);
-			/*
-			 * Assign before dividing to ensure that the division is
-			 * done in the type of tv_usec, not tv_nsec.
-			 *
-			 * There cannot be > 1 billion usec in a second:
-			 * do_realtime() has already distributed such overflow
-			 * into tv_sec.  So we can assign it to an int safely.
-			 */
-			tstv->tv.tv_usec = tstv->ts.tv_nsec;
-			tstv->tv.tv_usec /= 1000;
-		}
-		if (unlikely(tz != NULL)) {
-			/* Avoid memcpy. Some old compilers fail to inline it */
-			tz->tz_minuteswest = vvd->tz_minuteswest;
-			tz->tz_dsttime = vvd->tz_dsttime;
-		}
-		return 0;
-	}
-	return vdso_fallback_gettimeofday(tv, tz);
+	__asm__ __volatile__(SYSCALL_STRING : "=r" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
 }
 int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
-
-notrace int
-__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	struct vvar_data *vvd = get_vvar_data();
-
-	if (likely(vvd->vclock_mode != VCLOCK_NONE)) {
-		if (likely(tv != NULL)) {
-			union tstv_t {
-				struct __kernel_old_timespec ts;
-				struct __kernel_old_timeval tv;
-			} *tstv = (union tstv_t *) tv;
-			do_realtime_stick(vvd, &tstv->ts);
-			/*
-			 * Assign before dividing to ensure that the division is
-			 * done in the type of tv_usec, not tv_nsec.
-			 *
-			 * There cannot be > 1 billion usec in a second:
-			 * do_realtime() has already distributed such overflow
-			 * into tv_sec.  So we can assign it to an int safely.
-			 */
-			tstv->tv.tv_usec = tstv->ts.tv_nsec;
-			tstv->tv.tv_usec /= 1000;
-		}
-		if (unlikely(tz != NULL)) {
-			/* Avoid memcpy. Some old compilers fail to inline it */
-			tz->tz_minuteswest = vvd->tz_minuteswest;
-			tz->tz_dsttime = vvd->tz_dsttime;
-		}
-		return 0;
-	}
-	return vdso_fallback_gettimeofday(tv, tz);
-}
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index 629ab6900df7..f3caa29a331c 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -18,10 +18,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 218930fdff03..cc6cac2429b3 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,10 +17,9 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
+		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index bab7a59575e8..4d88828fc45b 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -19,15 +19,10 @@
 #include <asm/cacheflush.h>
 #include <asm/spitfire.h>
 #include <asm/vdso.h>
-#include <asm/vvar.h>
 #include <asm/page.h>
 
 unsigned int __read_mostly vdso_enabled = 1;
 
-static struct vm_special_mapping vvar_mapping = {
-	.name = "[vvar]"
-};
-
 #ifdef	CONFIG_SPARC64
 static struct vm_special_mapping vdso_mapping64 = {
 	.name = "[vdso]"
@@ -40,207 +35,8 @@ static struct vm_special_mapping vdso_mapping32 = {
 };
 #endif
 
-struct vvar_data *vvar_data;
-
-struct vdso_elfinfo32 {
-	Elf32_Ehdr	*hdr;
-	Elf32_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo64 {
-	Elf64_Ehdr	*hdr;
-	Elf64_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo {
-	union {
-		struct vdso_elfinfo32 elf32;
-		struct vdso_elfinfo64 elf64;
-	} u;
-};
-
-static void *one_section64(struct vdso_elfinfo64 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf64_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs = (void *)e->hdr + e->hdr->e_shoff;
-	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size = shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections64(const struct vdso_image *image, struct vdso_elfinfo *_e)
-{
-	struct vdso_elfinfo64 *e = &_e->u.elf64;
-
-	e->hdr = image->data;
-	e->dynsym = one_section64(e, ".dynsym", &e->dynsymsize);
-	e->dynstr = one_section64(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO64: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf64_Sym *find_sym64(const struct vdso_elfinfo64 *e, const char *name)
-{
-	unsigned int i;
-
-	for (i = 0; i < (e->dynsymsize / sizeof(Elf64_Sym)); i++) {
-		Elf64_Sym *s = &e->dynsym[i];
-		if (s->st_name == 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym64(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo64 *e = &_e->u.elf64;
-	Elf64_Sym *osym = find_sym64(e, orig);
-	Elf64_Sym *nsym = find_sym64(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO64: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value = nsym->st_value;
-	osym->st_size = nsym->st_size;
-	osym->st_info = nsym->st_info;
-	osym->st_other = nsym->st_other;
-	osym->st_shndx = nsym->st_shndx;
-
-	return 0;
-}
-
-static void *one_section32(struct vdso_elfinfo32 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf32_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs = (void *)e->hdr + e->hdr->e_shoff;
-	snames = (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i = 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size = shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections32(const struct vdso_image *image, struct vdso_elfinfo *_e)
-{
-	struct vdso_elfinfo32 *e = &_e->u.elf32;
-
-	e->hdr = image->data;
-	e->dynsym = one_section32(e, ".dynsym", &e->dynsymsize);
-	e->dynstr = one_section32(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO32: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf32_Sym *find_sym32(const struct vdso_elfinfo32 *e, const char *name)
-{
-	unsigned int i;
-
-	for (i = 0; i < (e->dynsymsize / sizeof(Elf32_Sym)); i++) {
-		Elf32_Sym *s = &e->dynsym[i];
-		if (s->st_name == 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym32(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo32 *e = &_e->u.elf32;
-	Elf32_Sym *osym = find_sym32(e, orig);
-	Elf32_Sym *nsym = find_sym32(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO32: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value = nsym->st_value;
-	osym->st_size = nsym->st_size;
-	osym->st_info = nsym->st_info;
-	osym->st_other = nsym->st_other;
-	osym->st_shndx = nsym->st_shndx;
-
-	return 0;
-}
-
-static int find_sections(const struct vdso_image *image, struct vdso_elfinfo *e,
-			 bool elf64)
-{
-	if (elf64)
-		return find_sections64(image, e);
-	else
-		return find_sections32(image, e);
-}
-
-static int patch_one_symbol(struct vdso_elfinfo *e, const char *orig,
-			    const char *new_target, bool elf64)
-{
-	if (elf64)
-		return patchsym64(e, orig, new_target);
-	else
-		return patchsym32(e, orig, new_target);
-}
-
-static int stick_patch(const struct vdso_image *image, struct vdso_elfinfo *e, bool elf64)
-{
-	int err;
-
-	err = find_sections(image, e, elf64);
-	if (err)
-		return err;
-
-	err = patch_one_symbol(e,
-			       "__vdso_gettimeofday",
-			       "__vdso_gettimeofday_stick", elf64);
-	if (err)
-		return err;
-
-	return patch_one_symbol(e,
-				"__vdso_clock_gettime",
-				"__vdso_clock_gettime_stick", elf64);
-	return 0;
-}
-
 /*
- * Allocate pages for the vdso and vvar, and copy in the vdso text from the
+ * Allocate pages for the vdso, and copy in the vdso text from the
  * kernel image.
  */
 static int __init init_vdso_image(const struct vdso_image *image,
@@ -248,16 +44,8 @@ static int __init init_vdso_image(const struct vdso_image *image,
 				  bool elf64)
 {
 	int cnpages = (image->size) / PAGE_SIZE;
-	struct page *dp, **dpp = NULL;
 	struct page *cp, **cpp = NULL;
-	struct vdso_elfinfo ei;
-	int i, dnpages = 0;
-
-	if (tlb_type != spitfire) {
-		int err = stick_patch(image, &ei, elf64);
-		if (err)
-			return err;
-	}
+	int i;
 
 	/*
 	 * First, the vdso text.  This is initialied data, an integral number of
@@ -280,31 +68,6 @@ static int __init init_vdso_image(const struct vdso_image *image,
 		copy_page(page_address(cp), image->data + i * PAGE_SIZE);
 	}
 
-	/*
-	 * Now the vvar page.  This is uninitialized data.
-	 */
-
-	if (vvar_data == NULL) {
-		dnpages = (sizeof(struct vvar_data) / PAGE_SIZE) + 1;
-		if (WARN_ON(dnpages != 1))
-			goto oom;
-		dpp = kcalloc(dnpages, sizeof(struct page *), GFP_KERNEL);
-		vvar_mapping.pages = dpp;
-
-		if (!dpp)
-			goto oom;
-
-		dp = alloc_page(GFP_KERNEL);
-		if (!dp)
-			goto oom;
-
-		dpp[0] = dp;
-		vvar_data = page_address(dp);
-		memset(vvar_data, 0, PAGE_SIZE);
-
-		vvar_data->seq = 0;
-	}
-
 	return 0;
  oom:
 	if (cpp != NULL) {
@@ -316,15 +79,6 @@ static int __init init_vdso_image(const struct vdso_image *image,
 		vdso_mapping->pages = NULL;
 	}
 
-	if (dpp != NULL) {
-		for (i = 0; i < dnpages; i++) {
-			if (dpp[i] != NULL)
-				__free_page(dpp[i]);
-		}
-		kfree(dpp);
-		vvar_mapping.pages = NULL;
-	}
-
 	pr_warn("Cannot allocate vdso\n");
 	vdso_enabled = 0;
 	return -ENOMEM;
@@ -403,21 +157,8 @@ static int map_vdso(const struct vdso_image *image,
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       vdso_mapping);
 
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto up_fail;
-	}
-
-	vma = _install_special_mapping(mm,
-				       addr,
-				       -image->sym_vvar_start,
-				       VM_READ|VM_MAYREAD,
-				       &vvar_mapping);
-
-	if (IS_ERR(vma)) {
+	if (IS_ERR(vma))
 		ret = PTR_ERR(vma);
-		do_munmap(mm, text_start, image->size, NULL);
-	}
 
 up_fail:
 	if (ret)
-- 
2.39.5

