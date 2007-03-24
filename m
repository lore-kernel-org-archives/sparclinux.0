From: Jiri Gaisler <jiri@gaisler.com>
Date: Sat, 24 Mar 2007 16:53:31 +0000
Subject: Re: sparc32 SMP debugging advice needed
Message-Id: <4605578B.6040005@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <460449B6.7010308@earthlink.net>
In-Reply-To: <460449B6.7010308@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I have a feeling that the broken sparc32 SMP is related to
the CPU-specific SMP code, rather than the whole sparc32 port.
We have added SMP support for the leon3 (V8) processor to
linux-2.6.18.1, and are happily running systems with 8 CPUs
in hardware and up to 16 CPUs in simulation. This is done
using cache snooping to synchronize processors, i.e. we do
NOT flush or disable data caches to keep the system running.

I would therefore appreciate if the sparc32 SMP code was left
in the kernel, and not removed because it does not work on
legacy Sun systems. Leon3/SMP will be used in several projects
(and products), including the UC Berkeley RAMP massively parallel
computer system. We will make an effort to sync our leon3
port to the latest kernel version (2.6.21 ?), and try (again)
to submit the patches for review and inclusion in the
mainstream kernel.

Jiri Gaisler.
Gaisler Research.

Tom "spot" Callaway wrote:
> On Fri, 2007-03-23 at 17:42 -0400, Robert Reif wrote:
>> Any advice on how to approach fixing these issues?  I can test
>> patches.
> 
> Sadly, it seems that in the case of sparc32, no one who is willing is
> able, and no one who is able is willing.
> 
> There is no maintainer, Dave Miller isn't willing to take it on (not
> that I blame him), and much of the hardware is starting to fail, making
> debugging that much more fun.
> 
> Given that UP has so many issues, I don't even fathom how SMP is going
> to work right anytime soon.
> 
> I'd be happy to be proven wrong here, but the likelyhood of a stable
> sparc32 kernel is very very low.
> 
> ~spot
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
