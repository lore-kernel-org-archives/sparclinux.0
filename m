From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 30 Aug 2010 17:58:22 +0000
Subject: Re: [PATCH 0/9] add OLPC device-tree support
Message-Id: <AANLkTikvVizX2jcnxgWOcJoewXR1hAE5SsEd9yzPF9Ys@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian> <20100829235100.6dcedcb8@debxo>
In-Reply-To: <20100829235100.6dcedcb8@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: pgf-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mitch Bradley <wmb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

On Sun, Aug 29, 2010 at 9:51 PM, Andres Salomon <dilinger@queued.net> wrote:
> These patches modify drivers/of, sparc, and x86 accordingly to add
> OLPC device-tree support. =A0Updates have been made based upon Grant and
> Davem's comments. =A0They've been compile-tested on sparc64 and x86, and
> runtime tested on OLPC machines.
>
> Dave's 25edd6946 commit caused some conflicts w/ patch #2;
> hopefully I mangled it properly.

I've only looked through this code lightly, but it seems fairly sane,
other than issues already raised.  Since this has more impact on sparc
than anything, I'll need to have David's feedback before doing
anything with it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
