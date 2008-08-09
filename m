From: Friedrich Oslage <bluebird@gentoo.org>
Date: Sat, 09 Aug 2008 12:31:44 +0000
Subject: [PATCH] Only call smp_fetch_global_regs if CONFIG_MAGIC_SYSRQ is
Message-Id: <20080809123144.GA2024@v32062.1blu.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64: Only call smp_fetch_global_regs if CONFIG_MAGIC_SYSRQ is set

Fixes this build error:
  arch/sparc64/kernel/built-in.o: In function `__trigger_all_cpu_backtrace':
  (.text+0xa88): undefined reference to `smp_fetch_global_regs'

Signed-off-by: Friedrich Oslage <bluebird@gentoo.org>
---
 arch/sparc64/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/process.c b/arch/sparc64/kernel/process.c
index 7f5debd..71d5ea7 100644
--- a/arch/sparc64/kernel/process.c
+++ b/arch/sparc64/kernel/process.c
@@ -311,7 +311,9 @@ void __trigger_all_cpu_backtrace(void)

 	__global_reg_self(tp, regs, this_cpu);

+#ifdef CONFIG_MAGIC_SYSRQ
 	smp_fetch_global_regs();
+#endif

 	for_each_online_cpu(cpu) {
 		struct global_reg_snapshot *gp = &global_reg_snapshot[cpu];
