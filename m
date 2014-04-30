From: David Miller <davem@davemloft.net>
Date: Wed, 30 Apr 2014 21:55:21 +0000
Subject: [PATCH 06/10] sparc64: Handle 32-bit tasks properly in compute_effective_address().
Message-Id: <20140430.175521.2009812810930274468.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If we have a 32-bit task we must chop off the top 32-bits of the
64-bit value just as the cpu would.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/unaligned_64.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 3c1a7cb..35ab8b6 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -166,17 +166,23 @@ static unsigned long *fetch_reg_addr(unsigned int reg, struct pt_regs *regs)
 unsigned long compute_effective_address(struct pt_regs *regs,
 					unsigned int insn, unsigned int rd)
 {
+	int from_kernel = (regs->tstate & TSTATE_PRIV) != 0;
 	unsigned int rs1 = (insn >> 14) & 0x1f;
 	unsigned int rs2 = insn & 0x1f;
-	int from_kernel = (regs->tstate & TSTATE_PRIV) != 0;
+	unsigned long addr;
 
 	if (insn & 0x2000) {
 		maybe_flush_windows(rs1, 0, rd, from_kernel);
-		return (fetch_reg(rs1, regs) + sign_extend_imm13(insn));
+		addr = (fetch_reg(rs1, regs) + sign_extend_imm13(insn));
 	} else {
 		maybe_flush_windows(rs1, rs2, rd, from_kernel);
-		return (fetch_reg(rs1, regs) + fetch_reg(rs2, regs));
+		addr = (fetch_reg(rs1, regs) + fetch_reg(rs2, regs));
 	}
+
+	if (!from_kernel && test_thread_flag(TIF_32BIT))
+		addr &= 0xffffffff;
+
+	return addr;
 }
 
 /* This is just to make gcc think die_if_kernel does return... */
-- 
1.8.1.2

