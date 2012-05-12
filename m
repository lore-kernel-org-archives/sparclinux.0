From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:03:20 +0000
Subject: [PATCH] sparc32: Put back SPARC_BRANCH.
Message-Id: <20120512.000320.515901108290483706.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


It's needed for the floppy interrupt trap table patching.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

Tsk tsk, Sam both you and I are naughty for not testing with
BLK_DEV_FD enabled :-)

 arch/sparc/include/asm/traps.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/include/asm/traps.h b/arch/sparc/include/asm/traps.h
index 5fac90f..3aa62dd 100644
--- a/arch/sparc/include/asm/traps.h
+++ b/arch/sparc/include/asm/traps.h
@@ -31,6 +31,13 @@ extern struct tt_entry *sparc_ttable;
 
 #define SPARC_MOV_CONST_L3(const) (0xa6102000 | (const&0xfff))
 
+/* The following assumes that the branch lies before the place we
+ * are branching to.  This is the case for a trap vector...
+ * You have been warned.
+ */
+#define SPARC_BRANCH(dest_addr, inst_addr) \
+          (0x10800000 | (((dest_addr-inst_addr)>>2)&0x3fffff))
+
 #define SPARC_RD_PSR_L0  (0xa1480000)
 #define SPARC_RD_WIM_L3  (0xa7500000)
 #define SPARC_NOP (0x01000000)
-- 
1.7.10

