From: David Miller <davem@davemloft.net>
Date: Sat, 10 Nov 2012 05:08:22 +0000
Subject: Re: sparc64 crypto static linking problem
Message-Id: <20121110.000822.865710870868087667.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1211012117400.16377@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1211012117400.16377@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 1 Nov 2012 21:22:19 +0200 (EET)

> While trying 3.7.0-rc3-00075-g1e207eb on sparc64, I configured sparc64 
> versionis of the ciphers. Modular where my original cipher was modular 
> and static where my original cipher was static (config snippet below). 
> This results in linking error when multiple thing are static:
> 
>  LD      arch/sparc/crypto/built-in.o
> arch/sparc/crypto/aes-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
> arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here
> arch/sparc/crypto/crc32c-sparc64.o:(.rodata+0x0): multiple definition of `__mod_of_device_table'
> arch/sparc/crypto/md5-sparc64.o:(.rodata+0x0): first defined here

Thanks for the report, I've fixed it like so:

==========
[PATCH] sparc64: Fix build with mix of modular vs. non-modular crypto drivers.

We tried linking in a single built object to hold the device table,
but only works if all of the sparc64 crypto modules get built the same
way (modular vs. non-modular).

Just include the device ID stub into each driver source file so that
the table gets compiled into the correct result in all cases.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/Makefile        | 16 ++++++++--------
 arch/sparc/crypto/aes_glue.c      |  2 ++
 arch/sparc/crypto/camellia_glue.c |  2 ++
 arch/sparc/crypto/crc32c_glue.c   |  2 ++
 arch/sparc/crypto/des_glue.c      |  2 ++
 arch/sparc/crypto/md5_glue.c      |  2 ++
 arch/sparc/crypto/sha1_glue.c     |  2 ++
 arch/sparc/crypto/sha256_glue.c   |  2 ++
 arch/sparc/crypto/sha512_glue.c   |  2 ++
 9 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/crypto/Makefile b/arch/sparc/crypto/Makefile
index 6ae1ad5..5d469d8 100644
--- a/arch/sparc/crypto/Makefile
+++ b/arch/sparc/crypto/Makefile
@@ -13,13 +13,13 @@ obj-$(CONFIG_CRYPTO_DES_SPARC64) += camellia-sparc64.o
 
 obj-$(CONFIG_CRYPTO_CRC32C_SPARC64) += crc32c-sparc64.o
 
-sha1-sparc64-y := sha1_asm.o sha1_glue.o crop_devid.o
-sha256-sparc64-y := sha256_asm.o sha256_glue.o crop_devid.o
-sha512-sparc64-y := sha512_asm.o sha512_glue.o crop_devid.o
-md5-sparc64-y := md5_asm.o md5_glue.o crop_devid.o
+sha1-sparc64-y := sha1_asm.o sha1_glue.o
+sha256-sparc64-y := sha256_asm.o sha256_glue.o
+sha512-sparc64-y := sha512_asm.o sha512_glue.o
+md5-sparc64-y := md5_asm.o md5_glue.o
 
-aes-sparc64-y := aes_asm.o aes_glue.o crop_devid.o
-des-sparc64-y := des_asm.o des_glue.o crop_devid.o
-camellia-sparc64-y := camellia_asm.o camellia_glue.o crop_devid.o
+aes-sparc64-y := aes_asm.o aes_glue.o
+des-sparc64-y := des_asm.o des_glue.o
+camellia-sparc64-y := camellia_asm.o camellia_glue.o
 
-crc32c-sparc64-y := crc32c_asm.o crc32c_glue.o crop_devid.o
+crc32c-sparc64-y := crc32c_asm.o crc32c_glue.o
diff --git a/arch/sparc/crypto/aes_glue.c b/arch/sparc/crypto/aes_glue.c
index 8f1c998..3965d1d 100644
--- a/arch/sparc/crypto/aes_glue.c
+++ b/arch/sparc/crypto/aes_glue.c
@@ -475,3 +475,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("AES Secure Hash Algorithm, sparc64 aes opcode accelerated");
 
 MODULE_ALIAS("aes");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/camellia_glue.c b/arch/sparc/crypto/camellia_glue.c
index 42905c0..62c89af 100644
--- a/arch/sparc/crypto/camellia_glue.c
+++ b/arch/sparc/crypto/camellia_glue.c
@@ -320,3 +320,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Camellia Cipher Algorithm, sparc64 camellia opcode accelerated");
 
 MODULE_ALIAS("aes");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/crc32c_glue.c b/arch/sparc/crypto/crc32c_glue.c
index 0bd89ce..5162fad 100644
--- a/arch/sparc/crypto/crc32c_glue.c
+++ b/arch/sparc/crypto/crc32c_glue.c
@@ -177,3 +177,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("CRC32c (Castagnoli), sparc64 crc32c opcode accelerated");
 
 MODULE_ALIAS("crc32c");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/des_glue.c b/arch/sparc/crypto/des_glue.c
index c4940c2..41524ce 100644
--- a/arch/sparc/crypto/des_glue.c
+++ b/arch/sparc/crypto/des_glue.c
@@ -527,3 +527,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("DES & Triple DES EDE Cipher Algorithms, sparc64 des opcode accelerated");
 
 MODULE_ALIAS("des");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/md5_glue.c b/arch/sparc/crypto/md5_glue.c
index 603d723..09a9ea1 100644
--- a/arch/sparc/crypto/md5_glue.c
+++ b/arch/sparc/crypto/md5_glue.c
@@ -186,3 +186,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MD5 Secure Hash Algorithm, sparc64 md5 opcode accelerated");
 
 MODULE_ALIAS("md5");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/sha1_glue.c b/arch/sparc/crypto/sha1_glue.c
index 2bbb20b..6cd5f29 100644
--- a/arch/sparc/crypto/sha1_glue.c
+++ b/arch/sparc/crypto/sha1_glue.c
@@ -181,3 +181,5 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm, sparc64 sha1 opcode accelerated");
 
 MODULE_ALIAS("sha1");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/sha256_glue.c b/arch/sparc/crypto/sha256_glue.c
index 591e656..04f555a 100644
--- a/arch/sparc/crypto/sha256_glue.c
+++ b/arch/sparc/crypto/sha256_glue.c
@@ -239,3 +239,5 @@ MODULE_DESCRIPTION("SHA-224 and SHA-256 Secure Hash Algorithm, sparc64 sha256 op
 
 MODULE_ALIAS("sha224");
 MODULE_ALIAS("sha256");
+
+#include "crop_devid.c"
diff --git a/arch/sparc/crypto/sha512_glue.c b/arch/sparc/crypto/sha512_glue.c
index 486f0a2..f04d199 100644
--- a/arch/sparc/crypto/sha512_glue.c
+++ b/arch/sparc/crypto/sha512_glue.c
@@ -224,3 +224,5 @@ MODULE_DESCRIPTION("SHA-384 and SHA-512 Secure Hash Algorithm, sparc64 sha512 op
 
 MODULE_ALIAS("sha384");
 MODULE_ALIAS("sha512");
+
+#include "crop_devid.c"
-- 
1.7.12.2.dirty

