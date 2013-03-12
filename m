From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 12 Mar 2013 20:35:19 +0000
Subject: [PATCH] sparc: delete "if !ULTRA_HAS_POPULATION_COUNT"
Message-Id: <1363120519.3137.148.camel@x61.thuisdomein>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 2d78d4beb64eb07d50665432867971c481192ebf ("[PATCH] bitops:
sparc64: use generic bitops") made the default of GENERIC_HWEIGHT depend
on !ULTRA_HAS_POPULATION_COUNT. But since there's no Kconfig symbol with
that name, this always evaluates to true. Delete this dependency.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Tested with "make ARCH=sparc menuconfig" (before and after this
patch).

1) There apparently is an (obscure) preprocessor macro
ULTRA_HAS_POPULATION_COUNT. But the check for it got removed in commit
ef7c4d4675d2a9206f913f26ca1a5cd41bff9d41 ("sparc: Use popc if possible
for hweight routines."). 

 arch/sparc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 289127d..7fcd4b4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -197,7 +197,7 @@ config RWSEM_XCHGADD_ALGORITHM
 
 config GENERIC_HWEIGHT
 	bool
-	default y if !ULTRA_HAS_POPULATION_COUNT
+	default y
 
 config GENERIC_CALIBRATE_DELAY
 	bool
-- 
1.7.11.7

