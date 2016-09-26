From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 26 Sep 2016 22:31:38 +0000
Subject: [PATCH v2 2/2] lockdep: Keep the static allocations small for PROVE_LOCKING_SMALL
Message-Id: <1474929098-68914-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1474929098-68914-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org, keescook@chromium.org, dan.j.williams@intel.com, aryabinin@virtuozzo.com, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com

Reduce the size of data structure for lockdep entries half if
PROVE_LOCKING_SMALL if defined. This is used for sparc. This
config variable is disabled by default.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 kernel/locking/lockdep_internals.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 51c4b24..7d364a6 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -54,18 +54,25 @@ enum {
  * table (if it's not there yet), and we check it for lock order
  * conflicts and deadlocks.
  */
+#ifdef CONFIG_PROVE_LOCKING_SMALL
+#define MAX_LOCKDEP_ENTRIES	16384UL
+#define MAX_LOCKDEP_CHAINS_BITS	15
+#define MAX_STACK_TRACE_ENTRIES	262144UL
+#else
 #define MAX_LOCKDEP_ENTRIES	32768UL
 
 #define MAX_LOCKDEP_CHAINS_BITS	16
-#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
-
-#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
 
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
 #define MAX_STACK_TRACE_ENTRIES	524288UL
+#endif
+
+#define MAX_LOCKDEP_CHAINS	(1UL << MAX_LOCKDEP_CHAINS_BITS)
+
+#define MAX_LOCKDEP_CHAIN_HLOCKS (MAX_LOCKDEP_CHAINS*5)
 
 extern struct list_head all_lock_classes;
 extern struct lock_chain lock_chains[];
-- 
1.7.1

