From: Jiri Gaisler <jiri@gaisler.com>
Date: Sun, 13 Feb 2005 12:27:53 +0000
Subject: Re: sparc32 SMP for 2.6
Message-Id: <420F47C9.1060303@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <420F070B.8010000@mc.net>
In-Reply-To: <420F070B.8010000@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We are currently investigating how to add linux SMP support for the
leon sparc processor, so your patches are appreciated! I will
report back in case we find/solve other issues. We have both a
behavioural simulator and a FPGA system with on-chip debug support,
so tracing and debugging SMP software should be a bit easier than on
Sun hardware ...

Jiri Gaisler.

Bob Breuer wrote:
> I've been poking at the sparc32 SMP code and I have it to the point
> where it will run a minimal userland.  It is still far from being
> stable though.
> 
> For reference, I started with the SMP patch [0] that wli sent to
> the list last July.  To go along with the attached SMP patch, it
> needs the spinlock fix [1] from Art Haas, and the attached
> DEBUGSPINLOCK patch from Tom Callaway.

