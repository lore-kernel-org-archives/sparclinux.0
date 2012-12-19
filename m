From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:45:53 +0000
Subject: [PATCH 2/4] sparc64: Fix AES ctr mode block size.
Message-Id: <20121219.154553.1528472665478665283.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Like the generic versions, we need to support a block size
of '1' for CTR mode AES.

This was discovered thanks to all of the new test cases added by
Jussi Kivilinna.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/aes_glue.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/crypto/aes_glue.c b/arch/sparc/crypto/aes_glue.c
index 3965d1d..d26e751 100644
--- a/arch/sparc/crypto/aes_glue.c
+++ b/arch/sparc/crypto/aes_glue.c
@@ -329,6 +329,22 @@ static int cbc_decrypt(struct blkcipher_desc *desc,
 	return err;
 }
 
+static void ctr_crypt_final(struct crypto_sparc64_aes_ctx *ctx,
+			    struct blkcipher_walk *walk)
+{
+	u8 *ctrblk = walk->iv;
+	u64 keystream[AES_BLOCK_SIZE / sizeof(u64)];
+	u8 *src = walk->src.virt.addr;
+	u8 *dst = walk->dst.virt.addr;
+	unsigned int nbytes = walk->nbytes;
+
+	ctx->ops->ecb_encrypt(&ctx->key[0], (const u64 *)ctrblk,
+			      keystream, AES_BLOCK_SIZE);
+	crypto_xor((u8 *) keystream, src, nbytes);
+	memcpy(dst, keystream, nbytes);
+	crypto_inc(ctrblk, AES_BLOCK_SIZE);
+}
+
 static int ctr_crypt(struct blkcipher_desc *desc,
 		     struct scatterlist *dst, struct scatterlist *src,
 		     unsigned int nbytes)
@@ -338,10 +354,11 @@ static int ctr_crypt(struct blkcipher_desc *desc,
 	int err;
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
-	err = blkcipher_walk_virt(desc, &walk);
+	err = blkcipher_walk_virt_block(desc, &walk, AES_BLOCK_SIZE);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	ctx->ops->load_encrypt_keys(&ctx->key[0]);
-	while ((nbytes = walk.nbytes)) {
+	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
 		unsigned int block_len = nbytes & AES_BLOCK_MASK;
 
 		if (likely(block_len)) {
@@ -353,6 +370,10 @@ static int ctr_crypt(struct blkcipher_desc *desc,
 		nbytes &= AES_BLOCK_SIZE - 1;
 		err = blkcipher_walk_done(desc, &walk, nbytes);
 	}
+	if (walk.nbytes) {
+		ctr_crypt_final(ctx, &walk);
+		err = blkcipher_walk_done(desc, &walk, 0);
+	}
 	fprs_write(0);
 	return err;
 }
@@ -418,7 +439,7 @@ static struct crypto_alg algs[] = { {
 	.cra_driver_name	= "ctr-aes-sparc64",
 	.cra_priority		= SPARC_CR_OPCODE_PRIORITY,
 	.cra_flags		= CRYPTO_ALG_TYPE_BLKCIPHER,
-	.cra_blocksize		= AES_BLOCK_SIZE,
+	.cra_blocksize		= 1,
 	.cra_ctxsize		= sizeof(struct crypto_sparc64_aes_ctx),
 	.cra_alignmask		= 7,
 	.cra_type		= &crypto_blkcipher_type,
-- 
1.7.12.2.dirty

