From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Sun, 04 Jan 2004 22:19:23 +0000
Subject: Re: [SPARC32] Early kernel panic with 2.6.1rc1
Message-Id: <20040104221922.GB5492@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1073231988.22653.23.camel@zorak>
In-Reply-To: <1073231988.22653.23.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 04, 2004 at 09:59:49AM -0600, Tom 'spot' Callaway wrote:

> This panic happens when I've got a keyboard on it too, I just can't get
> it all, unless I pull the keyboard and boot it -p over serial.
> NOTE: This is an UP kernel, even though the SS20 is SMP.

> Caller[f0207cf4]: serial8250_console_setup+0xa0/0xb0

I'll look at making it not panic just because of this, but there's
zero reason to include 8250 support on sparcstations.  Doubly so for
console support.  Zilog is what you want.

> I stripped the symbols from the kernel to make it small enough to build,
> I'm going to rebuild it and run ksymoops on it (I assume that still is
> the path in 2.6?)

Thanks to kallsyms, the dump it generated is sufficient.  Stripping
the symbols doesn't remove the actual kernel symbol tables used by
kallsyms.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
