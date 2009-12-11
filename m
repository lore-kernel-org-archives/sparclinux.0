From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Dec 2009 06:19:00 +0000
Subject: Re: [PATCH 06/11] of/flattree: merge early_init_devtree() and
Message-Id: <fa686aa40912102219s11a2aba3nc61bc0f53b0e9ffe@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20091124081316.6216.66310.stgit@angua> <20091124081853.6216.68105.stgit@angua>
	<1259208248.16367.230.camel@pasglop>
In-Reply-To: <1259208248.16367.230.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, sfr@canb.auug.org.au, davem@davemloft.net, monstr@monstr.eu

On Wed, Nov 25, 2009 at 9:04 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:
>> =A0/**
>> + * early_init_move_devtree - move tree to an unused area, if needed.
>> + *
>> + * The device tree may be allocated beyond our memory limit, or inside =
the
>> + * crash kernel region for kdump. If so, move it out of the way.
>> + */
>> +#if defined(CONFIG_PPC)
>> +static void __init early_init_move_devtree(void)
>
> And you still end up with an ifdef mess in the common code ...

The #ifdefs are temporary.  I'm leaving them in now exactly because
they are ugly and show where the code needs to be refactored and
reorganized.  Once everything is merged, I'll probably do exactly what
you suggest.  I just cannot yet tell the exact structure of it until I
see the merged version.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
