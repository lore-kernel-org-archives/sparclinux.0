From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Tue, 10 Jan 2017 17:57:56 +0000
Subject: [PATCH] sparc: Fixed typo in sstate.c. Replaced panicing with panicking
Message-Id: <1484071076-18359-1-git-send-email-tom.hromatka@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
---
 arch/sparc/kernel/sstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/sstate.c b/arch/sparc/kernel/sstate.c
index c59af54..3caed40 100644
--- a/arch/sparc/kernel/sstate.c
+++ b/arch/sparc/kernel/sstate.c
@@ -43,8 +43,8 @@ static const char poweroff_msg[32] __attribute__((aligned(32)))  	"Linux powering off";
 static const char rebooting_msg[32] __attribute__((aligned(32)))  	"Linux rebooting";
-static const char panicing_msg[32] __attribute__((aligned(32))) -	"Linux panicing";
+static const char panicking_msg[32] __attribute__((aligned(32))) +	"Linux panicking";
 
 static int sstate_reboot_call(struct notifier_block *np, unsigned long type, void *_unused)
 {
@@ -76,7 +76,7 @@ static struct notifier_block sstate_reboot_notifier = {
 
 static int sstate_panic_event(struct notifier_block *n, unsigned long event, void *ptr)
 {
-	do_set_sstate(HV_SOFT_STATE_TRANSITION, panicing_msg);
+	do_set_sstate(HV_SOFT_STATE_TRANSITION, panicking_msg);
 
 	return NOTIFY_DONE;
 }
-- 
2.7.4

