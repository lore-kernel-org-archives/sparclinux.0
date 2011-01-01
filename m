From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 21:00:25 +0000
Subject: [PATCH 2/9] sparc: use trapbase in setup_arch
Message-Id: <1293915632-4596-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

start and trapbase point to the same address.
But using start to assing to sparc_ttable looked confusing.

Replace this with the use of trapbase.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/setup_32.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index b22ce61..648f216 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -185,7 +185,6 @@ static void __init boot_flags_init(char *commands)
 
 extern void sun4c_probe_vac(void);
 extern char cputypval;
-extern unsigned long start, end;
 
 extern unsigned short root_flags;
 extern unsigned short root_dev;
@@ -210,7 +209,7 @@ void __init setup_arch(char **cmdline_p)
 	int i;
 	unsigned long highest_paddr;
 
-	sparc_ttable = (struct tt_entry *) &start;
+	sparc_ttable = (struct tt_entry *) &trapbase;
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-- 
1.6.0.6

