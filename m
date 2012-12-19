From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:45:56 +0000
Subject: [PATCH 3/4] sparc64: Set CRYPTO_TFM_REQ_MAY_SLEEP consistently in AES code.
Message-Id: <20121219.154556.573390596077546719.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We use the FPU and therefore cannot sleep during the crypto
loops.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_glue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/crypto/aes_glue.c b/arch/sparc/crypto/aes_glue.c
index d26e751..503e6d9 100644
--- a/arch/sparc/crypto/aes_glue.c
+++ b/arch/sparc/crypto/aes_glue.c
@@ -222,6 +222,7 @@ static int ecb_encrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	ctx->ops->load_encrypt_keys(&ctx->key[0]);
 	while ((nbytes = walk.nbytes)) {
@@ -251,6 +252,7 @@ static int ecb_decrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	ctx->ops->load_decrypt_keys(&ctx->key[0]);
 	key_end = &ctx->key[ctx->expanded_key_length / sizeof(u64)];
@@ -280,6 +282,7 @@ static int cbc_encrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	ctx->ops->load_encrypt_keys(&ctx->key[0]);
 	while ((nbytes = walk.nbytes)) {
@@ -309,6 +312,7 @@ static int cbc_decrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	ctx->ops->load_decrypt_keys(&ctx->key[0]);
 	key_end = &ctx->key[ctx->expanded_key_length / sizeof(u64)];
-- 
1.7.12.2.dirty

