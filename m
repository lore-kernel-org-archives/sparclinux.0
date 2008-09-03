From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 22:12:48 +0000
Subject: Re: [patch 2/2] rtc-m48t59: add support for M48T02 and M48T59 chips
Message-Id: <20080903.151248.246660587.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200809032154.m83Lsivb005968@imap1.linux-foundation.org>
In-Reply-To: <200809032154.m83Lsivb005968@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: akpm@linux-foundation.org
Date: Wed, 03 Sep 2008 14:54:44 -0700

> Add support for two compatible RTC:
> - M48T08 which does not have alarm part,
> - M48T08 which does not have alarm part and has
>   only 2KB of NVRAM
> 
> These types covers all Mostek's RTC used in Sun UltraSparc workstations.
> 
> Tested on Sun Ultra60 with M48T59 RTC.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Also applied to sparc-next-2.6
