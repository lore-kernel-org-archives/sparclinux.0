From: David Miller <davem@davemloft.net>
Date: Wed, 29 Aug 2012 03:59:23 +0000
Subject: [PATCH] sparc64: Use fsrc2 instead of fsrc1 in sparc64 hash crypto drivers.
Message-Id: <20120828.235923.1470366001549013400.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On SPARC-T4 fsrc2 has 1 cycle of latency, whereas fsrc1 has 11 cycles.

True story.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while fine-tuning the AES driver.  Actually, I turned
out to be disappointed, since AES was one of the drivers that didn't
make this mistake :-)

 arch/sparc/crypto/md5_asm.S    |    2 +-
 arch/sparc/crypto/sha1_asm.S   |    2 +-
 arch/sparc/crypto/sha256_asm.S |    2 +-
 arch/sparc/crypto/sha512_asm.S |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/crypto/md5_asm.S b/arch/sparc/crypto/md5_asm.S
index 220b73b..ff90903 100644
--- a/arch/sparc/crypto/md5_asm.S
+++ b/arch/sparc/crypto/md5_asm.S
@@ -62,7 +62,7 @@ ENTRY(md5_sparc64_transform)
 	.word	0x81b02800
 
 	subcc	%o2, 1, %o2
-	fsrc1	%f26, %f10
+	fsrc2	%f26, %f10
 	bne,pt	%xcc, 1b
 	 add	%o1, 0x40, %o1
 
diff --git a/arch/sparc/crypto/sha1_asm.S b/arch/sparc/crypto/sha1_asm.S
index d2147eb..3cd218a 100644
--- a/arch/sparc/crypto/sha1_asm.S
+++ b/arch/sparc/crypto/sha1_asm.S
@@ -64,7 +64,7 @@ ENTRY(sha1_sparc64_transform)
 	.word	0x81b02820
 
 	subcc	%o2, 1, %o2
-	fsrc1	%f26, %f10
+	fsrc2	%f26, %f10
 	bne,pt	%xcc, 1b
 	 add	%o1, 0x40, %o1
 
diff --git a/arch/sparc/crypto/sha256_asm.S b/arch/sparc/crypto/sha256_asm.S
index 771ce26..9da84f5 100644
--- a/arch/sparc/crypto/sha256_asm.S
+++ b/arch/sparc/crypto/sha256_asm.S
@@ -70,7 +70,7 @@ ENTRY(sha256_sparc64_transform)
 	.word	0x81b02840
 
 	subcc	%o2, 1, %o2
-	fsrc1	%f26, %f10
+	fsrc2	%f26, %f10
 	bne,pt	%xcc, 1b
 	 add	%o1, 0x40, %o1
 
diff --git a/arch/sparc/crypto/sha512_asm.S b/arch/sparc/crypto/sha512_asm.S
index 04244da..650ba57 100644
--- a/arch/sparc/crypto/sha512_asm.S
+++ b/arch/sparc/crypto/sha512_asm.S
@@ -94,7 +94,7 @@ ENTRY(sha512_sparc64_transform)
 	.word	0x81b02860
 
 	subcc	%o2, 1, %o2
-	fsrc1	%f50, %f18
+	fsrc2	%f50, %f18
 	bne,pt	%xcc, 1b
 	 add	%o1, 0x80, %o1
 
-- 
1.7.10.4

