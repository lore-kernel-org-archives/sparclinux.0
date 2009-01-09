From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jan 2009 00:54:24 +0000
Subject: another branch tracer warning fix
Message-Id: <20090108.165424.04054951.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just commited the following to fix a warning with
gcc-4.1.3 with sparc64 allmodconfig.

sparc: Most unaligned_64.c tweaks for branch tracer warnings.

arch/sparc/kernel/unaligned_64.c: In function 'handle_lddfmna':
arch/sparc/kernel/unaligned_64.c:592: warning: 'second' may be used uninitialized in this function

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/unaligned_64.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index f164d5a..3792099 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -589,7 +589,6 @@ void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 	unsigned long pc = regs->tpc;
 	unsigned long tstate = regs->tstate;
 	u32 insn;
-	u32 first, second;
 	u64 value;
 	u8 freg;
 	int flag;
@@ -601,19 +600,20 @@ void handle_lddfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr
 		pc = (u32)pc;
 	if (get_user(insn, (u32 __user *) pc) != -EFAULT) {
 		int asi = decode_asi(insn, regs);
+		u32 first, second;
 		int err;
 
 		if ((asi > ASI_SNFL) ||
 		    (asi < ASI_P))
 			goto daex;
+		first = second = 0;
 		err = get_user(first, (u32 __user *)sfar);
 		if (!err)
 			err = get_user(second, (u32 __user *)(sfar + 4));
 		if (err) {
-			if (asi & 0x2) /* NF */ {
-				first = 0; second = 0;
-			} else
+			if (!(asi & 0x2))
 				goto daex;
+			first = second = 0;
 		}
 		save_and_clear_fpu();
 		freg = ((insn >> 25) & 0x1e) | ((insn >> 20) & 0x20);
-- 
1.6.1.15.g159c88

