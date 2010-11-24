From: David VomLehn <dvomlehn@cisco.com>
Date: Wed, 24 Nov 2010 18:18:26 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <20101124181825.GA17112@dvomlehn-lnx2.corp.sa.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
In-Reply-To: <1290607413.12457.44.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <michael-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Nov 25, 2010 at 01:03:33AM +1100, Michael Ellerman wrote:
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

I'm looking at it the other way. There are inconsistencies in naming of
symbols and files we definitely should clean up. Since we're doing that,
let's take the opportunity to move from of* to dt*. With multiple
architectures adding device tree support, this is about the last chance
to do this without impacting too many people.
-- 
David VL
