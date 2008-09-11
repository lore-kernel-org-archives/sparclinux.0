From: David Miller <davem@davemloft.net>
Date: Thu, 11 Sep 2008 06:55:49 +0000
Subject: [PATCH 1/3]: sparc32: Call parse_early_param() in setup_arch().
Message-Id: <20080910.235549.136744151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Call parse_early_param() in setup_arch().

Mirror sparc64.  This will allow us to use early_param() on
sparc32 too.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
index f8391c0..24fe307 100644
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -213,6 +213,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
 	strcpy(boot_command_line, *cmdline_p);
+	parse_early_param();
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
-- 
1.5.6.5.GIT

