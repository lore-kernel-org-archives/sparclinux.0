From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 30 Nov 2014 17:03:43 +0000
Subject: [PATCH 2/8 v2] sparc64: replace memset by memzero_explicit
Message-Id: <1417367029-32762-3-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <1417367029-32762-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1417367029-32762-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Memset on a local variable may be removed when it is called just before the
variable goes out of scope.  Using memzero_explicit defeats this
optimization.  A simplified version of the semantic patch that makes this
change is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
type T;
@@

{
... when any
T x[...];
... when any
    when exists
- memset
+ memzero_explicit
  (x,
-0,
  ...)
... when != x
    when strict
}
// </smpl>

This change was suggested by Daniel Borkmann <dborkman@redhat.com>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Daniel Borkmann suggested that these patches could go through Herbert Xu's
cryptodev tree.

I was not able to compile these.

v2: fixed email address

 arch/sparc/crypto/sha256_glue.c |    2 +-
 arch/sparc/crypto/sha512_glue.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/crypto/sha512_glue.c b/arch/sparc/crypto/sha512_glue.c
index 9fff885..11eb36c 100644
--- a/arch/sparc/crypto/sha512_glue.c
+++ b/arch/sparc/crypto/sha512_glue.c
@@ -139,7 +139,7 @@ static int sha384_sparc64_final(struct shash_desc *desc, u8 *hash)
 	sha512_sparc64_final(desc, D);
 
 	memcpy(hash, D, 48);
-	memset(D, 0, 64);
+	memzero_explicit(D, 64);
 
 	return 0;
 }
diff --git a/arch/sparc/crypto/sha256_glue.c b/arch/sparc/crypto/sha256_glue.c
index 41f27cc..285268c 100644
--- a/arch/sparc/crypto/sha256_glue.c
+++ b/arch/sparc/crypto/sha256_glue.c
@@ -135,7 +135,7 @@ static int sha224_sparc64_final(struct shash_desc *desc, u8 *hash)
 	sha256_sparc64_final(desc, D);
 
 	memcpy(hash, D, SHA224_DIGEST_SIZE);
-	memset(D, 0, SHA256_DIGEST_SIZE);
+	memzero_explicit(D, SHA256_DIGEST_SIZE);
 
 	return 0;
 }

