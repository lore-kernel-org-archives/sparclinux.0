From: Cristian Marussi <cristian.marussi@arm.com>
Date: Fri, 13 Sep 2019 18:19:48 +0000
Subject: [RFC PATCH v2 07/12] arm64: smp: add arch specific cpu parking helper
Message-Id: <20190913181953.45748-8-cristian.marussi@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190913181953.45748-1-cristian.marussi@arm.com>
In-Reply-To: <20190913181953.45748-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org, mingo@redhat.com, x86@kernel.org, dzickus@redhat.com, ehabkost@redhat.com, linux@armlinux.org.uk, davem@davemloft.net, sparclinux@vger.kernel.org, hch@infradead.org

Add an arm64 specific helper which parks the cpu in a more architecture
efficient way.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm64/kernel/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f0cc2bf84aaa..539e8db5c1ba 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -947,6 +947,12 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
+void arch_smp_cpu_park(void)
+{
+	while (1)
+		cpu_park_loop();
+}
+
 void arch_smp_cpus_stop_complete(void)
 {
 	sdei_mask_local_cpu();
-- 
2.17.1
