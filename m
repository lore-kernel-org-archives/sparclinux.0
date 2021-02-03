From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Wed, 03 Feb 2021 05:36:28 +0000
Subject: [PATCH] sparc: Replace test_ti_thread_flag() with test_tsk_thread_flag()
Message-Id: <1612330588-7026-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Use test_tsk_thread_flag() directly instead of test_ti_thread_flag() to
improve readability when the argument type is struct task_struct, it is
similar with commit 5afc78551bf5 ("arm64: Use test_tsk_thread_flag() for
checking TIF_SINGLESTEP").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/sparc/kernel/process_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index a023637..7649b14 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -183,7 +183,7 @@ void exit_thread(struct task_struct *tsk)
 #ifndef CONFIG_SMP
 	if (last_task_used_math = tsk) {
 #else
-	if (test_ti_thread_flag(task_thread_info(tsk), TIF_USEDFPU)) {
+	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {
 #endif
 		/* Keep process from leaving FPU in a bogon state. */
 		put_psr(get_psr() | PSR_EF);
-- 
2.1.0
