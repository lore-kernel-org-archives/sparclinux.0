From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 13 May 2006 06:57:24 +0000
Subject: Re: Possible alignment issue in kernel's sha256 implementation
Message-Id: <20060513065724.GA15382@gondor.apana.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0605121941580.3617@bobcat>
In-Reply-To: <Pine.LNX.4.63.0605121941580.3617@bobcat>
To: sparclinux@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2006 at 11:22:28PM -0700, David S. Miller wrote:
> 
> Maybe the unaligned case cannot happen in the kernel for some
> reason.
> 
> Herbert, is there anything which ensures 32-bit alignment
> for the data accessed by LOAD_OP()?

It can happen but it's pretty unusual with today's users.

Atsushi Nemoto has a patch which fixes the issue for all digest
algorithms by copying unaligned data where necessary.  This is
currently being tested in mm and should be in 2.6.18.

I've attached the patch if anyone wants to test it right now.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="digest-align.patch"

a2be755965f42ddc16a22d5dea68e8765435abf7
diff --git a/crypto/digest.c b/crypto/digest.c
index d9b6ac9..062d0a5 100644
--- a/crypto/digest.c
+++ b/crypto/digest.c
@@ -27,6 +27,7 @@
                    struct scatterlist *sg, unsigned int nsg)
 {
 	unsigned int i;
+	unsigned int alignmask = crypto_tfm_alg_alignmask(tfm);
 
 	for (i = 0; i < nsg; i++) {
 
@@ -38,12 +39,24 @@
 			unsigned int bytes_from_page = min(l, ((unsigned int)
 							   (PAGE_SIZE)) - 
 							   offset);
-			char *p = crypto_kmap(pg, 0) + offset;
-
+			char *src = crypto_kmap(pg, 0);
+			char *p = src + offset;
+
+			if (unlikely(offset & alignmask)) {
+				unsigned int bytes =
+					alignmask + 1 - (offset & alignmask);
+				bytes = min(bytes, bytes_from_page);
+				tfm->__crt_alg->cra_digest.dia_update
+						(crypto_tfm_ctx(tfm), p,
+						 bytes);
+				p += bytes;
+				bytes_from_page -= bytes;
+				l -= bytes;
+			}
 			tfm->__crt_alg->cra_digest.dia_update
 					(crypto_tfm_ctx(tfm), p,
 					 bytes_from_page);
-			crypto_kunmap(p, 0);
+			crypto_kunmap(src, 0);
 			crypto_yield(tfm);
 			offset = 0;
 			pg++;
@@ -54,7 +67,15 @@
 
 static void final(struct crypto_tfm *tfm, u8 *out)
 {
-	tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
+	unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
+	if (unlikely((unsigned long)out & alignmask)) {
+		unsigned int size = crypto_tfm_alg_digestsize(tfm);
+		u8 buffer[size + alignmask];
+		u8 *dst = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
+		tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), dst);
+		memcpy(out, dst, size);
+	} else
+		tfm->__crt_alg->cra_digest.dia_final(crypto_tfm_ctx(tfm), out);
 }
 
 static int setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int keylen)
@@ -69,18 +90,9 @@
 static void digest(struct crypto_tfm *tfm,
                    struct scatterlist *sg, unsigned int nsg, u8 *out)
 {
-	unsigned int i;
-
-	tfm->crt_digest.dit_init(tfm);
-		
-	for (i = 0; i < nsg; i++) {
-		char *p = crypto_kmap(sg[i].page, 0) + sg[i].offset;
-		tfm->__crt_alg->cra_digest.dia_update(crypto_tfm_ctx(tfm),
-		                                      p, sg[i].length);
-		crypto_kunmap(p, 0);
-		crypto_yield(tfm);
-	}
-	crypto_digest_final(tfm, out);
+	init(tfm);
+	update(tfm, sg, nsg);
+	final(tfm, out);
 }
 
 int crypto_init_digest_flags(struct crypto_tfm *tfm, u32 flags)
diff --git a/crypto/michael_mic.c b/crypto/michael_mic.c
index 4f6ab23..701f859 100644
--- a/crypto/michael_mic.c
+++ b/crypto/michael_mic.c
@@ -145,6 +145,7 @@
 	.cra_blocksize	= 8,
 	.cra_ctxsize	= sizeof(struct michael_mic_ctx),
 	.cra_module	= THIS_MODULE,
+	.cra_alignmask	= 3,
 	.cra_list	= LIST_HEAD_INIT(michael_mic_alg.cra_list),
 	.cra_u		= { .digest = {
 	.dia_digestsize	= 8,
diff --git a/crypto/sha1.c b/crypto/sha1.c
index 21571ed..b96f57d 100644
--- a/crypto/sha1.c
+++ b/crypto/sha1.c
@@ -112,6 +112,7 @@
 	.cra_blocksize	=	SHA1_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct sha1_ctx),
 	.cra_module	=	THIS_MODULE,
+	.cra_alignmask	=	3,
 	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	SHA1_DIGEST_SIZE,
diff --git a/crypto/sha256.c b/crypto/sha256.c
index 9d5ef67..d62264a 100644
--- a/crypto/sha256.c
+++ b/crypto/sha256.c
@@ -313,6 +313,7 @@
 	.cra_blocksize	=	SHA256_HMAC_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct sha256_ctx),
 	.cra_module	=	THIS_MODULE,
+	.cra_alignmask	=	3,
 	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	SHA256_DIGEST_SIZE,
diff --git a/crypto/sha512.c b/crypto/sha512.c
index 3e6e939..7dbec4f 100644
--- a/crypto/sha512.c
+++ b/crypto/sha512.c
@@ -281,6 +281,7 @@
         .cra_blocksize  = SHA512_HMAC_BLOCK_SIZE,
         .cra_ctxsize    = sizeof(struct sha512_ctx),
         .cra_module     = THIS_MODULE,
+	.cra_alignmask	= 3,
         .cra_list       = LIST_HEAD_INIT(sha512.cra_list),
         .cra_u          = { .digest = {
                                 .dia_digestsize = SHA512_DIGEST_SIZE,
@@ -295,6 +296,7 @@
         .cra_flags      = CRYPTO_ALG_TYPE_DIGEST,
         .cra_blocksize  = SHA384_HMAC_BLOCK_SIZE,
         .cra_ctxsize    = sizeof(struct sha512_ctx),
+	.cra_alignmask	= 3,
         .cra_module     = THIS_MODULE,
         .cra_list       = LIST_HEAD_INIT(sha384.cra_list),
         .cra_u          = { .digest = {
diff --git a/crypto/tgr192.c b/crypto/tgr192.c
index 2d8e44f..1eae1bb 100644
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -627,6 +627,7 @@
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr192.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR192_DIGEST_SIZE,
@@ -641,6 +642,7 @@
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr160.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR160_DIGEST_SIZE,
@@ -655,6 +657,7 @@
 	.cra_blocksize = TGR192_BLOCK_SIZE,
 	.cra_ctxsize = sizeof(struct tgr192_ctx),
 	.cra_module = THIS_MODULE,
+	.cra_alignmask = 7,
 	.cra_list = LIST_HEAD_INIT(tgr128.cra_list),
 	.cra_u = {.digest = {
 			     .dia_digestsize = TGR128_DIGEST_SIZE,

--vkogqOf2sHV7VnPd--
