From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 17:17:14 +0000
Subject: [PATCH v2] sparc64: shut down to OBP correctly
Message-Id: <1482340634-65842-1-git-send-email-larry.bassel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The command "shutdown -h -H now" should shut down the system to
OBP, however the machine was incorrectly being powered off instead
(on both LDOM and bare metal).

The "exit" command to the OBP must be run and then a hard
loop to prevent return to the kernel.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 arch/sparc/prom/misc_64.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index 53a696d..aa80788 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -115,16 +115,11 @@ void notrace prom_halt(void)
 {
 	unsigned long args[3];
 
-#ifdef CONFIG_SUN_LDOMS
-	if (ldom_domaining_enabled)
-		ldom_power_off();
-#endif
-again:
 	args[0] = (unsigned long) "exit";
 	args[1] = 0;
 	args[2] = 0;
 	p1275_cmd_direct(args);
-	goto again; /* PROM is out to get me -DaveM */
+	while (1);
 }
 
 void prom_halt_power_off(void)
-- 
1.7.1

