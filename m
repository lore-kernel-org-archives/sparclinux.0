From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:29 +0000
Subject: [PATCH 2/8] sparc: Inline VDSO gettime code aggressively.
Message-Id: <20181022.191929.1565624051461192696.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


One interesting thing we need to do is stop using
__builtin_return_address() in get_vvar_data().

Simply read the %pc register instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/vclock_gettime.c | 39 ++++++++++++++------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index a0c8a4b008d5..75c49fcb57aa 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -60,24 +60,22 @@
  * Compute the vvar page's address in the process address space, and return it
  * as a pointer to the vvar_data.
  */
-static notrace noinline struct vvar_data *
-get_vvar_data(void)
+notrace static __always_inline struct vvar_data *get_vvar_data(void)
 {
 	unsigned long ret;
 
 	/*
-	 * vdso data page is the first vDSO page so grab the return address
+	 * vdso data page is the first vDSO page so grab the PC
 	 * and move up a page to get to the data page.
 	 */
-	ret = (unsigned long)__builtin_return_address(0);
+	__asm__("rd %%pc, %0" : "=r" (ret));
 	ret &= ~(8192 - 1);
 	ret -= 8192;
 
 	return (struct vvar_data *) ret;
 }
 
-static notrace long
-vdso_fallback_gettime(long clock, struct timespec *ts)
+notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	register long num __asm__("g1") = __NR_clock_gettime;
 	register long o0 __asm__("o0") = clock;
@@ -88,8 +86,7 @@ vdso_fallback_gettime(long clock, struct timespec *ts)
 	return o0;
 }
 
-static notrace __always_inline long
-vdso_fallback_gettimeofday(struct timeval *tv, struct timezone *tz)
+notrace static long vdso_fallback_gettimeofday(struct timeval *tv, struct timezone *tz)
 {
 	register long num __asm__("g1") = __NR_gettimeofday;
 	register long o0 __asm__("o0") = (long) tv;
@@ -101,8 +98,8 @@ vdso_fallback_gettimeofday(struct timeval *tv, struct timezone *tz)
 }
 
 #ifdef	CONFIG_SPARC64
-static notrace noinline u64
-vread_tick(void) {
+notrace static __always_inline u64 vread_tick(void)
+{
 	u64	ret;
 
 	__asm__ __volatile__("1:\n\t"
@@ -118,8 +115,7 @@ vread_tick(void) {
 	return ret & ~TICK_PRIV_BIT;
 }
 #else
-static notrace noinline u64
-vread_tick(void)
+notrace static __always_inline u64 vread_tick(void)
 {
 	register unsigned long long ret asm("o4");
 
@@ -138,8 +134,7 @@ vread_tick(void)
 }
 #endif
 
-static notrace inline u64
-vgetsns(struct vvar_data *vvar)
+notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 {
 	u64 v;
 	u64 cycles;
@@ -149,8 +144,8 @@ vgetsns(struct vvar_data *vvar)
 	return v * vvar->clock.mult;
 }
 
-static notrace noinline int
-do_realtime(struct vvar_data *vvar, struct timespec *ts)
+notrace static __always_inline int do_realtime(struct vvar_data *vvar,
+					       struct timespec *ts)
 {
 	unsigned long seq;
 	u64 ns;
@@ -169,8 +164,8 @@ do_realtime(struct vvar_data *vvar, struct timespec *ts)
 	return 0;
 }
 
-static notrace noinline int
-do_monotonic(struct vvar_data *vvar, struct timespec *ts)
+notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
+						struct timespec *ts)
 {
 	unsigned long seq;
 	u64 ns;
@@ -189,8 +184,8 @@ do_monotonic(struct vvar_data *vvar, struct timespec *ts)
 	return 0;
 }
 
-static notrace noinline int
-do_realtime_coarse(struct vvar_data *vvar, struct timespec *ts)
+notrace static int do_realtime_coarse(struct vvar_data *vvar,
+				      struct timespec *ts)
 {
 	unsigned long seq;
 
@@ -202,8 +197,8 @@ do_realtime_coarse(struct vvar_data *vvar, struct timespec *ts)
 	return 0;
 }
 
-static notrace noinline int
-do_monotonic_coarse(struct vvar_data *vvar, struct timespec *ts)
+notrace static int do_monotonic_coarse(struct vvar_data *vvar,
+				       struct timespec *ts)
 {
 	unsigned long seq;
 
-- 
2.19.1.328.g5a0cc8aca
