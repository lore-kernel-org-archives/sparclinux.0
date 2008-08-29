From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 06:09:25 +0000
Subject: [PATCH 3/12]: sparc64: Check for RTC class device in
Message-Id: <20080828.230925.100079001.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Check for RTC class device in update_persistent_clock().

As we convert the various by-hand sparc64 RTC drivers to use the
generic RTC framework and drivers, we need to keep the NTP
set_rtc_mmss() support via update_persistent_clock() working.

In the end, after all the RTC device cases are converted, this
local set_rtc_mmss() function will be deleted.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/time.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index cc16fdc..184321b 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -405,6 +405,11 @@ static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 
 int update_persistent_clock(struct timespec now)
 {
+	struct rtc_device *rtc = rtc_class_open("rtc0");
+
+	if (rtc)
+		return rtc_set_mmss(rtc, now.tv_sec);
+
 	return set_rtc_mmss(now.tv_sec);
 }
 
-- 
1.5.6.5.GIT

