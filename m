From: David Miller <davem@davemloft.net>
Date: Tue, 16 Mar 2010 21:41:32 +0000
Subject: [PATCH] sunxvr1000: Add missing FB=y depenency.
Message-Id: <20100316.144132.147193321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


While doing test builds I noticed that the dependencies for
the xvr1000 driver were wrong and could result in build
errors.

Applied to sparc-2.6

sunxvr1000: Add missing FB=y depenency.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index a5755b8..f15fb02 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -911,7 +911,7 @@ config FB_XVR2500
 
 config FB_XVR1000
 	bool "Sun XVR-1000 support"
-	depends on SPARC64
+	depends on (FB = y) && SPARC64
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.6.6.1

