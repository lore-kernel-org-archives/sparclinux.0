From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 01 Feb 2011 18:03:43 +0000
Subject: [PATCH] sparc32: unaligned memory access (MNA) trap handler bug
Message-Id: <1296583423-5469-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Since the merge process of the sparc and sparc64 the sparc32
MNA trap handler does not emulate stores to unaligned addresses
correctly. MNA operation from both from kernel and user space
are affected.

A typical effect of this bug is nr_frags in skbs are overwritten
during buffer copying/checksum-calculation, or maximally 6 bytes
of data in the network buffer will be overwitten with garbage.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/una_asm_32.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/una_asm_32.S b/arch/sparc/kernel/una_asm_32.S
index 8cc0345..8f096e8 100644
--- a/arch/sparc/kernel/una_asm_32.S
+++ b/arch/sparc/kernel/una_asm_32.S
@@ -24,9 +24,9 @@ retl_efault:
 	.globl	__do_int_store
 __do_int_store:
 	ld	[%o2], %g1
-	cmp	%1, 2
+	cmp	%o1, 2
 	be	2f
-	 cmp	%1, 4
+	 cmp	%o1, 4
 	be	1f
 	 srl	%g1, 24, %g2
 	srl	%g1, 16, %g7
-- 
1.5.4

