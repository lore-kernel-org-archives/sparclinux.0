From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:19:45 +0000
Subject: [PATCH 036/493] sparc: remove use of __devexit_p
Message-Id: <1353349642-3677-36-git-send-email-wfp5p@virginia.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: "David S. Miller" <davem@davemloft.net> 
Cc: sparclinux@vger.kernel.org 
---
 arch/sparc/include/asm/parport.h | 2 +-
 arch/sparc/kernel/chmc.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index cb33608..8c0bce4 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -242,7 +242,7 @@ static struct platform_driver ecpp_driver = {
 		.of_match_table = ecpp_match,
 	},
 	.probe			= ecpp_probe,
-	.remove			= __devexit_p(ecpp_remove),
+	.remove			= ecpp_remove,
 };
 
 static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 5f45026..af189fe 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -814,7 +814,7 @@ static struct platform_driver us3mc_driver = {
 		.of_match_table = us3mc_match,
 	},
 	.probe		= us3mc_probe,
-	.remove		= __devexit_p(us3mc_remove),
+	.remove		= us3mc_remove,
 };
 
 static inline bool us3mc_platform(void)
-- 
1.8.0

