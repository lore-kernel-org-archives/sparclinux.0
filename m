From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 19:43:52 +0000
Subject: Re: [PATCH] of/pdt: allow DT device matching by fixing 'name'
Message-Id: <20110223194352.GR14597@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110216222820.487AE9D401C@zog.reactivated.net>
 <1297896277.3011.5.camel@macbook.infradead.org>
 <AANLkTikAF2X1A5jfoNfCPRhZkZ7qPdZ57c8B5b9z4+qr@mail.gmail.com>
 <20110218190659.7f955e4c@queued.net>
In-Reply-To: <20110218190659.7f955e4c@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: Daniel Drake <dsd@laptop.org>, David Woodhouse <dwmw2@infradead.org>, cbou@mail.ru, linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Fri, Feb 18, 2011 at 07:06:59PM -0800, Andres Salomon wrote:
> On Fri, 18 Feb 2011 23:42:57 +0000
> Daniel Drake <dsd@laptop.org> wrote:
>=20
> > On 16 February 2011 22:44, David Woodhouse <dwmw2@infradead.org>
> > wrote:
> > > On Wed, 2011-02-16 at 22:28 +0000, Daniel Drake wrote:
> > >>
> > >> +static int __init add_common_platform_devices(void)
> > >> +{
> > >> + =A0 =A0 =A0 struct platform_device *pdev;
> > >> +
> > >> + =A0 =A0 =A0 pdev =3D platform_device_register_simple("olpc-battery=
", -1,
> > >> NULL, 0);
> > >> + =A0 =A0 =A0 if (IS_ERR(pdev))
> > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(pdev);
> > >> +
> > >> + =A0 =A0 =A0 return 0;
> > >> +}
> > >> +
> > >
> > > Still kind of sucks that you have to do this, and can't bind to
> > > something in the device-tree.
> >=20
> > OK, feel free to put this patch on hold for now. I started looking at
> > the device tree approach today. It looks doable but first we have to
> > fix a DT bug/inconsistency that is preventing us from correctly
> > binding to the tree's devices.
> >=20
> > Daniel
>=20
>=20
> Mea culpa.  The patch below fixes a bug I introduced earlier.
> Cc'ing the sparc folks, as this probably affects them
> (although I would think that it fixes broken behavior for them..?)

Wait; why are you binding to a device based on name?  Binding by name
and/or device_type is strongly discouraged for new code.  Use compatible
instead.

As for this patch, comments below...

> From: Andres Salomon <dilinger@queued.net>
>=20
> Commit e2f2a93b changed dp->name from using the 'name' property to
> using package-to-path.  This fixed /proc/device-tree creation by
> eliminating conflicts between names (the 'name' property provides
> names like 'battery', whereas package-to-path provides names like
> '/foo/bar/battery@0', which we stripped to 'battery@0').  However,
> it also breaks of_device_id table matching.
>=20
> The fix that we _really_ wanted was to keep dp->name based upon
> the name property ('battery'), but based dp->full_name upon
> package-to-path ('battery@0').  This patch does just that.
>=20
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> Reported-by: Daniel Drake <dsd@laptop.org>

From what I can tell, this only affects OLPC, correct?  It looks like
SPARC's implementation of of_pdt_node_name() will sidestep most of this
name retrieval code.

> ---
>  drivers/of/pdt.c |   42 +++++++++++++++++++-----------------------
>  1 files changed, 19 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index 28295d0..b39d584 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -48,7 +48,7 @@ static inline void irq_trans_init(struct device_node *d=
p) { }
> =20
>  static inline const char *of_pdt_node_name(struct device_node *dp)
>  {
> -	return dp->name;
> +	return NULL;
>  }

Rather than using this hook; perhaps the sparc .path_component_name
should be enabled for all architectures.  It is a useful data item to
keep a pointer to, and it would simplify the of_pdt code.

> =20
>  #endif /* !CONFIG_SPARC */
> @@ -156,23 +156,6 @@ static char * __init of_pdt_try_pkg2path(phandle nod=
e)
>  	return res+1;
>  }
> =20
> -/*
> - * When fetching the node's name, first try using package-to-path; if
> - * that fails (either because the arch hasn't supplied a PROM callback,
> - * or some other random failure), fall back to just looking at the node's
> - * 'name' property.
> - */
> -static char * __init of_pdt_build_name(phandle node)
> -{
> -	char *buf;
> -
> -	buf =3D of_pdt_try_pkg2path(node);
> -	if (!buf)
> -		buf =3D of_pdt_get_one_property(node, "name");
> -
> -	return buf;
> -}
> -
>  static struct device_node * __init of_pdt_create_node(phandle node,
>  						    struct device_node *parent)
>  {
> @@ -187,7 +170,7 @@ static struct device_node * __init of_pdt_create_node=
(phandle node,
> =20
>  	kref_init(&dp->kref);
> =20
> -	dp->name =3D of_pdt_build_name(node);
> +	dp->name =3D of_pdt_get_one_property(node, "name");
>  	dp->type =3D of_pdt_get_one_property(node, "device_type");
>  	dp->phandle =3D node;
> =20
> @@ -198,13 +181,26 @@ static struct device_node * __init of_pdt_create_no=
de(phandle node,
>  	return dp;
>  }
> =20
> -static char * __init of_pdt_build_full_name(struct device_node *dp)
> +static char * __init of_pdt_build_full_name(struct device_node *dp,
> +		phandle node)
>  {
>  	int len, ourlen, plen;
> +	const char *name;
>  	char *n;
> =20
> +	/*
> +	 * When fetching the full name, rather than what we see with the
> +	 * name property (ie, 'battery'), we want the name we see with
> +	 * package-to-path (ie, 'battery@0').
> +	 */
> +	name =3D of_pdt_node_name(dp);
> +	if (!name)
> +		name =3D of_pdt_try_pkg2path(node);
> +	if (!name)
> +		name =3D dp->name;
> +

Rather than this thrashing about looking for a way to get the path
component, it should be fairly certain how to obtain the node's name
before getting into of_pdt_build_full_name().  I'd follow SPARC's
lead and create an implementation of build_path_component();

However, considering that this is creating the full name; wouldn't the
raw output of pkg2path() provide exactly the full name string you need
here instead of breaking it down into components and adding it back up
again?

>  	plen =3D strlen(dp->parent->full_name);
> -	ourlen =3D strlen(of_pdt_node_name(dp));
> +	ourlen =3D strlen(name);
>  	len =3D ourlen + plen + 2;
> =20
>  	n =3D prom_early_alloc(len);
> @@ -213,7 +209,7 @@ static char * __init of_pdt_build_full_name(struct de=
vice_node *dp)
>  		strcpy(n + plen, "/");
>  		plen++;
>  	}
> -	strcpy(n + plen, of_pdt_node_name(dp));
> +	strcpy(n + plen, name);
> =20
>  	return n;
>  }
> @@ -243,7 +239,7 @@ static struct device_node * __init of_pdt_build_tree(=
struct device_node *parent,
>  #if defined(CONFIG_SPARC)
>  		dp->path_component_name =3D build_path_component(dp);
>  #endif
> -		dp->full_name =3D of_pdt_build_full_name(dp);
> +		dp->full_name =3D of_pdt_build_full_name(dp, node);
> =20
>  		dp->child =3D of_pdt_build_tree(dp,
>  				of_pdt_prom_ops->getchild(node), nextp);
> --=20
> 1.7.2.3
>=20
