From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Date: Sun, 11 Nov 2018 19:43:35 +0000
Subject: [PATCH tip/core/rcu 06/41] sparc/oprofile: Convert timer_stop() to use synchronize_rcu()
Message-Id: <20181111194410.6368-6-paulmck@linux.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181111194104.GA4787@linux.ibm.com>
In-Reply-To: <20181111194104.GA4787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Robert Richter <rric@kernel.org>, "David S. Miller" <davem@davemloft.net>, oprofile-list@lists.sf.net, sparclinux@vger.kernel.org

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
-- 
2.17.1
