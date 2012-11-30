From: David Miller <davem@davemloft.net>
Date: Fri, 30 Nov 2012 16:46:51 +0000
Subject: Re: SPARC and OF_GPIO
Message-Id: <20121130.114651.461648561907776096.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121107065258.GA22325@avionic-0098.mockup.avionic-design.de>
	<20121107.023419.1656398773495533906.davem@davemloft.net>
	<20121130093520.631503E070C@localhost>
In-Reply-To: <20121130093520.631503E070C@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: thierry.reding@avionic-design.de, sparclinux@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 30 Nov 2012 09:35:20 +0000

> On non-sparc I've actually been moving in the direction of resolving
> resources at .probe time to make it easier to handle deferred probing.
> So if, for example, a device irq line is routed to a GPIO instead of the
> core interrupt controller, then the irq number won't be known until
> after the gpio driver .probe occurs. For addresses, this situation is
> unlikely, but for all the other kinds of resources (gpios, regs, clocks, irqs,
> etc) it is a problem that we're actually seeing.

Every interrupt in the device tree is resolvable with, at worst, very
small bus drivers, and that's what we pack into the generic sparc OF
device creation layer.

Actually much of it is generic and not bus type specific at all, and
is a simply mask and match into an interrupt routing table property.
