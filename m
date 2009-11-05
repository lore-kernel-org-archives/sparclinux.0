From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 05 Nov 2009 16:40:44 +0000
Subject: [PATCH] sparc,sparc64: replace parentheses in pmul()
Message-Id: <4AF3000C.8080607@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

`>>' has a higher precedence than `?' so src2 evaluated to
either 16 or 0 dependent on the bits set in rs2.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/sparc/kernel/visemul.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I am not 100% sure that the code was incorrect, however, if it
was intended I think it is a very strange way to write it.

Roel

diff --git a/arch/sparc/kernel/visemul.c b/arch/sparc/kernel/visemul.c
index b956fd7..d231cbd 100644
--- a/arch/sparc/kernel/visemul.c
+++ b/arch/sparc/kernel/visemul.c
@@ -617,7 +617,7 @@ static void pmul(struct pt_regs *regs, unsigned int insn, unsigned int opf)
 		rs2 = fps_regval(f, RS2(insn));
 
 		rd_val = 0;
-		src2 = (rs2 >> (opf = FMUL8x16AU_OPF) ? 16 : 0);
+		src2 = rs2 >> (opf = FMUL8x16AU_OPF ? 16 : 0);
 		for (byte = 0; byte < 4; byte++) {
 			u16 src1 = (rs1 >> (byte * 8)) & 0x00ff;
 			u32 prod = src1 * src2;
