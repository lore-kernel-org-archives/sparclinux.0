From: David Miller <davem@davemloft.net>
Date: Wed, 17 Dec 2008 11:06:24 +0000
Subject: Re: random dumb (or maybe not) question about sparc64
Message-Id: <20081217.030624.231765305.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812091146.mB9Bkqn02109@elf.torek.net>
In-Reply-To: <200812091146.mB9Bkqn02109@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Wed, 17 Dec 2008 02:17:59 -0700

> >I guess Chris is not excited enough about this issue to
> >reply :-)
> 
> Heh, more like, back-burnered, and not sufficiently knowledgeable
> about the ptrace code to have commented earlier.
> 
> I do now have some (sparc64) code for doing oprofile stack traces
> on interrupts I can send in now, though.  There's one possibly-a-bug
> issue I'm not at all sure about, and various possible style items,
> and of course for those using sparc32, someone would have to make
> appropriate adjustments.
> 
> Is there any interest in the oprofile code?

Sure.

I added NMI oprofile support in the sparc-next-2.6 tree so
you probably want to submit your changes relative to
that:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next-2.6.git
