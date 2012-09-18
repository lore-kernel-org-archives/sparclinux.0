From: David Miller <davem@davemloft.net>
Date: Tue, 18 Sep 2012 03:01:44 +0000
Subject: [PATCH] sparc64: Fix IV handling bug in des_sparc64_cbc_decrypt
Message-Id: <20120917.230144.383780203829176979.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The IV wasn't being propagated properly past the first loop
iteration.

This bug lived only because the crypto layer tests for
cbc(des) do not have any cases that go more than one loop.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/des_asm.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/crypto/des_asm.S b/arch/sparc/crypto/des_asm.S
index a7da935..30b6e90 100644
--- a/arch/sparc/crypto/des_asm.S
+++ b/arch/sparc/crypto/des_asm.S
@@ -168,6 +168,7 @@ ENTRY(des_sparc64_cbc_decrypt)
 	DES_ROUND(28, 30, 32, 32)
 	DES_IIP(32, 32)
 	fxor	%f32, %f34, %f32
+	fsrc2	%f36, %f34
 	std	%f32, [%o1 + 0x00]
 	add	%o0, 0x08, %o0
 	subcc	%o2, 0x08, %o2
-- 
1.7.10.4

