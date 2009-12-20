From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Sun, 20 Dec 2009 12:16:35 +0000
Subject: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix warnings which become build errors since -Werror is used.
arch/sparc/kernel/us3_cpufreq.c:60: error: 'ret' may be used uninitialized in this function
arch/sparc/kernel/us3_cpufreq.c:101: error: 'new_bits' may be used uninitialized in this function

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 arch/sparc/kernel/us3_cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/us3_cpufreq.c b/arch/sparc/kernel/us3_cpufreq.c
index 365b646..7eb12fc 100644
--- a/arch/sparc/kernel/us3_cpufreq.c
+++ b/arch/sparc/kernel/us3_cpufreq.c
@@ -57,7 +57,7 @@ static void write_safari_cfg(unsigned long val)
 static unsigned long get_current_freq(unsigned int cpu, unsigned long safari_cfg)
 {
 	unsigned long clock_tick = sparc64_get_clock_tick(cpu) / 1000;
-	unsigned long ret;
+	unsigned long ret = 0;
 
 	switch (safari_cfg & SAFARI_CFG_DIV_MASK) {
 	case SAFARI_CFG_DIV_1:
@@ -98,7 +98,7 @@ static unsigned int us3_freq_get(unsigned int cpu)
 
 static void us3_set_cpu_divider_index(unsigned int cpu, unsigned int index)
 {
-	unsigned long new_bits, new_freq, reg;
+	unsigned long new_bits = 0, new_freq, reg;
 	cpumask_t cpus_allowed;
 	struct cpufreq_freqs freqs;
 
-- 
1.6.6.rc3

