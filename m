From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 22 Dec 2004 09:06:00 +0000
Subject: Re: [sparc32] [4/4] rtc warnings and link errors
Message-Id: <20041222090600.GR771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221114234.GO771@holomorphy.com>
In-Reply-To: <20041221114234.GO771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
>>--- sparc32-2.6.10-rc3.orig/drivers/sbus/char/rtc.c	2004-10-07 04:01:41.000000000 -0700
>>+++ sparc32-2.6.10-rc3/drivers/sbus/char/rtc.c	2004-12-21 03:29:32.959536378 -0800
>>@@ -20,6 +20,7 @@
>> #include <linux/poll.h>
>> #include <linux/init.h>
>> #include <linux/smp_lock.h>
>>+#include <asm/io.h>
>> #include <asm/mostek.h>

On Tue, Dec 21, 2004 at 10:07:06PM -0600, Bob Breuer wrote:
> In the bk snapshots, this is already fixed but in an alternate way by 
> including asm/io.h from asm/mostek.h.

Brilliant... this is getting messy already. I may need to start some
kind of -mm -style tree to keep based off a current enough bk snapshot
while having everyone synchronized.


-- wli
