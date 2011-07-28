From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 08:43:56 +0000
Subject: [PATCH 1/6] sparc: Don't leave sparc_pmu_type NULL on sun4v.
Message-Id: <20110728.014356.1530624973246806461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Otherwise we'll crash in the sparc perf init code.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/cpu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 138dbbc..70f035c 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -479,6 +479,7 @@ static void __init sun4v_cpu_probe(void)
 		       prom_cpu_compatible);
 		sparc_cpu_type = "Unknown SUN4V CPU";
 		sparc_fpu_type = "Unknown SUN4V FPU";
+		sparc_pmu_type = "Unknown SUN4V PMU";
 		break;
 	}
 }
-- 
1.7.2.5

