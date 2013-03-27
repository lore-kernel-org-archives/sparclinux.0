From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Wed, 27 Mar 2013 12:20:45 +0000
Subject: [PATCH] sparc:remove unused declaration smp_boot_cpus()
Message-Id: <5152E41D.2030901@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

smp_boot_cpus() was replaced smp_prepare_cpus() long ago, and it no
longer needed, so delete it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sparc/include/asm/smp_32.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index b73da3c..68503d3 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -46,7 +46,6 @@ void sun4m_init_smp(void);
 void sun4d_init_smp(void);

 void smp_callin(void);
-void smp_boot_cpus(void);
 void smp_store_cpu_info(int);

 void smp_resched_interrupt(void);
-- 
1.6.0.2

