From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 11:03:55 +0000
Subject: [patch] sparc64: make string buffers large enough
Message-Id: <20161125110338.GD5938@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

My static checker complains that if "lvl" is ULONG_MAX (this is 64 bit)
then some of the strings will overflow.  I don't know if that's possible
but it seems simple enough to make the buffers slightly larger.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 4094a51..496fa92 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -85,7 +85,7 @@ static void dump_tl1_traplog(struct tl1_traplog *p)
 
 void bad_trap(struct pt_regs *regs, long lvl)
 {
-	char buffer[32];
+	char buffer[36];
 	siginfo_t info;
 
 	if (notify_die(DIE_TRAP, "bad trap", regs,
@@ -116,7 +116,7 @@ void bad_trap(struct pt_regs *regs, long lvl)
 
 void bad_trap_tl1(struct pt_regs *regs, long lvl)
 {
-	char buffer[32];
+	char buffer[36];
 	
 	if (notify_die(DIE_TRAP_TL1, "bad trap tl1", regs,
 		       0, lvl, SIGTRAP) = NOTIFY_STOP)
