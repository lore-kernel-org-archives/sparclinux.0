From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 22 Dec 2004 17:41:58 +0000
Subject: Re: [sparc32] [3/3] sun4d prom_adjust_ranges extern
Message-Id: <20041222174158.GU771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1103693931.3913.72.camel@localhost.localdomain>
In-Reply-To: <1103693931.3913.72.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 21, 2004 at 11:38:51PM -0600, Tom 'spot' Callaway wrote:
> Chris Newport and Thomas Bogendoerfer's sun4d patch adds a
> prom_adjust_ranges call to drivers/sbus/sbus.c, but no extern for the
> function, so we get this warning:
> drivers/sbus/sbus.c: In function `sbus_bus_ranges_init':
> drivers/sbus/sbus.c:243: warning: implicit declaration of function
> `prom_adjust_ranges'
> Adding the extern makes the warning go away.

Hmm, I don't like the extern decl in code instead of a header; I
had already dropped a decl into sbus.h before I got this, but am not
sure if that's the ideal location for it. It doesn't really fit in with
various other prom functions, but it doesn't really fit in sbus.h either.

I'm going to have something to ship rather shortly (it's already put
together, I've just been interrupted before I can assemble tarballs etc.
so we should be able to move on this shortly. It will be -mm -style so
some well-defined kernel.org kernel version will be able to be patched,
though I'm thinking of rebasing it against 2.6.10-rc3 since 2.6.9 needs
18MB of diff to get to current. This should all go to 2.6.10, I'm just
trying to get something that covers enough ground to make people happy.

-- wli
