From: David Miller <davem@davemloft.net>
Date: Wed, 19 Dec 2012 23:57:10 +0000
Subject: [PATCH 2/2] sparc64: Set CRYPTO_TFM_REQ_MAY_SLEEP consistently in CAMELLIA code.
Message-Id: <20121219.155710.1234180893335096517.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We use the FPU and therefore cannot sleep during the crypto
loops.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/crypto/camellia_glue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/crypto/camellia_glue.c b/arch/sparc/crypto/camellia_glue.c
index 62c89af..888f626 100644
--- a/arch/sparc/crypto/camellia_glue.c
+++ b/arch/sparc/crypto/camellia_glue.c
@@ -98,6 +98,7 @@ static int __ecb_crypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	if (encrypt)
 		key = &ctx->encrypt_key[0];
@@ -160,6 +161,7 @@ static int cbc_encrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	key = &ctx->encrypt_key[0];
 	camellia_sparc64_load_keys(key, ctx->key_len);
@@ -198,6 +200,7 @@ static int cbc_decrypt(struct blkcipher_desc *desc,
 
 	blkcipher_walk_init(&walk, dst, src, nbytes);
 	err = blkcipher_walk_virt(desc, &walk);
+	desc->flags &= ~CRYPTO_TFM_REQ_MAY_SLEEP;
 
 	key = &ctx->decrypt_key[0];
 	camellia_sparc64_load_keys(key, ctx->key_len);
-- 
1.7.12.2.dirty

