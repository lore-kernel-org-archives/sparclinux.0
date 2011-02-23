From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 23 Feb 2011 19:45:10 +0000
Subject: Re: [PATCH] of/pdt: don't bother parsing pkg2path results, return
Message-Id: <20110223194510.GS14597@angua.secretlab.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20110216222820.487AE9D401C@zog.reactivated.net>
 <1297896277.3011.5.camel@macbook.infradead.org>
 <AANLkTikAF2X1A5jfoNfCPRhZkZ7qPdZ57c8B5b9z4+qr@mail.gmail.com>
 <20110218190659.7f955e4c@queued.net>
 <20110218191225.5e38b8bc@queued.net>
In-Reply-To: <20110218191225.5e38b8bc@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andres Salomon <dilinger@queued.net>
Cc: Daniel Drake <dsd@laptop.org>, David Woodhouse <dwmw2@infradead.org>, cbou@mail.ru, linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, Mitch Bradley <wmb@laptop.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On Fri, Feb 18, 2011 at 07:12:25PM -0800, Andres Salomon wrote:
> On Fri, 18 Feb 2011 19:06:59 -0800
> Andres Salomon <dilinger@queued.net> wrote:
>=20
> > On Fri, 18 Feb 2011 23:42:57 +0000
> > Daniel Drake <dsd@laptop.org> wrote:
> >=20
> > > On 16 February 2011 22:44, David Woodhouse <dwmw2@infradead.org>
> > > wrote:
> > > > On Wed, 2011-02-16 at 22:28 +0000, Daniel Drake wrote:
> > > >>
> > > >> +static int __init add_common_platform_devices(void)
> > > >> +{
> > > >> + =A0 =A0 =A0 struct platform_device *pdev;
> > > >> +
> > > >> + =A0 =A0 =A0 pdev =3D platform_device_register_simple("olpc-batte=
ry",
> > > >> -1, NULL, 0);
> > > >> + =A0 =A0 =A0 if (IS_ERR(pdev))
> > > >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(pdev);
> > > >> +
> > > >> + =A0 =A0 =A0 return 0;
> > > >> +}
> > > >> +
> > > >
> > > > Still kind of sucks that you have to do this, and can't bind to
> > > > something in the device-tree.
> > >=20
> > > OK, feel free to put this patch on hold for now. I started looking
> > > at the device tree approach today. It looks doable but first we
> > > have to fix a DT bug/inconsistency that is preventing us from
> > > correctly binding to the tree's devices.
> > >=20
> > > Daniel
> >=20
> >=20
> > Mea culpa.  The patch below fixes a bug I introduced earlier.
> > Cc'ing the sparc folks, as this probably affects them
> > (although I would think that it fixes broken behavior for them..?)
> >=20
> >=20
> >=20
>=20
> And this is a followup to the prior patch; an optimization based
> upon what we're doing with pkg2path stuff.
>=20
> The sparc folks don't use pkg2path, so this shouldn't affect them at
> all.
>=20
> Cc'ing Mitch as well, in case there's some reason why I should be
> wary of doing this.  :)
>=20
>=20
>=20
>=20
> From: Andres Salomon <dilinger@queued.net>
>=20
> The of_pdt_try_pkg2path() function currently allocates memory for
> and fetches the full path name from OFW (of the form '/foo/bar/baz@0').
> It then returns only the name ('baz@0)', and the caller re-constructs
> the full name (for dp->full_name) based upon dp->parent->full_name and
> what was returned by of_pdt_try_pkg2path().  Oh, and it allocates more
> memory for it.
>=20
> OLPC is the only architecture which fills in the pkg2path hook, so
> this shouldn't affect any other users (ie, sparc).  Since in practice
> (dp->parent->full_name + '/' + strrchr(pkg2path, '/')) and the result
> from pkg2path end up being exactly the same, just short circuit the rest
> of the of_pdt_build_full_name logic and set dp->full_name to the result
> of pkg2path.  This means we don't have to parse it nor allocate more
> memory for it.
>=20
> This saves time, code, and memory.
>=20
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  drivers/of/pdt.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index b39d584..605834b 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -134,7 +134,7 @@ static char * __init of_pdt_get_one_property(phandle =
node, const char *name)
> =20
>  static char * __init of_pdt_try_pkg2path(phandle node)
>  {
> -	char *res, *buf =3D NULL;
> +	char *buf =3D NULL;
>  	int len;
> =20
>  	if (!of_pdt_prom_ops->pkg2path)
> @@ -147,13 +147,7 @@ static char * __init of_pdt_try_pkg2path(phandle nod=
e)
>  		pr_err("%s: package-to-path failed\n", __func__);
>  		return NULL;
>  	}
> -
> -	res =3D strrchr(buf, '/');
> -	if (!res) {
> -		pr_err("%s: couldn't find / in %s\n", __func__, buf);
> -		return NULL;
> -	}
> -	return res+1;
> +	return buf;
>  }
> =20
>  static struct device_node * __init of_pdt_create_node(phandle node,
> @@ -193,10 +187,13 @@ static char * __init of_pdt_build_full_name(struct =
device_node *dp,
>  	 * name property (ie, 'battery'), we want the name we see with
>  	 * package-to-path (ie, 'battery@0').
>  	 */
> +	n =3D of_pdt_try_pkg2path(node);
> +	if (n)
> +		return n;
> +
> +	/* Older methods for determining full name */
>  	name =3D of_pdt_node_name(dp);
>  	if (!name)
> -		name =3D of_pdt_try_pkg2path(node);
> -	if (!name)

Ah, this addresses one of the comments I just made on the first patch.
I'd squash the two patches together before you repost.

g.

>  		name =3D dp->name;
> =20
>  	plen =3D strlen(dp->parent->full_name);
> --=20
> 1.7.2.3
>=20
