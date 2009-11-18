From: Jiri Slaby <jslaby@novell.com>
Date: Wed, 18 Nov 2009 14:51:52 +0000
Subject: [PATCH 06/16] SPARC: use ACCESS_ONCE for rlimits
Message-Id: <1258555922-2064-6-git-send-email-jslaby@novell.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4B040A03.2020508@gmail.com>
In-Reply-To: <4B040A03.2020508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jirislaby@gmail.com
Cc: mingo@elte.hu, nhorman@tuxdriver.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, marcin.slusarz@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org, Jiri Slaby <jslaby@novell.com>, James Morris <jmorris@namei.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Make sure compiler won't do weird things with limits. E.g. fetching
them twice may return 2 different values after writable limits are
implemented.

Signed-off-by: Jiri Slaby <jslaby@novell.com>
Cc: James Morris <jmorris@namei.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/sys_sparc_64.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index e2d1024..004ed47 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -361,6 +361,7 @@ EXPORT_SYMBOL(get_fb_unmapped_area);
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
+	unsigned long gap;
 
 	if (current->flags & PF_RANDOMIZE) {
 		random_factor = get_random_int();
@@ -375,9 +376,10 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	 * Fall back to the standard layout if the personality
 	 * bit is set, or if the expected stack growth is unlimited:
 	 */
+	gap = ACCESS_ONCE(current->signal->rlim[RLIMIT_STACK].rlim_cur);
 	if (!test_thread_flag(TIF_32BIT) ||
 	    (current->personality & ADDR_COMPAT_LAYOUT) ||
-	    current->signal->rlim[RLIMIT_STACK].rlim_cur = RLIM_INFINITY ||
+	    gap = RLIM_INFINITY ||
 	    sysctl_legacy_va_layout) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
 		mm->get_unmapped_area = arch_get_unmapped_area;
@@ -385,9 +387,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 	} else {
 		/* We know it's 32-bit */
 		unsigned long task_size = STACK_TOP32;
-		unsigned long gap;
 
-		gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
 		if (gap < 128 * 1024 * 1024)
 			gap = 128 * 1024 * 1024;
 		if (gap > (task_size / 6 * 5))
-- 
1.6.4.2

