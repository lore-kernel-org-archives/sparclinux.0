From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 29 Nov 2010 06:07:20 +0000
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Message-Id: <AANLkTi=KBsMDvG2wZDu6ZtctWzd_bdQ=tO97eZu1R+VL@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
	<20101129055529.GB17113@yookeroo>
In-Reply-To: <20101129055529.GB17113@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <michael-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mips <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>

On Sun, Nov 28, 2010 at 10:55 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Fri, Nov 26, 2010 at 12:34:35AM +1100, Michael Ellerman wrote:
>> Most of these are straight renames, but some have changed more
>> substantially. The routines for the flat tree have all become fdt_foo().
>
> I'm a little uneasy about using the same prefix as libfdt (fdt_foo())
> for routines that have a different implementation and different names
> / semantics to the libfdt routines.

I'd also be okay with either dtflat_ or flatdt_ for the prefix on
these routines.

g.
