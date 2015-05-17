From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Sun, 17 May 2015 10:54:14 +0000
Subject: [PATCH 3/6] crypto: powerpc/md5: use md5 IV MD5_HX instead of their raw value
Message-Id: <1431860057-5232-3-git-send-email-clabbe.montjoie@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au, davem@davemloft.net, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, aaro.koskinen@iki.fi
Cc: linux-crypto@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

Since MD5 IV are now available in crypto/md5.h, use them.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/powerpc/crypto/md5-glue.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/crypto/md5-glue.c b/arch/powerpc/crypto/md5-glue.c
index 452fb4d..9228967 100644
--- a/arch/powerpc/crypto/md5-glue.c
+++ b/arch/powerpc/crypto/md5-glue.c
@@ -37,10 +37,10 @@ static int ppc_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *sctx = shash_desc_ctx(desc);
 
-	sctx->hash[0] = 0x67452301;
-	sctx->hash[1] = 0xefcdab89;
-	sctx->hash[2] = 0x98badcfe;
-	sctx->hash[3] =	0x10325476;
+	sctx->hash[0] = MD5_H0;
+	sctx->hash[1] = MD5_H1;
+	sctx->hash[2] = MD5_H2;
+	sctx->hash[3] =	MD5_H3;
 	sctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6

