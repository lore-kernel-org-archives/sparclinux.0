From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 30 Nov 2012 09:35:20 +0000
Subject: Re: SPARC and OF_GPIO
Message-Id: <20121130093520.631503E070C@localhost>
List-Id: <sparclinux.vger.kernel.org>
References: <20121105095315.GG5847@avionic-0098.mockup.avionic-design.de> <20121106.184058.636480855516538607.davem@davemloft.net> <20121107065258.GA22325@avionic-0098.mockup.avionic-design.de> <20121107.023419.1656398773495533906.davem@davemloft.net>
In-Reply-To: <20121107.023419.1656398773495533906.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, thierry.reding@avionic-design.de
Cc: sparclinux@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org

On Wed, 07 Nov 2012 02:34:19 -0500 (EST), David Miller <davem@davemloft.net> wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> Date: Wed, 7 Nov 2012 07:52:58 +0100
> 
> > It seems like OF_ADDRESS would be trickier. A comment around line 60 in
> > drivers/of/platform.c says that SPARC doesn't need functions defined in
> > the enclosing #ifdef CONFIG_OF_ADDRESS block. I'm not sure it would be
> > acceptable to remove the conflict nonetheless, even if the functions
> > aren't used. One benefit would be that the code could receive some extra
> > compile coverage.
>  ...
> > Finally, OF_IRQ is again just generic code to map device tree data to
> > IRQ domains. While I didn't see the IRQ_DOMAIN symbol selected anywhere
> > in SPARC it should still be possible to run drivers that properly
> > implement IRQ domains on SPARC, right? Or is there any reason why they
> > wouldn't work?
> 
> These are the two most conflicted areas for Sparc.
> 
> For addresses, we fully compute the full fully resolved physical
> address of all registers of an OF device very early at bootup time
> when we first scan the device tree.
> 
> Same goes for interrupts, we fully compute them early in the bootup
> process.

Right. That's the reason I haven't tackled making all architectures do
the same thing. I've not been confident that I'd get the sparc bits
correct. I think it could be done, but I haven't been able to wrap my
brain around it sufficiently.

On non-sparc I've actually been moving in the direction of resolving
resources at .probe time to make it easier to handle deferred probing.
So if, for example, a device irq line is routed to a GPIO instead of the
core interrupt controller, then the irq number won't be known until
after the gpio driver .probe occurs. For addresses, this situation is
unlikely, but for all the other kinds of resources (gpios, regs, clocks, irqs,
etc) it is a problem that we're actually seeing.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
