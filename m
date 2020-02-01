From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 01 Feb 2020 21:20:52 +0000
Subject: [PATCH] sparc64: fix adjtimex regression
Message-Id: <20200201212104.575657-1-arnd@arndb.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Anatoly Pugachev <matorola@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Deepa Dinamani <deepa.kernel@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Anatoly Pugachev reported one of the y2038 patches to introduce
a fatal bug from a stupid typo:

[   96.384129] watchdog: BUG: soft lockup - CPU#8 stuck for 22s!
...
[   96.385624]  [0000000000652ca4] handle_mm_fault+0x84/0x320
[   96.385668]  [0000000000b6f2bc] do_sparc64_fault+0x43c/0x820
[   96.385720]  [0000000000407754] sparc64_realfault_common+0x10/0x20
[   96.385769]  [000000000042fa28] __do_sys_sparc_clock_adjtime+0x28/0x80
[   96.385819]  [00000000004307f0] sys_sparc_clock_adjtime+0x10/0x20
[   96.385866]  [0000000000406294] linux_sparc_syscall+0x34/0x44

Fix the code to dereference the correct pointer again.

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Tested-by: Anatoly Pugachev <matorola@gmail.com>
Fixes: 251ec1c159e4 ("y2038: sparc: remove use of struct timex")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The bug was introduced through my y2038 branch and is now in
mainline, but not in v5.5. Who should pick up the fix to
get it into v5.6-rc1?
---
 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 34917617f258..6b92fadb6ec7 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -551,7 +551,7 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;
-	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+	struct __kernel_old_timeval *tv = (void *)&txc.time;
 	int ret;
 
 	/* Copy the user data space into the kernel copy
@@ -576,7 +576,7 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,
 		struct __kernel_timex __user *, txc_p)
 {
 	struct __kernel_timex txc;
-	struct __kernel_old_timeval *tv = (void *)&txc_p->time;
+	struct __kernel_old_timeval *tv = (void *)&txc.time;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-- 
2.25.0
