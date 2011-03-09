From: Ben Hutchings <ben@decadent.org.uk>
Date: Wed, 09 Mar 2011 00:31:59 +0000
Subject: [PATCH 3/5] sparc: Fix .size directive for do_int_load
Message-Id: <1299630719.4146.24.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

gas used to accept (and ignore?) .size directives which referred to
undefined symbols, as this does.  In binutils 2.21 these are treated
as errors.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sparc/kernel/una_asm_64.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/una_asm_64.S b/arch/sparc/kernel/una_asm_64.S
index be183fe..1c8d332 100644
--- a/arch/sparc/kernel/una_asm_64.S
+++ b/arch/sparc/kernel/una_asm_64.S
@@ -127,7 +127,7 @@ do_int_load:
 	wr	%o5, 0x0, %asi
 	retl
 	 mov	0, %o0
-	.size	__do_int_load, .-__do_int_load
+	.size	do_int_load, .-do_int_load
 
 	.section	__ex_table,"a"
 	.word		4b, __retl_efault
-- 
1.7.4.1



