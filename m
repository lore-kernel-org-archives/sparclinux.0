From: David Miller <davem@davemloft.net>
Date: Thu, 04 Sep 2008 01:49:47 +0000
Subject: Re: [PATHC 0/2] sparc32: convert to RTC subsystem
Message-Id: <20080903.184947.193700115.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
In-Reply-To: <20080903183232.b57f5a05.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 03 Sep 2008 21:42:54 -0400

> Krzysztof Helt wrote:
> > Robert, please test it on as many machine as you can.
> >
> >   
> With latest sparc-next, my ss20 boots now but the clock is suspect.
> 
> Time is initially set to Dec 31, 1969 but ntp fixes it.
> 
> I'm using debian etch so I'm not sure it's setup for generic rtc.
> I had to make a link for /dev/rtc to get things somewhat working.
> This could be a bad NVRAM but openboot doesn't complain.

Older hwclock binaries won't look for /dev/rtc0, newer ones do.
So the symlink is necessary for machines with the older binary.

> Time read from Hardware Clock: 2108/09/04 01:30:25
> Invalid values in hardware clock: 2108/09/04 01:30:25

Hmmm, 100 years too large, that looks familiar.

Krzysztof?
