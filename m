From: Namhyung Kim <namhyung@gmail.com>
Date: Mon, 25 Oct 2010 15:52:37 +0000
Subject: [PATCH 2/3] sparc32: remove CONFIG_HAVE_PERF_EVENTS option
Message-Id: <1288021958-3130-2-git-send-email-namhyung@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1288021958-3130-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Remove HAVE_PERF_EVENTS and PERF_USE_VMALLOC under config
SPARC because they're under SPARC64 too. Supporting
perf_event needs atomic64 operations but AFAIK sparc32
doesn't provide them, CMIIW. ;-) Also removes redundant
HAVE_IRQ_WORK line.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 arch/sparc/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 3e9d314..4db8bc0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -27,8 +27,6 @@ config SPARC
 	select RTC_CLASS
 	select RTC_DRV_M48T59
 	select HAVE_IRQ_WORK
-	select HAVE_PERF_EVENTS
-	select PERF_USE_VMALLOC
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_API_DEBUG
 	select HAVE_ARCH_JUMP_LABEL
@@ -55,7 +53,6 @@ config SPARC64
 	select RTC_DRV_BQ4802
 	select RTC_DRV_SUN4V
 	select RTC_DRV_STARFIRE
-	select HAVE_IRQ_WORK
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 
-- 
1.7.0.4

