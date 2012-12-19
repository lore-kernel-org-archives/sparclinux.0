From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:56:58 +0000
Subject: [PATCH 1/2] sparc64: Set CRYPTO_TFM_REQ_MAY_SLEEP consistently in DES code.
Message-Id: <20121219.155658.1630277565336475037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We use the FPU and therefore cannot sleep during the crypto
loops.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/des_glue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/crypto/des_glue.c b/arch/sparc/crypto/des_glue.c
index 41524ce..3065bc6 100644
--- a/arch/sparc/crypto/des_glue.c
+++ b/arch/sparc/crypto/des_glue.c
@@ -100,6 +100,7 @@ static int __ecb_crypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	if (encrypt)
 		des_sparc64_load_keys(&ctx->encrypt_expkey[0]);
@@ -147,6 +148,7 @@ static int cbc_encrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	des_sparc64_load_keys(&ctx->encrypt_expkey[0]);
 	while ((nbytes = walk.nbytes)) {
@@ -177,6 +179,7 @@ static int cbc_decrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	des_sparc64_load_keys(&ctx->decrypt_expkey[0]);
 	while ((nbytes = walk.nbytes)) {
@@ -266,6 +269,7 @@ static int __ecb3_crypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	if (encrypt)
 		K = &ctx->encrypt_expkey[0];
@@ -317,6 +321,7 @@ static int cbc3_encrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	K = &ctx->encrypt_expkey[0];
 	des3_ede_sparc64_load_keys(K);
@@ -352,6 +357,7 @@ static int cbc3_decrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	K = &ctx->decrypt_expkey[0];
 	des3_ede_sparc64_load_keys(K);
-- 
1.7.12.2.dirty

