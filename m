From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Oct 2009 01:00:07 +0000
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-Id: <20091015120007.3780c59b.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7"
List-Id: <sparclinux.vger.kernel.org>
References: <20091007041007.16890.62194.stgit@angua>
In-Reply-To: <20091007041007.16890.62194.stgit@angua>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On Tue, 06 Oct 2009 22:29:57 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> Well, I've got to start somewhere...
>=20
> So here goes.  I've begun the work to merge and clean up the OF device
> tree handling code and this is my first set of patches.  Not fully
> tested yet, but I'm getting them out to the lists so that I can start
> responding to comments and collecting acks.  This first batch isn't
> anything exciting, just a merge of common code

This all looks OK to me.  One thing:  I started in this as well some time
ago and in my attempt I was hoping to avoid the ARCH ifdefs in linux/of.h
by creating asm/of.h and moving the differing bits in there ...

I'll send out the two patches I did just to show what I mean (these are
from before microblaze was using the OF stuff).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrWdBcACgkQjjKRsyhoI8w26gCgrC6aXsKjJZJN+rq7j8hhiiDb
ZK0AnRqc0bw0h1mbhMJ1vnCTuvoej99J
=ZMeC
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Oct_2009_12_00_07_+1100_F.cmwanLGW4bt_y7--
