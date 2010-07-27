From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Jul 2010 01:57:17 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
Message-Id: <AANLkTi=Kw78W0zuuQ0vzO7rXXVkTDf0D5w8n44hV_FWt@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
	<20100726.154854.35052662.davem@davemloft.net>
	<AANLkTikpON7WUkTLrnW4y2kghM=H8cLCAFst08S3cL_Z@mail.gmail.com>
	<20100726.183808.15223674.davem@davemloft.net>
In-Reply-To: <20100726.183808.15223674.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

On Mon, Jul 26, 2010 at 7:38 PM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Mon, 26 Jul 2010 16:51:01 -0600
>
>> Indeed. =A0I looked at it briefly, but it wasn't immediately clear what
>> the impact would be to switch powerpc over to -1, and it looked to me
>> like sparc depends on -1 to signify no node association.
>
> Kernel wide, NUMA interfaces tend to take "-1" to mean "any node."
>
> I had looked over the powerpc cases, and besides 1 or 2 strange
> locations the powerpc call sites were ready to handle -1.

Okay, well let me rework the patch to make -1 the default and let
powerpc override it.  A follow-on patch can fix up the powerpc usage
of 0.

g.
