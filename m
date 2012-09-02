From: David Miller <davem@davemloft.net>
Date: Sun, 02 Sep 2012 06:08:50 +0000
Subject: [PATCH] sparc64: Fix bugs in unrolled 256-bit loops.
Message-Id: <20120902.020850.1949703926788068834.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Some dm-crypt testing revealed several bugs in the 256-bit unrolled
loops.

The DECRYPT_256_2() macro had two errors:

1) Missing reload of KEY registers %f60 and %f62

2) Missing "\" in penultimate line of definition.

In aes_sparc64_ecb_decrypt_256, we were storing the second half of the
encryption result from the wrong source registers.

In aes_sparc64_ctr_crypt_256 we have to be careful when we fall out of
the 32-byte-at-a-time loop and handle a trailing 16-byte chunk.  In
that case we've clobbered the final key holding registers and have to
restore them before executing the ENCRYPT_256() macro.  Inside of the
32-byte-at-a-time loop things are OK, because we do this key register
restoring during the first few rounds of the ENCRYPT_256_2() macro.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_asm.S |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/crypto/aes_asm.S b/arch/sparc/crypto/aes_asm.S
index 2086088..23f6cbb 100644
--- a/arch/sparc/crypto/aes_asm.S
+++ b/arch/sparc/crypto/aes_asm.S
@@ -188,6 +188,8 @@
 	ldd	[%o0 + 0x18], %f56; \
 	ldd	[%o0 + 0x10], %f58; \
 	DECRYPT_256_TWO_ROUNDS_2(KEY_BASE +  8, I0, I1, I2, I3, KEY_BASE +  0) \
+	ldd	[%o0 + 0x08], %f60; \
+	ldd	[%o0 + 0x00], %f62; \
 	DECRYPT_256_TWO_ROUNDS_2(KEY_BASE + 16, I0, I1, I2, I3, KEY_BASE +  0) \
 	DECRYPT_256_TWO_ROUNDS_2(KEY_BASE + 24, I0, I1, I2, I3, KEY_BASE +  0) \
 	DECRYPT_256_TWO_ROUNDS_2(KEY_BASE + 32, I0, I1, I2, I3, KEY_BASE +  0) \
@@ -201,7 +203,7 @@
 	ldd	[%o0 + 0xd8], %f8; \
 	ldd	[%o0 + 0xd0], %f10; \
 	AES_DROUND23_L(KEY_BASE +  52, KEY_BASE + 4, KEY_BASE + 6, I3) \
-	AES_DROUND01_L(KEY_BASE +  54, KEY_BASE + 4, KEY_BASE + 6, I2)
+	AES_DROUND01_L(KEY_BASE +  54, KEY_BASE + 4, KEY_BASE + 6, I2) \
 	ldd	[%o0 + 0xc8], %f12; \
 	ldd	[%o0 + 0xc0], %f14;
 
@@ -1144,8 +1146,8 @@ ENTRY(aes_sparc64_ecb_decrypt_256)
 	DECRYPT_256_2(8, 4, 6, 0, 2)
 	std		%f4, [%o2 + 0x00]
 	std		%f6, [%o2 + 0x08]
-	std		%f60, [%o2 + 0x10]
-	std		%f62, [%o2 + 0x18]
+	std		%f0, [%o2 + 0x10]
+	std		%f2, [%o2 + 0x18]
 	sub		%o3, 0x20, %o3
 	add		%o1, 0x20, %o1
 	brgz,pt		%o3, 1b
@@ -1509,6 +1511,10 @@ ENTRY(aes_sparc64_ctr_crypt_256)
 	 add		%o2, 0x20, %o2
 	brlz,pt		%o3, 11f
 	 nop
+	ldd		[%o0 + 0xd0], %f56
+	ldd		[%o0 + 0xd8], %f58
+	ldd		[%o0 + 0xe0], %f60
+	ldd		[%o0 + 0xe8], %f62
 10:	xor		%g1, %g3, %o5
 	MOVXTOD_O5_F0
 	xor		%g2, %g7, %o5
-- 
1.7.10.4

