From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Date: Tue, 04 Dec 2018 22:05:01 +0000
Subject: [tip:core/rcu] sparc/oprofile: Convert timer_stop() to use synchronize_rcu()
Message-Id: <tip-8fa9eb388eb00f7a63caf0fd370f8c134015fc1f@git.kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Commit-ID:  8fa9eb388eb00f7a63caf0fd370f8c134015fc1f
Gitweb:     https://git.kernel.org/tip/8fa9eb388eb00f7a63caf0fd370f8c134015fc1f
Author:     Paul E. McKenney <paulmck@linux.ibm.com>
AuthorDate: Tue, 30 Oct 2018 15:45:04 -0700
Committer:  Paul E. McKenney <paulmck@linux.ibm.com>
CommitDate: Thu, 8 Nov 2018 21:43:20 -0800

sparc/oprofile: Convert timer_stop() to use synchronize_rcu()

Now that synchronize_rcu() waits for preempt-disable regions of code
in addition to explicitly marked RCU read-side critical sections,
synchronize_rcu() can be used in place of synchronize_sched().  This
commit therefore makes that change.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: <oprofile-list@lists.sf.net>
Cc: <sparclinux@vger.kernel.org>
---
 arch/sparc/oprofile/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/oprofile/init.c b/arch/sparc/oprofile/init.c
index f9024bccff16..43730c9b1c86 100644
--- a/arch/sparc/oprofile/init.c
+++ b/arch/sparc/oprofile/init.c
@@ -53,7 +53,7 @@ static void timer_stop(void)
 {
 	nmi_adjust_hz(1);
 	unregister_die_notifier(&profile_timer_exceptions_nb);
-	synchronize_sched();  /* Allow already-started NMIs to complete. */
+	synchronize_rcu();  /* Allow already-started NMIs to complete. */
 }
 
 static int op_nmi_timer_init(struct oprofile_operations *ops)
