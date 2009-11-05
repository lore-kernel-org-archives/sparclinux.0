From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 05 Nov 2009 08:59:59 +0000
Subject: Re: [PATCH 07/11] of/flattree: Merge unflatten_dt_node
Message-Id: <20091105085959.GD3478@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DrWhICOqskFTAXiy"
List-Id: <sparclinux.vger.kernel.org>
References: <20091105073728.10460.6061.stgit@angua>
	<20091105074631.10460.97676.stgit@angua>
In-Reply-To: <20091105074631.10460.97676.stgit@angua>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2009 at 12:46:38AM -0700, Grant Likely wrote:
> Merge common code between PowerPC and MicroBlaze
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

[...]

> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 01a7f5f..df1ac8d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -167,3 +167,203 @@ int __init of_flat_dt_is_compatible(unsigned long n=
ode, const char *compat)
>  	return 0;
>  }
> =20
> +static void *__init unflatten_dt_alloc(unsigned long *mem, unsigned long=
 size,
> +				       unsigned long align)
> +{
> +	void *res;
> +
> +	*mem =3D _ALIGN(*mem, align);
> +	res =3D (void *)*mem;
> +	*mem +=3D size;
> +
> +	return res;
> +}
> +
> +/**
> + * unflatten_dt_node - Alloc and populate a device_node from the flat tr=
ee
> + * @p: pointer to node in flat tree
> + * @dad: Parent struct device_node
> + * @allnextpp: pointer to ->allnext from last allocated device_node
> + * @fpsize: Size of the node path up at the current depth.
> + */
> +unsigned long __init unflatten_dt_node(unsigned long mem,
> +					unsigned long *p,
> +					struct device_node *dad,
> +					struct device_node ***allnextpp,
> +					unsigned long fpsize)
> +{
> +	struct device_node *np;
> +	struct property *pp, **prev_pp =3D NULL;
> +	char *pathp;
> +	u32 tag;
> +	unsigned int l, allocl;
> +	int has_name =3D 0;
> +	int new_format =3D 0;
> +
> +	tag =3D *((u32 *)(*p));
> +	if (tag !=3D OF_DT_BEGIN_NODE) {
> +		printk("Weird tag at start of node: %x\n", tag);

Loglevel missing -> pr_info?

> +		return mem;
> +	}
> +	*p +=3D 4;
> +	pathp =3D (char *)*p;
> +	l =3D allocl =3D strlen(pathp) + 1;
> +	*p =3D _ALIGN(*p + l, 4);
> +
> +	/* version 0x10 has a more compact unit name here instead of the full
> +	 * path. we accumulate the full path size using "fpsize", we'll rebuild
> +	 * it later. We detect this because the first character of the name is
> +	 * not '/'.
> +	 */
> +	if ((*pathp) !=3D '/') {
> +		new_format =3D 1;
> +		if (fpsize =3D=3D 0) {
> +			/* root node: special case. fpsize accounts for path
> +			 * plus terminating zero. root node only has '/', so
> +			 * fpsize should be 2, but we want to avoid the first
> +			 * level nodes to have two '/' so we use fpsize 1 here
> +			 */
> +			fpsize =3D 1;
> +			allocl =3D 2;
> +		} else {
> +			/* account for '/' and path size minus terminal 0
> +			 * already in 'l'
> +			 */
> +			fpsize +=3D l;
> +			allocl =3D fpsize;
> +		}
> +	}
> +
> +	np =3D unflatten_dt_alloc(&mem, sizeof(struct device_node) + allocl,
> +				__alignof__(struct device_node));
> +	if (allnextpp) {
> +		memset(np, 0, sizeof(*np));
> +		np->full_name =3D ((char *)np) + sizeof(struct device_node);
> +		if (new_format) {
> +			char *fn =3D np->full_name;
> +			/* rebuild full path for new format */
> +			if (dad && dad->parent) {
> +				strcpy(fn, dad->full_name);
> +#ifdef DEBUG
> +				if ((strlen(fn) + l + 1) !=3D allocl) {
> +					pr_debug("%s: p: %d, l: %d, a: %d\n",
> +						pathp, (int)strlen(fn),
> +						l, allocl);
> +				}
> +#endif
> +				fn +=3D strlen(fn);
> +			}
> +			*(fn++) =3D '/';
> +			memcpy(fn, pathp, l);
> +		} else
> +			memcpy(np->full_name, pathp, l);
> +		prev_pp =3D &np->properties;
> +		**allnextpp =3D np;
> +		*allnextpp =3D &np->allnext;
> +		if (dad !=3D NULL) {
> +			np->parent =3D dad;
> +			/* we temporarily use the next field as `last_child'*/
> +			if (dad->next =3D=3D NULL)
> +				dad->child =3D np;
> +			else
> +				dad->next->sibling =3D np;
> +			dad->next =3D np;
> +		}
> +		kref_init(&np->kref);
> +	}
> +	while (1) {
> +		u32 sz, noff;
> +		char *pname;
> +
> +		tag =3D *((u32 *)(*p));
> +		if (tag =3D=3D OF_DT_NOP) {
> +			*p +=3D 4;
> +			continue;
> +		}
> +		if (tag !=3D OF_DT_PROP)
> +			break;
> +		*p +=3D 4;
> +		sz =3D *((u32 *)(*p));
> +		noff =3D *((u32 *)((*p) + 4));
> +		*p +=3D 8;
> +		if (initial_boot_params->version < 0x10)
> +			*p =3D _ALIGN(*p, sz >=3D 8 ? 8 : 4);
> +
> +		pname =3D find_flat_dt_string(noff);
> +		if (pname =3D=3D NULL) {
> +			pr_info("Can't find property name in list !\n");
> +			break;
> +		}
> +		if (strcmp(pname, "name") =3D=3D 0)
> +			has_name =3D 1;
> +		l =3D strlen(pname) + 1;
> +		pp =3D unflatten_dt_alloc(&mem, sizeof(struct property),
> +					__alignof__(struct property));
> +		if (allnextpp) {
> +			if (strcmp(pname, "linux,phandle") =3D=3D 0) {
> +				np->node =3D *((u32 *)*p);
> +				if (np->linux_phandle =3D=3D 0)
> +					np->linux_phandle =3D np->node;
> +			}
> +			if (strcmp(pname, "ibm,phandle") =3D=3D 0)
> +				np->linux_phandle =3D *((u32 *)*p);
> +			pp->name =3D pname;
> +			pp->length =3D sz;
> +			pp->value =3D (void *)*p;
> +			*prev_pp =3D pp;
> +			prev_pp =3D &pp->next;
> +		}
> +		*p =3D _ALIGN((*p) + sz, 4);
> +	}
> +	/* with version 0x10 we may not have the name property, recreate
> +	 * it here from the unit name if absent
> +	 */
> +	if (!has_name) {
> +		char *p1 =3D pathp, *ps =3D pathp, *pa =3D NULL;
> +		int sz;
> +
> +		while (*p1) {
> +			if ((*p1) =3D=3D '@')
> +				pa =3D p1;
> +			if ((*p1) =3D=3D '/')
> +				ps =3D p1 + 1;
> +			p1++;
> +		}
> +		if (pa < ps)
> +			pa =3D p1;
> +		sz =3D (pa - ps) + 1;
> +		pp =3D unflatten_dt_alloc(&mem, sizeof(struct property) + sz,
> +					__alignof__(struct property));
> +		if (allnextpp) {
> +			pp->name =3D "name";
> +			pp->length =3D sz;
> +			pp->value =3D pp + 1;
> +			*prev_pp =3D pp;
> +			prev_pp =3D &pp->next;
> +			memcpy(pp->value, ps, sz - 1);
> +			((char *)pp->value)[sz - 1] =3D 0;
> +			pr_debug("fixed up name for %s -> %s\n", pathp,
> +				(char *)pp->value);
> +		}
> +	}
> +	if (allnextpp) {
> +		*prev_pp =3D NULL;
> +		np->name =3D of_get_property(np, "name", NULL);
> +		np->type =3D of_get_property(np, "device_type", NULL);
> +
> +		if (!np->name)
> +			np->name =3D "<NULL>";
> +		if (!np->type)
> +			np->type =3D "<NULL>";
> +	}
> +	while (tag =3D=3D OF_DT_BEGIN_NODE) {
> +		mem =3D unflatten_dt_node(mem, p, np, allnextpp, fpsize);
> +		tag =3D *((u32 *)(*p));
> +	}
> +	if (tag !=3D OF_DT_END_NODE) {
> +		printk("Weird tag at end of node: %x\n", tag);

Ditto (microblaze had KERN_INFO, too).

> +		return mem;
> +	}
> +	*p +=3D 4;
> +	return mem;
> +}
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index 81231e0..ace9068 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -69,6 +69,10 @@ extern void *of_get_flat_dt_prop(unsigned long node, c=
onst char *name,
>  				 unsigned long *size);
>  extern int of_flat_dt_is_compatible(unsigned long node, const char *name=
);
>  extern unsigned long of_get_flat_dt_root(void);
> +extern unsigned long unflatten_dt_node(unsigned long mem, unsigned long =
*p,
> +					struct device_node *dad,
> +					struct device_node ***allnextpp,
> +					unsigned long fpsize);
> =20
>  /* Other Prototypes */
>  extern void finish_device_tree(void);
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrylA8ACgkQD27XaX1/VRv6NQCdFTNUEkS9hThW1nmY8hZlZUNV
3LwAoKH57I9nE5a7XpiTKyhVWDQZrLNg
=OD03
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
