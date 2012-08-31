From: David Miller <davem@davemloft.net>
Date: Fri, 31 Aug 2012 19:15:50 +0000
Subject: [PATCH] sparc64: Avoid code duplication in crypto assembler.
Message-Id: <20120831.151550.218836635608049682.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


Put the opcode macros in a common header

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_asm.S      |   56 +---------------------
 arch/sparc/crypto/camellia_asm.S |   22 +--------
 arch/sparc/crypto/crc32c_asm.S   |   11 +----
 arch/sparc/crypto/des_asm.S      |   24 +---------
 arch/sparc/crypto/md5_asm.S      |    8 ++--
 arch/sparc/crypto/opcodes.h      |   97 ++++++++++++++++++++++++++++++++++=
++++
 arch/sparc/crypto/sha1_asm.S     |    8 ++--
 arch/sparc/crypto/sha256_asm.S   |    8 ++--
 arch/sparc/crypto/sha512_asm.S   |    8 ++--
 9 files changed, 117 insertions(+), 125 deletions(-)
 create mode 100644 arch/sparc/crypto/opcodes.h

diff --git a/arch/sparc/crypto/aes_asm.S b/arch/sparc/crypto/aes_asm.S
index 0fadad0..2086088 100644
--- a/arch/sparc/crypto/aes_asm.S
+++ b/arch/sparc/crypto/aes_asm.S
@@ -1,61 +1,7 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
-#define F3F(x,y,z)	(((x)<<30)|((y)<<19)|((z)<<5))
-
-#define FPD_ENCODE(x)	(((x) >> 5) | ((x) & ~(0x20)))
-
-#define RS1(x)		(FPD_ENCODE(x) << 14)
-#define RS2(x)		(FPD_ENCODE(x) <<  0)
-#define RS3(x)		(FPD_ENCODE(x) <<  9)
-#define RD(x)		(FPD_ENCODE(x) << 25)
-#define IMM5(x)		((x)           <<  9)
-
-#define AES_EROUND01(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 0)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_EROUND23(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 1)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_DROUND01(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 2)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_DROUND23(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 3)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_EROUND01_L(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 4)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_EROUND23_L(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 5)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_DROUND01_L(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 6)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_DROUND23_L(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 7)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define AES_KEXPAND1(a,b,c,d)	\
-	.word	(F3F(2, 0x19, 8)|RS1(a)|RS2(b)|IMM5(c)|RD(d));
-#define AES_KEXPAND0(a,b,c)	\
-	.word	(F3F(2, 0x36, 0x130)|RS1(a)|RS2(b)|RD(c));
-#define AES_KEXPAND2(a,b,c)	\
-	.word	(F3F(2, 0x36, 0x131)|RS1(a)|RS2(b)|RD(c));
-
-#define MOVXTOD_G3_F4		\
-	.word	0x89b02303;
-#define MOVXTOD_G7_F6		\
-	.word	0x8db02307;
-#define MOVXTOD_G3_F0		\
-	.word	0x81b02303;
-#define MOVXTOD_G7_F2		\
-	.word	0x85b02307;
-#define MOVXTOD_O0_F0		\
-	.word	0x81b02308;
-#define MOVXTOD_O5_F0		\
-	.word	0x81b0230d;
-#define MOVXTOD_O5_F2		\
-	.word	0x85b0230d;
-#define MOVXTOD_O5_F4		\
-	.word	0x89b0230d;
-#define MOVXTOD_O5_F6		\
-	.word	0x8db0230d;
-#define MOVXTOD_G3_F60		\
-	.word	0xbbb02303;
-#define MOVXTOD_G7_F62		\
-	.word	0xbfb02307;
+#include "opcodes.h"
=20
 #define ENCRYPT_TWO_ROUNDS(KEY_BASE, I0, I1, T0, T1) \
 	AES_EROUND01(KEY_BASE +  0, I0, I1, T0) \
diff --git a/arch/sparc/crypto/camellia_asm.S b/arch/sparc/crypto/camellia_=
asm.S
index b0ddb5b..d3ef9c7 100644
--- a/arch/sparc/crypto/camellia_asm.S
+++ b/arch/sparc/crypto/camellia_asm.S
@@ -1,27 +1,7 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
-#define F3F(x,y,z)	(((x)<<30)|((y)<<19)|((z)<<5))
-
-#define FPD_ENCODE(x)	(((x) >> 5) | ((x) & ~(0x20)))
-
-#define RS1(x)		(FPD_ENCODE(x) << 14)
-#define RS2(x)		(FPD_ENCODE(x) <<  0)
-#define RS3(x)		(FPD_ENCODE(x) <<  9)
-#define RD(x)		(FPD_ENCODE(x) << 25)
-#define IMM5(x)		((x)           <<  0)
-
-#define CAMELLIA_F(a,b,c,d)		\
-	.word		(F3F(2, 0x19, 0x00c)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-#define CAMELLIA_FL(a,b,c)		\
-	.word		(F3F(2, 0x36, 0x13c)|RS1(a)|RS2(b)|RD(c));
-#define CAMELLIA_FLI(a,b,c)		\
-	.word		(F3F(2, 0x36, 0x13d)|RS1(a)|RS2(b)|RD(c));
-
-#define MOVDTOX_F0_O4	\
-	.word	0x99b02200
-#define MOVDTOX_F2_O5	\
-	.word	0x9bb02202
+#include "opcodes.h"
=20
 #define CAMELLIA_6ROUNDS(KEY_BASE, I0, I1) \
 	CAMELLIA_F(KEY_BASE +  0, I1, I0, I1) \
diff --git a/arch/sparc/crypto/crc32c_asm.S b/arch/sparc/crypto/crc32c_asm.S
index cb479ec..2b1976e 100644
--- a/arch/sparc/crypto/crc32c_asm.S
+++ b/arch/sparc/crypto/crc32c_asm.S
@@ -2,16 +2,7 @@
 #include <asm/visasm.h>
 #include <asm/asi.h>
=20
-#define F3F(x,y,z)	(((x)<<30)|((y)<<19)|((z)<<5))
-
-#define FPD_ENCODE(x)	(((x) >> 5) | ((x) & ~(0x20)))
-
-#define RS1(x)		(FPD_ENCODE(x) << 14)
-#define RS2(x)		(FPD_ENCODE(x) <<  0)
-#define RD(x)		(FPD_ENCODE(x) << 25)
-
-#define CRC32C(a,b,c)	\
-	.word		(F3F(2,0x36,0x147)|RS1(a)|RS2(b)|RD(c));
+#include "opcodes.h"
=20
 ENTRY(crc32c_sparc64)
 	/* %o0=3Dcrc32p, %o1=DAta_ptr, %o2=3Dlen */
diff --git a/arch/sparc/crypto/des_asm.S b/arch/sparc/crypto/des_asm.S
index 589481e..a7da935 100644
--- a/arch/sparc/crypto/des_asm.S
+++ b/arch/sparc/crypto/des_asm.S
@@ -1,29 +1,7 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
-#define F3F(x,y,z)	(((x)<<30)|((y)<<19)|((z)<<5))
-
-#define FPD_ENCODE(x)	(((x) >> 5) | ((x) & ~(0x20)))
-
-#define RS1(x)		(FPD_ENCODE(x) << 14)
-#define RS2(x)		(FPD_ENCODE(x) <<  0)
-#define RS3(x)		(FPD_ENCODE(x) <<  9)
-#define RD(x)		(FPD_ENCODE(x) << 25)
-#define IMM5(x)		((x)           <<  0)
-
-#define DES_IP(a,b)		\
-	.word		(F3F(2, 0x36, 0x134)|RS1(a)|RD(b));
-#define DES_IIP(a,b)		\
-	.word		(F3F(2, 0x36, 0x135)|RS1(a)|RD(b));
-#define DES_KEXPAND(a,b,c)	\
-	.word		(F3F(2, 0x36, 0x136)|RS1(a)|IMM5(b)|RD(c));
-#define DES_ROUND(a,b,c,d)	\
-	.word		(F3F(2, 0x19, 0x009)|RS1(a)|RS2(b)|RS3(c)|RD(d));
-
-#define MOVXTOD_G1_F60 \
-	.word		0xbbb02301
-#define MOVXTOD_G1_F62 \
-	.word		0xbfb02301
+#include "opcodes.h"
=20
 	.align	32
 ENTRY(des_sparc64_key_expand)
diff --git a/arch/sparc/crypto/md5_asm.S b/arch/sparc/crypto/md5_asm.S
index ff90903..3150404 100644
--- a/arch/sparc/crypto/md5_asm.S
+++ b/arch/sparc/crypto/md5_asm.S
@@ -1,6 +1,8 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
+#include "opcodes.h"
+
 ENTRY(md5_sparc64_transform)
 	/* %o0 =3D digest, %o1 =3D data, %o2 =3D rounds */
 	VISEntryHalf
@@ -21,8 +23,7 @@ ENTRY(md5_sparc64_transform)
 	ldd	[%o1 + 0x30], %f20
 	ldd	[%o1 + 0x38], %f22
=20
-	/* md5 */
-	.word	0x81b02800
+	MD5
=20
 	subcc	%o2, 1, %o2
 	bne,pt	%xcc, 1b
@@ -58,8 +59,7 @@ ENTRY(md5_sparc64_transform)
 	faligndata %f22, %f24, %f20
 	faligndata %f24, %f26, %f22
=20
-	/* md5 */
-	.word	0x81b02800
+	MD5
=20
 	subcc	%o2, 1, %o2
 	fsrc2	%f26, %f10
diff --git a/arch/sparc/crypto/opcodes.h b/arch/sparc/crypto/opcodes.h
new file mode 100644
index 0000000..b6c4a15
--- /dev/null
+++ b/arch/sparc/crypto/opcodes.h
@@ -0,0 +1,97 @@
+#ifndef _OPCODES_H
+#define _OPCODES_H
+
+#define F3F(x,y,z)	(((x)<<30)|((y)<<19)|((z)<<5))
+
+#define FPD_ENCODE(x)	(((x) >> 5) | ((x) & ~(0x20)))
+
+#define RS1(x)		(FPD_ENCODE(x) << 14)
+#define RS2(x)		(FPD_ENCODE(x) <<  0)
+#define RS3(x)		(FPD_ENCODE(x) <<  9)
+#define RD(x)		(FPD_ENCODE(x) << 25)
+#define IMM5_0(x)	((x)           <<  0)
+#define IMM5_9(x)	((x)           <<  9)
+
+#define CRC32C(a,b,c)	\
+	.word		(F3F(2,0x36,0x147)|RS1(a)|RS2(b)|RD(c));
+
+#define MD5		\
+	.word	0x81b02800;
+#define SHA1		\
+	.word	0x81b02820;
+#define SHA256		\
+	.word	0x81b02840;
+#define SHA512		\
+	.word	0x81b02860;
+
+#define AES_EROUND01(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 0)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_EROUND23(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 1)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_DROUND01(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 2)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_DROUND23(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 3)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_EROUND01_L(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 4)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_EROUND23_L(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 5)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_DROUND01_L(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 6)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_DROUND23_L(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 7)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define AES_KEXPAND1(a,b,c,d)	\
+	.word	(F3F(2, 0x19, 8)|RS1(a)|RS2(b)|IMM5_9(c)|RD(d));
+#define AES_KEXPAND0(a,b,c)	\
+	.word	(F3F(2, 0x36, 0x130)|RS1(a)|RS2(b)|RD(c));
+#define AES_KEXPAND2(a,b,c)	\
+	.word	(F3F(2, 0x36, 0x131)|RS1(a)|RS2(b)|RD(c));
+
+#define DES_IP(a,b)		\
+	.word		(F3F(2, 0x36, 0x134)|RS1(a)|RD(b));
+#define DES_IIP(a,b)		\
+	.word		(F3F(2, 0x36, 0x135)|RS1(a)|RD(b));
+#define DES_KEXPAND(a,b,c)	\
+	.word		(F3F(2, 0x36, 0x136)|RS1(a)|IMM5_0(b)|RD(c));
+#define DES_ROUND(a,b,c,d)	\
+	.word		(F3F(2, 0x19, 0x009)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+
+#define CAMELLIA_F(a,b,c,d)		\
+	.word		(F3F(2, 0x19, 0x00c)|RS1(a)|RS2(b)|RS3(c)|RD(d));
+#define CAMELLIA_FL(a,b,c)		\
+	.word		(F3F(2, 0x36, 0x13c)|RS1(a)|RS2(b)|RD(c));
+#define CAMELLIA_FLI(a,b,c)		\
+	.word		(F3F(2, 0x36, 0x13d)|RS1(a)|RS2(b)|RD(c));
+
+#define MOVDTOX_F0_O4		\
+	.word	0x99b02200
+#define MOVDTOX_F2_O5		\
+	.word	0x9bb02202
+#define MOVXTOD_G1_F60 		\
+	.word	0xbbb02301
+#define MOVXTOD_G1_F62 		\
+	.word	0xbfb02301
+#define MOVXTOD_G3_F4		\
+	.word	0x89b02303;
+#define MOVXTOD_G7_F6		\
+	.word	0x8db02307;
+#define MOVXTOD_G3_F0		\
+	.word	0x81b02303;
+#define MOVXTOD_G7_F2		\
+	.word	0x85b02307;
+#define MOVXTOD_O0_F0		\
+	.word	0x81b02308;
+#define MOVXTOD_O5_F0		\
+	.word	0x81b0230d;
+#define MOVXTOD_O5_F2		\
+	.word	0x85b0230d;
+#define MOVXTOD_O5_F4		\
+	.word	0x89b0230d;
+#define MOVXTOD_O5_F6		\
+	.word	0x8db0230d;
+#define MOVXTOD_G3_F60		\
+	.word	0xbbb02303;
+#define MOVXTOD_G7_F62		\
+	.word	0xbfb02307;
+
+#endif /* _OPCODES_H */
diff --git a/arch/sparc/crypto/sha1_asm.S b/arch/sparc/crypto/sha1_asm.S
index 3cd218a..219d10c 100644
--- a/arch/sparc/crypto/sha1_asm.S
+++ b/arch/sparc/crypto/sha1_asm.S
@@ -1,6 +1,8 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
+#include "opcodes.h"
+
 ENTRY(sha1_sparc64_transform)
 	/* %o0 =3D digest, %o1 =3D data, %o2 =3D rounds */
 	VISEntryHalf
@@ -22,8 +24,7 @@ ENTRY(sha1_sparc64_transform)
 	ldd	[%o1 + 0x30], %f20
 	ldd	[%o1 + 0x38], %f22
=20
-	/* sha1 */
-	.word	0x81b02820
+	SHA1
=20
 	subcc	%o2, 1, %o2
 	bne,pt	%xcc, 1b
@@ -60,8 +61,7 @@ ENTRY(sha1_sparc64_transform)
 	faligndata %f22, %f24, %f20
 	faligndata %f24, %f26, %f22
=20
-	/* sha1 */
-	.word	0x81b02820
+	SHA1
=20
 	subcc	%o2, 1, %o2
 	fsrc2	%f26, %f10
diff --git a/arch/sparc/crypto/sha256_asm.S b/arch/sparc/crypto/sha256_asm.S
index 9da84f5..b5f3d58 100644
--- a/arch/sparc/crypto/sha256_asm.S
+++ b/arch/sparc/crypto/sha256_asm.S
@@ -1,6 +1,8 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
+#include "opcodes.h"
+
 ENTRY(sha256_sparc64_transform)
 	/* %o0 =3D digest, %o1 =3D data, %o2 =3D rounds */
 	VISEntryHalf
@@ -25,8 +27,7 @@ ENTRY(sha256_sparc64_transform)
 	ldd	[%o1 + 0x30], %f20
 	ldd	[%o1 + 0x38], %f22
=20
-	/* sha256 */
-	.word	0x81b02840
+	SHA256
=20
 	subcc	%o2, 1, %o2
 	bne,pt	%xcc, 1b
@@ -66,8 +67,7 @@ ENTRY(sha256_sparc64_transform)
 	faligndata %f22, %f24, %f20
 	faligndata %f24, %f26, %f22
=20
-	/* sha256 */
-	.word	0x81b02840
+	SHA256
=20
 	subcc	%o2, 1, %o2
 	fsrc2	%f26, %f10
diff --git a/arch/sparc/crypto/sha512_asm.S b/arch/sparc/crypto/sha512_asm.S
index 650ba57..54bfba7 100644
--- a/arch/sparc/crypto/sha512_asm.S
+++ b/arch/sparc/crypto/sha512_asm.S
@@ -1,6 +1,8 @@
 #include <linux/linkage.h>
 #include <asm/visasm.h>
=20
+#include "opcodes.h"
+
 ENTRY(sha512_sparc64_transform)
 	/* %o0 =3D digest, %o1 =3D data, %o2 =3D rounds */
 	VISEntry
@@ -33,8 +35,7 @@ ENTRY(sha512_sparc64_transform)
 	ldd	[%o1 + 0x70], %f44
 	ldd	[%o1 + 0x78], %f46
=20
-	/* sha512 */
-	.word	0x81b02860
+	SHA512
=20
 	subcc	%o2, 1, %o2
 	bne,pt	%xcc, 1b
@@ -90,8 +91,7 @@ ENTRY(sha512_sparc64_transform)
 	faligndata %f46, %f48, %f44
 	faligndata %f48, %f50, %f46
=20
-	/* sha512 */
-	.word	0x81b02860
+	SHA512
=20
 	subcc	%o2, 1, %o2
 	fsrc2	%f50, %f18
--=20
1.7.10.4

