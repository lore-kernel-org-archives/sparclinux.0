From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:23 +0000
Subject: [PATCH 2/12]: sparc64: Select RTC_CLASS
Message-Id: <20080828.230923.262666276.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Select RTC_CLASS

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
index 8df7371..19f0cc8 100644
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -19,6 +19,7 @@ config SPARC64
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_ARCH_TRACEHOOK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select RTC_CLASS
 
 config GENERIC_TIME
 	bool
-- 
1.5.6.5.GIT

