From: Joe Perches <joe@perches.com>
Date: Tue, 25 Aug 2020 04:56:01 +0000
Subject: [PATCH 04/29] sparc: Avoid comma separated statements
Message-Id: <9dade53620b9532ff76a726320a497c67138264c.1598331148.git.joe@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1598331148.git.joe@perches.com>
In-Reply-To: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sparc/kernel/smp_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e286e2badc8a..28c11f7871cd 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -186,8 +186,11 @@ static inline long get_delta (long *rt, long *master)
 		wmb();
 		t1 = tick_ops->get_tick();
 
-		if (t1 - t0 < best_t1 - best_t0)
-			best_t0 = t0, best_t1 = t1, best_tm = tm;
+		if (t1 - t0 < best_t1 - best_t0) {
+			best_t0 = t0;
+			best_t1 = t1;
+			best_tm = tm;
+		}
 	}
 
 	*rt = best_t1 - best_t0;
-- 
2.26.0
