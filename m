From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Thu, 19 Feb 2004 21:53:32 +0000
Subject: Re: smp for sparc linux
Message-Id: <20040219215332.GA22107@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1077227356.1503.53.camel@pavlov.wgeddes.com>
In-Reply-To: <1077227356.1503.53.camel@pavlov.wgeddes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Feb 19, 2004 at 02:49:16PM -0700, Bill Geddes wrote:

> I have attempted to get the 2.6.2 linux sources compiled on my sparc
> linux machines - with the same failure 'include/asm/hardirq.h:147:
> `BR_GLOBALIRQ_LOCK' undeclared (first use in this function) '
> 
> Is a SMP linux kernel going to be possible for this architecture?
> Here is the output from /proc/cpuinfo on my machine:

I have good news and better news.  The good news is that I'm in the
process of getting sparc32 SMP to compile, and I'm down to only a few
areas in the SMP code itself that need major work.

For you, however, the better news is that you're using the wrong
architecture.  Your system is sparc64, which already has working SMP.

> cpu		: TI UltraSparc IIi

-- 
Keith M Wesolowski
