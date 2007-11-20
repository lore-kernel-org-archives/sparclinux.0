From: Joe Perches <joe@perches.com>
Date: Tue, 20 Nov 2007 01:47:59 +0000
Subject: [PATCH 07/59] arch/sparc64: Add missing "space"
Message-Id: <2cb1c8daa0f34a5506b88cf5b350660896c8a45b.1195454434.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: 1234567
 <1195523331-15303-1-git-send-email-joe@perches.com>
 <1195523331-15303-2-git-send-email-joe@perches.com>
 <1195523331-15303-3-git-send-email-joe@perches.com>
 <1195523331-15303-4-git-send-email-joe@perches.com>
 <1195523331-15303-5-git-send-email-joe@perches.com>
 <1195523331-15303-6-git-send-email-joe@perches.com>
 <1195523331-15303-7-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-7-git-send-email-joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc64/kernel/smp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 7cd8d94..894b506 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -236,8 +236,9 @@ void smp_synchronize_tick_client(void)
 		       t[i].rt, t[i].master, t[i].diff, t[i].lat);
 #endif
 
-	printk(KERN_INFO "CPU %d: synchronized TICK with master CPU (last diff %ld cycles,"
-	       "maxerr %lu cycles)\n", smp_processor_id(), delta, rt);
+	printk(KERN_INFO "CPU %d: synchronized TICK with master CPU "
+	       "(last diff %ld cycles, maxerr %lu cycles)\n",
+	       smp_processor_id(), delta, rt);
 }
 
 static void smp_start_sync_tick_client(int cpu);
-- 
1.5.3.5.652.gf192c

