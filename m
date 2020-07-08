From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 08 Jul 2020 16:39:39 +0000
Subject: [PATCH v2 1/5] crypto: sparc - rename sha256 to sha256_alg
Message-Id: <20200708163943.52071-2-ebiggers@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200708163943.52071-1-ebiggers@kernel.org>
In-Reply-To: <20200708163943.52071-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>

From: Eric Biggers <ebiggers@google.com>

To avoid a naming collision when we add a sha256() library function,
rename the "sha256" static variable in sha256_glue.c to "sha256_alg".
For consistency, also rename "sha224" to "sha224_alg".

Reported-by: kernel test robot <lkp@intel.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/sparc/crypto/sha256_glue.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/crypto/sha256_glue.c b/arch/sparc/crypto/sha256_glue.c
index 286bc8ecf15b..ca2547df9652 100644
--- a/arch/sparc/crypto/sha256_glue.c
+++ b/arch/sparc/crypto/sha256_glue.c
@@ -156,7 +156,7 @@ static int sha256_sparc64_import(struct shash_desc *desc, const void *in)
 	return 0;
 }
 
-static struct shash_alg sha256 = {
+static struct shash_alg sha256_alg = {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_sparc64_init,
 	.update		=	sha256_sparc64_update,
@@ -174,7 +174,7 @@ static struct shash_alg sha256 = {
 	}
 };
 
-static struct shash_alg sha224 = {
+static struct shash_alg sha224_alg = {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_sparc64_init,
 	.update		=	sha256_sparc64_update,
@@ -206,13 +206,13 @@ static bool __init sparc64_has_sha256_opcode(void)
 static int __init sha256_sparc64_mod_init(void)
 {
 	if (sparc64_has_sha256_opcode()) {
-		int ret = crypto_register_shash(&sha224);
+		int ret = crypto_register_shash(&sha224_alg);
 		if (ret < 0)
 			return ret;
 
-		ret = crypto_register_shash(&sha256);
+		ret = crypto_register_shash(&sha256_alg);
 		if (ret < 0) {
-			crypto_unregister_shash(&sha224);
+			crypto_unregister_shash(&sha224_alg);
 			return ret;
 		}
 
@@ -225,8 +225,8 @@ static int __init sha256_sparc64_mod_init(void)
 
 static void __exit sha256_sparc64_mod_fini(void)
 {
-	crypto_unregister_shash(&sha224);
-	crypto_unregister_shash(&sha256);
+	crypto_unregister_shash(&sha224_alg);
+	crypto_unregister_shash(&sha256_alg);
 }
 
 module_init(sha256_sparc64_mod_init);
-- 
2.27.0
