From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:47 +0000
Subject: [PATCH 8/8] sparc: Several small VDSO vclock_gettime.c improvements.
Message-Id: <20181022.191947.433390161190289530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Almost entirely borrowed from the x86 code.

Main improvement is to avoid having to initialize
ts->tv_nsec to zero before the sequence loops, by
expanding timespec_add_ns().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/vclock_gettime.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 7b5bf63fc0f5..7b539ceebe13 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -138,7 +138,6 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 	unsigned long seq;
 	u64 ns;
 
-	ts->tv_nsec = 0;
 	do {
 		seq = vvar_read_begin(vvar);
 		ts->tv_sec = vvar->wall_time_sec;
@@ -147,7 +146,8 @@ notrace static __always_inline int do_realtime(struct vvar_data *vvar,
 		ns >>= vvar->clock.shift;
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
-	timespec_add_ns(ts, ns);
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
 
 	return 0;
 }
@@ -158,7 +158,6 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 	unsigned long seq;
 	u64 ns;
 
-	ts->tv_nsec = 0;
 	do {
 		seq = vvar_read_begin(vvar);
 		ts->tv_sec = vvar->monotonic_time_sec;
@@ -167,7 +166,8 @@ notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 		ns >>= vvar->clock.shift;
 	} while (unlikely(vvar_read_retry(vvar, seq)));
 
-	timespec_add_ns(ts, ns);
+	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
 
 	return 0;
 }
-- 
2.19.1.328.g5a0cc8aca
