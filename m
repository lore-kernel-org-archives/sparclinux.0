From: "C.Newport" <crn@netunix.com>
Date: Sat, 24 Jul 2004 01:16:09 +0000
Subject: Re: sparc32 status
Message-Id: <200407240216.09840.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040713160257.GA8148@foobazco.org>
In-Reply-To: <20040713160257.GA8148@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 23 July 2004 10:50 pm, Patrick Finnegan wrote:
> On Tuesday 13 July 2004 17:38, C.Newport wrote:
> > Sun4d is not a question of "nobody cares", the point is that without
> > SMP it is rather pointless. AIUI, SMP has never worked because nobody
> > knew how to initialise the bus handling correctly due to a lack of
> > documentation. This is why I tracked down the man in Sun who knows
> > how it works. Once the bus handling issues are understood the rest
> > should be almost identical to Sun4m.
>
> Umm, my SC2000E identifies, and I'm pretty sure does SMP with all of the
> processors it has in it... it'd be nice if that functionality was at
> least brought to 2.4, though 2.6 seems like a better idea at this
> point.

Could you check on this and make sure ?. Also tell us what kernel you
are using and how it is configured. My SS1000E will definitely not use 
more than one processor. Some non-SMP 2.2.x kernels will report the
processors but enabling SMP hangs the system.


