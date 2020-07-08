From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 08 Jul 2020 16:39:40 +0000
Subject: [PATCH v2 2/5] crypto: lib/sha256 - add sha256() function
Message-Id: <20200708163943.52071-3-ebiggers@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200708163943.52071-1-ebiggers@kernel.org>
In-Reply-To: <20200708163943.52071-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, alsa-devel@alsa-project.org, linux-efi@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, sparclinux@vger.kernel.org, Matthieu Baerts <matthieu.baerts@tessares.net>, Guenter Roeck <groeck@chromium.org>, mptcp@lists.01.org, Ard Biesheuvel <ardb@kernel.org>, Cheng-Yi Chiang <cychiang@chromium.org>

From: Eric Biggers <ebiggers@google.com>

Add a function sha256() which computes a SHA-256 digest in one step,
combining sha256_init() + sha256_update() + sha256_final().

This is similar to how we also have blake2s().

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/crypto/sha.h |  1 +
 lib/crypto/sha256.c  | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/crypto/sha.h b/include/crypto/sha.h
index 10753ff71d46..4ff3da816630 100644
--- a/include/crypto/sha.h
+++ b/include/crypto/sha.h
@@ -147,6 +147,7 @@ static inline void sha256_init(struct sha256_state *sctx)
 }
 void sha256_update(struct sha256_state *sctx, const u8 *data, unsigned int len);
 void sha256_final(struct sha256_state *sctx, u8 *out);
+void sha256(const u8 *data, unsigned int len, u8 *out);
 
 static inline void sha224_init(struct sha256_state *sctx)
 {
diff --git a/lib/crypto/sha256.c b/lib/crypto/sha256.c
index 2e621697c5c3..2321f6cb322f 100644
--- a/lib/crypto/sha256.c
+++ b/lib/crypto/sha256.c
@@ -280,4 +280,14 @@ void sha224_final(struct sha256_state *sctx, u8 *out)
 }
 EXPORT_SYMBOL(sha224_final);
 
+void sha256(const u8 *data, unsigned int len, u8 *out)
+{
+	struct sha256_state sctx;
+
+	sha256_init(&sctx);
+	sha256_update(&sctx, data, len);
+	sha256_final(&sctx, out);
+}
+EXPORT_SYMBOL(sha256);
+
 MODULE_LICENSE("GPL");
-- 
2.27.0
