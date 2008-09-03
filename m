From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 21:41:43 +0000
Subject: Re: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <20080903.144143.267921250.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Wed, 3 Sep 2008 18:32:32 +0200

> This is my clumsy attempt to convert the sparc32
> to the RTC subsystem.
> These patches require two patches from the -mm tree:
>
> rtc-m48t59-reduce-structure-m48t59_private.patch
> rtc-m48t59-add-support-for-m48t02-and-m48t59-chips-2nd-rev.patch
> 
> The driver was tested on SS20.
> 
> Robert, please test it on as many machine as you can.

Krzystztof I like this work and I'd like to merge it into
sparc-next-2.6

But there are those two patches from -mm that are dependencies.

Andrew, would you mind if I carried those two RTC patches in -mm
mentioned above in sparc-next-2.6?  The exist only to support
Sparc RTC chips anyways, so to me this plan seems to make the most
sense.

Thanks!
