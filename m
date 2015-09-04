From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 04 Sep 2015 03:07:44 +0000
Subject: [[PATCH v6 01/10] sparc/perf: Remove unnecessary assignment
Message-Id: <1441336073-22750-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

In ->commit_txn() 'cpuc' is already initialized when it is
declared, so we can remove the duplicate assignment.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/sparc/kernel/perf_event.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 689db65..e3f89c7 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1528,7 +1528,6 @@ static int sparc_pmu_commit_txn(struct pmu *pmu)
 	if (!sparc_pmu)
 		return -EINVAL;
 
-	cpuc = this_cpu_ptr(&cpu_hw_events);
 	n = cpuc->n_events;
 	if (check_excludes(cpuc->event, 0, n))
 		return -EINVAL;
-- 
1.7.9.5

