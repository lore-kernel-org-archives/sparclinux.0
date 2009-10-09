From: David Miller <davem@davemloft.net>
Date: Fri, 09 Oct 2009 07:51:05 +0000
Subject: [PATCH]: Fix niagara2 perf support...
Message-Id: <20091009.005105.93644105.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


While testing today I discovered that the perf IRQ bits for
niagara-2 were wrong, fixes as follows and committed to sparc-2.6:

sparc64: Fix niagara2 perf IRQ bits.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/perf_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index 04db927..fa5936e 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -437,7 +437,7 @@ static const struct sparc_pmu niagara2_pmu = {
 	.lower_shift	= 6,
 	.event_mask	= 0xfff,
 	.hv_bit		= 0x8,
-	.irq_bit	= 0x03,
+	.irq_bit	= 0x30,
 	.upper_nop	= 0x220,
 	.lower_nop	= 0x220,
 };
-- 
1.6.4.4

