From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 04:52:07 +0000
Subject: [PATCH] sparc32: Remove unused empty_bad_page{,_table} declarations.
Message-Id: <20120520.005207.1076594593651420182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/setup.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 84a8a49..8a83699 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -21,8 +21,6 @@ extern char reboot_command[];
  */
 extern unsigned char boot_cpu_id;
 
-extern unsigned long empty_bad_page;
-extern unsigned long empty_bad_page_table;
 extern unsigned long empty_zero_page;
 
 extern int serial_console;
-- 
1.7.10

