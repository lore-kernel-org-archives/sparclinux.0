From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:56:00 +0000
Subject: [PATCH 10/10]: sparc64: Fix clock event multiplier printf format.
Message-Id: <20091211.225600.48525530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The type got changed to u32, so %lx generated warnings
(and thus build failure on sparc64)

Stephen Rothwell fixed it like so:

-	printk("clockevent: mult[%lx] shift[%d]\n",
+	printk("clockevent: mult[%ux] shift[%d]\n",

But that's not a valid transformation, we now get:

clockevent: mult[51539607x] shift[32]

in the logs.

Fix it to use the correct plain "%x" instead.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/time_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index c310875..67e1651 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -827,7 +827,7 @@ void __init time_init(void)
 	sparc64_clockevent.min_delta_ns  		clockevent_delta2ns(0xF, &sparc64_clockevent);
 
-	printk("clockevent: mult[%ux] shift[%d]\n",
+	printk("clockevent: mult[%x] shift[%d]\n",
 	       sparc64_clockevent.mult, sparc64_clockevent.shift);
 
 	setup_sparc64_timer();
-- 
1.6.5

