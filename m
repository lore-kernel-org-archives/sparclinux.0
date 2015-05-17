From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Sun, 17 May 2015 10:54:17 +0000
Subject: [PATCH 6/6] crypto: octeon: use md5 IV MD5_HX instead of their raw value
Message-Id: <1431860057-5232-6-git-send-email-clabbe.montjoie@gmail.com>
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
 arch/mips/cavium-octeon/crypto/octeon-md5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-md5.c b/arch/mips/cavium-octeon/crypto/octeon-md5.c
index 12dccdb..af4c712 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-md5.c
+++ b/arch/mips/cavium-octeon/crypto/octeon-md5.c
@@ -69,10 +69,10 @@ static int octeon_md5_init(struct shash_desc *desc)
 {
 	struct md5_state *mctx = shash_desc_ctx(desc);
 
-	mctx->hash[0] = cpu_to_le32(0x67452301);
-	mctx->hash[1] = cpu_to_le32(0xefcdab89);
-	mctx->hash[2] = cpu_to_le32(0x98badcfe);
-	mctx->hash[3] = cpu_to_le32(0x10325476);
+	mctx->hash[0] = cpu_to_le32(MD5_H0);
+	mctx->hash[1] = cpu_to_le32(MD5_H1);
+	mctx->hash[2] = cpu_to_le32(MD5_H2);
+	mctx->hash[3] = cpu_to_le32(MD5_H3);
 	mctx->byte_count = 0;
 
 	return 0;
-- 
2.3.6

