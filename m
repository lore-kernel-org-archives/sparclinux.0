From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:45:50 +0000
Subject: [PATCH 1/4] sparc64: Fix unrolled AES 256-bit key loops.
Message-Id: <20121219.154550.765668728083453355.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The basic scheme of the block mode assembler is that we start by
enabling the FPU, loading the key into the floating point registers,
then iterate calling the encrypt/decrypt routine for each block.

For the 256-bit key cases, we run short on registers in the unrolled
loops.

So the {ENCRYPT,DECRYPT}_256_2() macros reload the key registers that
get clobbered.

The unrolled macros, {ENCRYPT,DECRYPT}_256(), are not mindful of this.

So if we have a mix of multi-block and single-block calls, the
single-block unrolled 256-bit encrypt/decrypt can run with some
of the key registers clobbered.

Handle this by always explicitly loading those registers before using
the non-unrolled 256-bit macro.

This was discovered thanks to all of the new test cases added by
Jussi Kivilinna.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_asm.S | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/crypto/aes_asm.S b/arch/sparc/crypto/aes_asm.S
index 23f6cbb..1cda8aa 100644
--- a/arch/sparc/crypto/aes_asm.S
+++ b/arch/sparc/crypto/aes_asm.S
@@ -1024,7 +1024,11 @@ ENTRY(aes_sparc64_ecb_encrypt_256)
 	 add		%o2, 0x20, %o2
 	brlz,pt		%o3, 11f
 	 nop
-10:	ldx		[%o1 + 0x00], %g3
+10:	ldd		[%o0 + 0xd0], %f56
+	ldd		[%o0 + 0xd8], %f58
+	ldd		[%o0 + 0xe0], %f60
+	ldd		[%o0 + 0xe8], %f62
+	ldx		[%o1 + 0x00], %g3
 	ldx		[%o1 + 0x08], %g7
 	xor		%g1, %g3, %g3
 	xor		%g2, %g7, %g7
@@ -1128,9 +1132,9 @@ ENTRY(aes_sparc64_ecb_decrypt_256)
 	/* %o0=&key[key_len], %o1=input, %o2=output, %o3=len */
 	ldx		[%o0 - 0x10], %g1
 	subcc		%o3, 0x10, %o3
+	ldx		[%o0 - 0x08], %g2
 	be		10f
-	 ldx		[%o0 - 0x08], %g2
-	sub		%o0, 0xf0, %o0
+	 sub		%o0, 0xf0, %o0
 1:	ldx		[%o1 + 0x00], %g3
 	ldx		[%o1 + 0x08], %g7
 	ldx		[%o1 + 0x10], %o4
@@ -1154,7 +1158,11 @@ ENTRY(aes_sparc64_ecb_decrypt_256)
 	 add		%o2, 0x20, %o2
 	brlz,pt		%o3, 11f
 	 nop
-10:	ldx		[%o1 + 0x00], %g3
+10:	ldd		[%o0 + 0x18], %f56
+	ldd		[%o0 + 0x10], %f58
+	ldd		[%o0 + 0x08], %f60
+	ldd		[%o0 + 0x00], %f62
+	ldx		[%o1 + 0x00], %g3
 	ldx		[%o1 + 0x08], %g7
 	xor		%g1, %g3, %g3
 	xor		%g2, %g7, %g7
@@ -1511,11 +1519,11 @@ ENTRY(aes_sparc64_ctr_crypt_256)
 	 add		%o2, 0x20, %o2
 	brlz,pt		%o3, 11f
 	 nop
-	ldd		[%o0 + 0xd0], %f56
+10:	ldd		[%o0 + 0xd0], %f56
 	ldd		[%o0 + 0xd8], %f58
 	ldd		[%o0 + 0xe0], %f60
 	ldd		[%o0 + 0xe8], %f62
-10:	xor		%g1, %g3, %o5
+	xor		%g1, %g3, %o5
 	MOVXTOD_O5_F0
 	xor		%g2, %g7, %o5
 	MOVXTOD_O5_F2
-- 
1.7.12.2.dirty

