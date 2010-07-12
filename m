From: Andres Salomon <dilinger@queued.net>
Date: Mon, 12 Jul 2010 16:28:48 +0000
Subject: Re: [PATCH] sparc: move is_root_node from private header to of.h
Message-Id: <20100713200541.0dc8d0be@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100713094226.33b421dd@debxo>
	<AANLkTinVpBjQQa93DZ17ULQdspDByGV8h037bVJ2qxGC@mail.gmail.com>
In-Reply-To: <AANLkTinVpBjQQa93DZ17ULQdspDByGV8h037bVJ2qxGC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net

On Mon, 12 Jul 2010 09:53:04 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Jul 13, 2010 at 3:42 AM, Andres Salomon <dilinger@queued.net>
> wrote:
> >
> > Make is_root_node available for all archs to use, as it's not
> > PROM-specific. Also rename it to of_is_root_node, and a few other
> > minor changes for style/consistency.
> >
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > ---
> > =A0arch/sparc/kernel/prom.h =A0 =A0 =A0 =A0| =A0 =A08 --------
> > =A0arch/sparc/kernel/prom_64.c =A0 =A0 | =A0 =A06 +++---
> > =A0arch/sparc/kernel/prom_common.c | =A0 =A02 +-
> > =A0include/linux/of.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++++++++
> > =A04 files changed, 12 insertions(+), 12 deletions(-)
> [...]
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index a367e19..b38cdf7 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -97,6 +97,14 @@ extern struct device_node *of_node_get(struct
> > device_node *node); extern void of_node_put(struct device_node
> > *node); #endif
> >
> > +static inline bool of_is_root_node(const struct device_node *node)
> > +{
> > + =A0 =A0 =A0 if (!node)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> > +
> > + =A0 =A0 =A0 return (node->parent =3D NULL);
> > +}
>=20
> Are you okay if I shorten this to?
>=20
> +static inline bool of_is_root_node(const struct device_node *node)
> +{
> +       return (node && (node->parent =3D NULL));
> +}
>=20
> g.

It's fine with me.

