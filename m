From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 07:18:15 +0000
Subject: [PATCH] sparc32: Remove sparc_cpu_model read from floppy interrupt handler.
Message-Id: <20120512.031815.2111172851741639254.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Since we no longer test the cpu model value, no need to load
it into a register any more.

It just gets overwritten in the next instruction anyways. :-)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 5e75799..d7143ba 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -123,8 +123,6 @@ floppy_tdone:
 	set	auxio_register, %l7
 	ld	[%l7], %l7
 
-	set	sparc_cpu_model, %l5
-	ld	[%l5], %l5
 	ldub	[%l7], %l5
 
 	or	%l5, 0xc2, %l5
-- 
1.7.10

