From: David Miller <davem@davemloft.net>
Date: Tue, 28 Aug 2012 19:11:06 +0000
Subject: [PATCH] sparc64: Fix spelling of CAMELLIA in CFR macro name and comment.
Message-Id: <20120828.151106.2040192207485851644.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while working on the CAMMLIA driver.

 arch/sparc/include/asm/pstate.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/pstate.h b/arch/sparc/include/asm/pstate.h
index 6dfa8f8..4b6b998 100644
--- a/arch/sparc/include/asm/pstate.h
+++ b/arch/sparc/include/asm/pstate.h
@@ -92,7 +92,7 @@
 #define CFR_AES		_AC(0x0000000000000001,UL) /* Supports AES opcodes     */
 #define CFR_DES		_AC(0x0000000000000002,UL) /* Supports DES opcodes     */
 #define CFR_KASUMI	_AC(0x0000000000000004,UL) /* Supports KASUMI opcodes  */
-#define CFR_CAMELIA	_AC(0x0000000000000008,UL) /* Supports CAMELIA opcodes */
+#define CFR_CAMELLIA	_AC(0x0000000000000008,UL) /* Supports CAMELLIA opcodes*/
 #define CFR_MD5		_AC(0x0000000000000010,UL) /* Supports MD5 opcodes     */
 #define CFR_SHA1	_AC(0x0000000000000020,UL) /* Supports SHA1 opcodes    */
 #define CFR_SHA256	_AC(0x0000000000000040,UL) /* Supports SHA256 opcodes  */
-- 
1.7.10.4

