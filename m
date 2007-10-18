From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 18 Oct 2007 05:22:54 +0000
Subject: Re: [PATCH 2/2] Use of_get_pci_dev_node() in axon_msi.c
Message-Id: <20071018152254.344bfe48.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__18_Oct_2007_15_22_54_+1000_LpXn9=JJX3LiGuRW"
List-Id: <sparclinux.vger.kernel.org>
References: <8f76815cbbaf5fbab82c843d87bc0dafab038c80.1192605144.git.michael@ellerman.id.au>
	<dadd2b9540369b9e2c6773b2a60021dadafa58e2.1192605144.git.michael@ellerman.id.au>
	<20071017230449.GZ4891@austin.ibm.com>
In-Reply-To: <20071017230449.GZ4891@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@ozlabs.org

--Signature=_Thu__18_Oct_2007_15_22_54_+1000_LpXn9=JJX3LiGuRW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Oct 2007 18:04:49 -0500 linas@austin.ibm.com (Linas Vepstas) wro=
te:
>
> Is this really useful or wise?

Yes, it is.  We are *replacing* an interface that does no ref counting
with one that does.

> As a matter of personal taste, I find stuff like this clutters

What has taste got to do with it?  And as for cluttering, you can page
out the previous interface and page in the new one.  :-)

> I don't much like this style, and I've been known to submit
> patches that remove stuff like this ...=20

What "style" are you referring to?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__18_Oct_2007_15_22_54_+1000_LpXn9=JJX3LiGuRW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHFu2yTgG2atn1QN8RAobAAJ9y1fEys133mMArkDzKVza2ncs8igCgh5Q0
mCRMxi92t3zxGqlIUSUET90=
=5q8T
-----END PGP SIGNATURE-----

--Signature=_Thu__18_Oct_2007_15_22_54_+1000_LpXn9=JJX3LiGuRW--
