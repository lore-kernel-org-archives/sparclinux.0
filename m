From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:45:59 +0000
Subject: [PATCH 4/4] sparc64: Fix ECB looping constructs in AES code.
Message-Id: <20121219.154559.180280068193321376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Things works better when you increment the source buffer pointer
properly.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/des_asm.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/crypto/des_asm.S b/arch/sparc/crypto/des_asm.S
index 30b6e90..b5c8fc2 100644
--- a/arch/sparc/crypto/des_asm.S
+++ b/arch/sparc/crypto/des_asm.S
@@ -376,6 +376,7 @@ ENTRY(des3_ede_sparc64_ecb_crypt)
 1:	ldd	[%o1 + 0x00], %f60
 	DES3_LOOP_BODY(60)
 	std	%f60, [%o2 + 0x00]
+	add	%o1, 0x08, %o1
 	subcc	%o3, 0x08, %o3
 	bne,pt	%icc, 1b
 	 add	%o2, 0x08, %o2
-- 
1.7.12.2.dirty

