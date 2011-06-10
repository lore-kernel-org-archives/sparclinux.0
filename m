From: Mathias Krause <minipli@googlemail.com>
Date: Fri, 10 Jun 2011 13:10:53 +0000
Subject: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <1307711453-17412-1-git-send-email-minipli@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
In-Reply-To: <BANLkTinv1teZEHMK0qymaVdcxPOErpqSyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

The address limit is already set in flush_old_exec() so this
assignment of USER_DS is redundant.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 arch/sparc/kernel/process_32.c |    3 +--
 arch/sparc/kernel/process_64.c |    3 ---
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index c8cc461..f793742 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -380,8 +380,7 @@ void flush_thread(void)
 #endif
 	}
 
-	/* Now, this task is no longer a kernel thread. */
-	current->thread.current_ds = USER_DS;
+	/* This task is no longer a kernel thread. */
 	if (current->thread.flags & SPARC_FLAG_KTHREAD) {
 		current->thread.flags &= ~SPARC_FLAG_KTHREAD;
 
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index c158a95..d959cd0 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -368,9 +368,6 @@ void flush_thread(void)
 
 	/* Clear FPU register state. */
 	t->fpsaved[0] = 0;
-	
-	if (get_thread_current_ds() != ASI_AIUS)
-		set_fs(USER_DS);
 }
 
 /* It's a bit more tricky when 64-bit tasks are involved... */
-- 
1.5.6.5

