From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 20:37:15 +0000
Subject: Re: [PATCH] of/pdt: allow DT device matching by fixing 'name'
Message-Id: <20110223203715.GU14597@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110216222820.487AE9D401C@zog.reactivated.net>
	<1297896277.3011.5.camel@macbook.infradead.org>
	<AANLkTikAF2X1A5jfoNfCPRhZkZ7qPdZ57c8B5b9z4+qr@mail.gmail.com>
	<20110218190659.7f955e4c@queued.net>
	<20110223194352.GR14597@angua.secretlab.ca>
	<20110223115414.547b8c17@queued.net>
	<AANLkTi=D1eWGsN4JVWEGeHp3AXfpbOOKr9Fq7juGAXtT@mail.gmail.com>
In-Reply-To: <AANLkTi=D1eWGsN4JVWEGeHp3AXfpbOOKr9Fq7juGAXtT-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Drake <dsd-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbou-JGs/UdohzUI@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

On Wed, Feb 23, 2011 at 08:06:47PM +0000, Daniel Drake wrote:
> On 23 February 2011 19:54, Andres Salomon <dilinger@queued.net> wrote:
> >> Wait; why are you binding to a device based on name? =A0Binding by name
> >> and/or device_type is strongly discouraged for new code. =A0Use
> >> compatible instead.
> >>
> >
> > Daniel posted a separate patch showing his code, would you mind
> > commenting on that? =A0I noticed he didn't cc you though, here's the
> > patch:
> >
> > https://patchwork.kernel.org/patch/574901/
>=20
> It does bind to the name.
> We don't currently have a compatible property for the battery device.
> We could fix that with a firmware upgrade, but it would break
> compatibility with all existing installs. I guess this is still the
> recommended approach...

Hi Daniel,

As mentioned in my reply to your patch, the solution to this is fix up
the missing compatible property in the board support code before it
pollutes the global matching namespace.

g.

