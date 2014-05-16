From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:06 +0000
Subject: [PATCH 28/34] sparc64: fix sparse warnings in aes_glue.c
Message-Id: <1400275572-17424-28-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-28-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-28-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
aes_glue.c:127:16: warning: symbol 'aes128_ops' was not declared. Should it be static?
aes_glue.c:139:16: warning: symbol 'aes192_ops' was not declared. Should it be static?
aes_glue.c:151:16: warning: symbol 'aes256_ops' was not declared. Should it be static?

Fix by defining the variables static as they are not used outside this file

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/crypto/aes_glue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/crypto/aes_glue.c b/arch/sparc/crypto/aes_glue.c
index 503e6d9..df922f5 100644
--- a/arch/sparc/crypto/aes_glue.c
+++ b/arch/sparc/crypto/aes_glue.c
@@ -124,7 +124,7 @@ extern void aes_sparc64_ctr_crypt_256(const u64 *key, const u64 *input,
 				      u64 *output, unsigned int len,
 				      u64 *iv);
 
-struct aes_ops aes128_ops = {
+static struct aes_ops aes128_ops = {
 	.encrypt		= aes_sparc64_encrypt_128,
 	.decrypt		= aes_sparc64_decrypt_128,
 	.load_encrypt_keys	= aes_sparc64_load_encrypt_keys_128,
@@ -136,7 +136,7 @@ struct aes_ops aes128_ops = {
 	.ctr_crypt		= aes_sparc64_ctr_crypt_128,
 };
 
-struct aes_ops aes192_ops = {
+static struct aes_ops aes192_ops = {
 	.encrypt		= aes_sparc64_encrypt_192,
 	.decrypt		= aes_sparc64_decrypt_192,
 	.load_encrypt_keys	= aes_sparc64_load_encrypt_keys_192,
@@ -148,7 +148,7 @@ struct aes_ops aes192_ops = {
 	.ctr_crypt		= aes_sparc64_ctr_crypt_192,
 };
 
-struct aes_ops aes256_ops = {
+static struct aes_ops aes256_ops = {
 	.encrypt		= aes_sparc64_encrypt_256,
 	.decrypt		= aes_sparc64_decrypt_256,
 	.load_encrypt_keys	= aes_sparc64_load_encrypt_keys_256,
-- 
1.9.0

