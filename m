From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 25 Jul 2010 03:07:23 +0000
Subject: Re: [PATCH] of: Provide default of_node_to_nid() when CONFIG_NUMA
Message-Id: <20100725130723.a5192793.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sun__25_Jul_2010_13_07_23_+1000_RD.pz8Eexz.QQVh="
List-Id: <sparclinux.vger.kernel.org>
References: <20100724154331.22701.3409.stgit@angua>
In-Reply-To: <20100724154331.22701.3409.stgit@angua>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

--Signature=_Sun__25_Jul_2010_13_07_23_+1000_RD.pz8Eexz.QQVh=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Sat, 24 Jul 2010 09:43:31 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> of_node_to_nid() is only relevant for NUMA.  Don't force architectures to
> implement it if CONFIG_NUMA is not set.

Why not just do:

#ifndef of_node_to_nid
static inline int of_node_to_nid(struct device_node *device) { return 0; }
#define of_node_to_nid	of_node_to_nid
#endif

in include/linux/of.h

and then add:

#define of_node_to_nid	of_node_to_nid

Where it is declared/defined for each arch ...
(it would be nice if all the archs were consistent in where it was
declared).
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__25_Jul_2010_13_07_23_+1000_RD.pz8Eexz.QQVh=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMS6prAAoJEDMEi1NhKgbshFMH/i8Aj76EKx/9C5bPwVVHExHD
pYd2B3ivu0HASm+xvMsZE+8AAsRmRrfHczhyLgQDw0SbxsvWmZKAP6bJg8KscMSF
s73yV3tvEzCZpgTtCks/PxjVjkt/MHdSgyzaD+vcW62ZKyuNFXnGOEBbnC8d/v5G
G7aQ5gFrLMLUbdoGL+C1aSRr283ur2Wdukfe5ooVgoao3EayDvZOhlxr5aF2r4nq
WsZf5is1JQqwzcDiM2PykD8ReTtE+ZG/IUBzaOUi1OsxYhOMCEJsOm+egr93++lW
HKqd/qgvyKwL2tlTAnYttTsgtQCWtA2zX16ef/Ea9kLgVeOd935Plk2pcfG6XXA=
=FG69
-----END PGP SIGNATURE-----

--Signature=_Sun__25_Jul_2010_13_07_23_+1000_RD.pz8Eexz.QQVh=--
