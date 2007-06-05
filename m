From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jun 2007 20:03:11 +0000
Subject: Re: section mismatches from sun4v*_patch in trampoline.S
Message-Id: <20070605.130311.26963029.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070602203206.GA13700@uranus.ravnborg.org>
In-Reply-To: <20070602203206.GA13700@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 5 Jun 2007 11:13:45 +0200

> On Mon, Jun 04, 2007 at 11:58:28PM -0700, David Miller wrote:
> > The __INIT and __INITDATA assembler macros in linux/init.h for a while
> > would select the section properly based upon whether CPU hotplug was
> > enabled or not, but that got reverted by:
> > 
> > 838c41184fee5e151c09972f2ba90c16493af614
> > 
> > I guess it's much better to put the ugly ifdefs into the assembler
> > code by someone's estimation :-( That's how the x86 trampoline.S, for
> > example, is handling this.
> That change was anyway bogus.
> There should be a 1:1 between __init and __INIT

I see, that's right.

> Will cook up a patch for this.

Thanks a lot Sam.
