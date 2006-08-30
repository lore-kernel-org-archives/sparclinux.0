From: David Miller <davem@davemloft.net>
Date: Wed, 30 Aug 2006 08:39:13 +0000
Subject: Re: Hot swappable CPU's on SPARC64?
Message-Id: <20060830.013913.85412176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87d5ai62nq.fsf@pumba.bayour.com>
In-Reply-To: <87d5ai62nq.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Turbo Fredriksson <turbo@swe.net>
Date: Wed, 30 Aug 2006 10:36:25 +0200

> I noticed when I made a new kernel for my x86 that there
> was an option for hot swappable CPU's. But this didn't exist
> on SPARC... ?
> 
> I just acquired an Sun Enterprise 3000, and I think I read something
> about hot swappable CPU's (?) or at least hot swappable something...
> 
> Something about the machine could continue running even if hardware
> failed...
> 
> I wanted to try out this on Linux (the manual only referred to Solaris
> - surprise surprise :).

We don't support cpu hot swapping.

Hot swapping a board on an enterprise system is no cake walk,
in fact you have to jumpstart the board with JTAG scans and
things of that nature.  It's a lot of work, and as these systems
get older and older the incentive to do this kind of work
diminishes.

Sorry.
