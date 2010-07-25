From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 25 Jul 2010 20:37:38 +0000
Subject: Re: [PATCH] of: Provide default of_node_to_nid() when CONFIG_NUMA is
Message-Id: <AANLkTinE4X0iAJAiatc7Qtj2QP6dhyBKo9fqxqUt40Y6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100724154331.22701.3409.stgit@angua> <20100725130723.a5192793.sfr@canb.auug.org.au>
In-Reply-To: <20100725130723.a5192793.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Sat, Jul 24, 2010 at 9:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Grant,
>
> On Sat, 24 Jul 2010 09:43:31 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> of_node_to_nid() is only relevant for NUMA. =A0Don't force architectures=
 to
>> implement it if CONFIG_NUMA is not set.
>
> Why not just do:
>
> #ifndef of_node_to_nid
> static inline int of_node_to_nid(struct device_node *device) { return 0; }
> #define of_node_to_nid =A0of_node_to_nid
> #endif
>
> in include/linux/of.h
>
> and then add:
>
> #define of_node_to_nid =A0of_node_to_nid
>
> Where it is declared/defined for each arch ...
> (it would be nice if all the archs were consistent in where it was
> declared).

Two reasons; I had started doing that in topology.h, but it caused a
bunch of collateral damage with files missing the include, so I punted
and took the easy way out.  Also, I didn't know if that was an
acceptable or safe pattern for override symbols.

I'll spin it again with this pattern and see what it looks.

g.


> --
> Cheers,
> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.org=
.au
> http://www.canb.auug.org.au/~sfr/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
