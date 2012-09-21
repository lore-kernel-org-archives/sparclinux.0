From: David Miller <davem@davemloft.net>
Date: Fri, 21 Sep 2012 19:11:53 +0000
Subject: [PATCH] sparc64: Fix function argument comment in camellia_sparc64_key_expand asm.
Message-Id: <20120921.151153.933298048729949049.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/camellia_asm.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/crypto/camellia_asm.S b/arch/sparc/crypto/camellia_=
asm.S
index d3ef9c7..cc39553 100644
--- a/arch/sparc/crypto/camellia_asm.S
+++ b/arch/sparc/crypto/camellia_asm.S
@@ -30,7 +30,7 @@ SIGMA:	.xword	0xA09E667F3BCC908B
=20
 	.align	32
 ENTRY(camellia_sparc64_key_expand)
-	/* %o0=3Din_key, %o1=3Dout_key, %o2=3Dkey_len */
+	/* %o0=3Din_key, %o1=3Dencrypt_key, %o2=3Dkey_len, %o3=DEcrypt_key */
 	VISEntry
 	ld	[%o0 + 0x00], %f0	! i0, k[0]
 	ld	[%o0 + 0x04], %f1	! i1, k[1]
--=20
1.7.10.4

