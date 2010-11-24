From: David Daney <ddaney@caviumnetworks.com>
Date: Wed, 24 Nov 2010 17:00:46 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <4CED44BE.1030405@caviumnetworks.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
In-Reply-To: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael@ellerman.id.au
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org

On 11/24/2010 06:03 AM, Michael Ellerman wrote:
> Hi all,
>
> There were some murmurings on IRC last week about renaming the of_*()
> routines. I was procrastinating at the time and said I'd have a look at
> it, so here I am.
>
> The thinking is that on many platforms that use the of_() routines
> OpenFirmware is not involved at all, this is true even on many powerpc
> platforms. Also for folks who don't know the OpenFirmware connection it
> reads as "of", as in "a can of worms".
>
> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".
>
> As step one I've just renamed as many routines as I could find to see
> what the resulting patch looks like, so we can quantify the churn. I
> also did device.of_node, which is used quite a bit.
>
> Thoughts?
>
> of ->  dt most places I could think of (done mechanically):
>
[...]
>   drivers/of/address.c                               |  114 ++++++------
>   drivers/of/base.c                                  |   14 +-
>   drivers/of/device.c                                |   36 ++--
>   drivers/of/fdt.c                                   |    4 +-
>   drivers/of/gpio.c                                  |   32 ++--
>   drivers/of/irq.c                                   |    4 +-
>   drivers/of/of_i2c.c                                |   18 +-
>   drivers/of/of_mdio.c                               |   16 +-
>   drivers/of/of_spi.c                                |   12 +-
>   drivers/of/pdt.c                                   |    4 +-
>   drivers/of/platform.c                              |  212 ++++++++++----------

Well, not that I care one way or the other, but for consistency you 
should change all these directory and file names as well.

David Daney

