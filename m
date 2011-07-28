From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 08:44:08 +0000
Subject: [PATCH 3/6] sparc: Don't do expensive hypervisor PCR write unless
Message-Id: <20110728.014408.248863901086746033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The hypervisor call is only necessary if hypervisor events are
being requested.

So if we're not tracking hypervisor events, simply do a direct
register write.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/pcr.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index 8ac23e6..878c682 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -80,8 +80,11 @@ static void n2_pcr_write(u64 val)
 {
 	unsigned long ret;
 
-	ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
-	if (ret != HV_EOK)
+	if (val & PCR_N2_HTRACE) {
+		ret = sun4v_niagara2_setperf(HV_N2_PERF_SPARC_CTL, val);
+		if (ret != HV_EOK)
+			write_pcr(val);
+	} else
 		write_pcr(val);
 }
 
-- 
1.7.2.5

