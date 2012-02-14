From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 14 Feb 2012 11:41:05 +0000
Subject: [PATCH 32/40] sparc: Use block_sigmask()
Message-Id: <1329219673-28711-33-git-send-email-matt@console-pimps.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

Use the new helper function introduced in commit 5e6292c0f28f
("signal: add block_sigmask() for adding sigmask to current->blocked")
which centralises the code for updating current->blocked after
successfully delivering a signal and reduces the amount of duplicate
code across architectures. In the past some architectures got this
code wrong, so using this helper function should stop that from
happening again.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 arch/sparc/kernel/signal32.c  |    7 +------
 arch/sparc/kernel/signal_32.c |    7 +------
 arch/sparc/kernel/signal_64.c |    6 +-----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 023b886..c8f5b50 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -776,7 +776,6 @@ static inline int handle_signal32(unsigned long signr, struct k_sigaction *ka,
 				  siginfo_t *info,
 				  sigset_t *oldset, struct pt_regs *regs)
 {
-	sigset_t blocked;
 	int err;
 
 	if (ka->sa.sa_flags & SA_SIGINFO)
@@ -787,11 +786,7 @@ static inline int handle_signal32(unsigned long signr, struct k_sigaction *ka,
 	if (err)
 		return err;
 
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&blocked, signr);
-	set_current_blocked(&blocked);
-
+	block_sigmask(ka, signr);
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
 	return 0;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index d54c6e5..7bb71b6 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -465,7 +465,6 @@ static inline int
 handle_signal(unsigned long signr, struct k_sigaction *ka,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
-	sigset_t blocked;
 	int err;
 
 	if (ka->sa.sa_flags & SA_SIGINFO)
@@ -476,11 +475,7 @@ handle_signal(unsigned long signr, struct k_sigaction *ka,
 	if (err)
 		return err;
 
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&blocked, signr);
-	set_current_blocked(&blocked);
-
+	block_sigmask(ka, signr);
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
 	return 0;
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index f0836cd..d8a67e6 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -479,18 +479,14 @@ static inline int handle_signal(unsigned long signr, struct k_sigaction *ka,
 				siginfo_t *info,
 				sigset_t *oldset, struct pt_regs *regs)
 {
-	sigset_t blocked;
 	int err;
 
 	err = setup_rt_frame(ka, regs, signr, oldset,
 			     (ka->sa.sa_flags & SA_SIGINFO) ? info : NULL);
 	if (err)
 		return err;
-	sigorsets(&blocked, &current->blocked, &ka->sa.sa_mask);
-	if (!(ka->sa.sa_flags & SA_NOMASK))
-		sigaddset(&blocked, signr);
-	set_current_blocked(&blocked);
 
+	block_sigmask(ka, signr);
 	tracehook_signal_handler(signr, info, ka, regs, 0);
 
 	return 0;
-- 
1.7.4.4

