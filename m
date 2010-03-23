From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 23 Mar 2010 06:57:04 +0000
Subject: Re: [V2 PATCH 00/10] of: Consolidate scattered device node
Message-Id: <1269327424.5953.12.camel@concordia>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-V6FOmiM8suhP22YvlFQu"
List-Id: <sparclinux.vger.kernel.org>
References: <20100318144836.21082.93040.stgit@angua>
In-Reply-To: <20100318144836.21082.93040.stgit@angua>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net


--=-V6FOmiM8suhP22YvlFQu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-03-18 at 09:22 -0600, Grant Likely wrote:
> Currently, each of_device has a copy of the device tree node pointer in b=
oth
> .node, and in .dev.archdata.of_node (microblaze and powerpc) or
> .dev.archdata.prom_node (sparc).  Also, other architectures will be addin=
g
> CONFIG_OF support, and they will also need a reference to the device tree
> node pointer from struct device.

Assuming this is similar to your experimental-devicetree branch, as of
96b4b9d7 it causes a few build errors for me:

http://kisskb.ellerman.id.au/kisskb/head/2688/

Broken are 86xx/sbc8641d_defconfig, mpc83xx_defconfig,
mpc885_ads_defconfig, mpc85xx_defconfig, and pmac32_defconfig.

I haven't dug any further.

cheers

--=-V6FOmiM8suhP22YvlFQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuoZkAACgkQdSjSd0sB4dId9ACfazgsVaXLGyHjh3bmJTAlR+Tg
QcYAn3+H90fVn8gZ3rvwDh+quQWxPO13
=YLDW
-----END PGP SIGNATURE-----

--=-V6FOmiM8suhP22YvlFQu--

