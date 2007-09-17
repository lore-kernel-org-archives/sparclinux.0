From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 17 Sep 2007 06:39:54 +0000
Subject: Re: [PATCH 09/10] ppc64: Convert cpu_sibling_map to a per_cpu data
Message-Id: <20070917163954.1c3b91fd.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__17_Sep_2007_16_39_54_+1000_8XGFp5gdvQyJPmgh"
List-Id: <sparclinux.vger.kernel.org>
References: <20070912015644.927677070@sgi.com>
	<20070912015647.486500682@sgi.com>
	<20070917162831.b2a9d675.sfr@canb.auug.org.au>
In-Reply-To: <20070917162831.b2a9d675.sfr@canb.auug.org.au>
To: travis@sgi.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org

--Signature=_Mon__17_Sep_2007_16_39_54_+1000_8XGFp5gdvQyJPmgh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Sep 2007 16:28:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> 	the topology (on my POWERPC5+ box) is not correct:
>=20
> cpu0/topology/thread_siblings:0000000f
> cpu1/topology/thread_siblings:0000000f
> cpu2/topology/thread_siblings:0000000f
> cpu3/topology/thread_siblings:0000000f
>=20
> it used to be:
>=20
> cpu0/topology/thread_siblings:00000003
> cpu1/topology/thread_siblings:00000003
> cpu2/topology/thread_siblings:0000000c
> cpu3/topology/thread_siblings:0000000c

This would be because we are setting up the cpu_sibling map before we
call setup_per_cpu_areas().

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__17_Sep_2007_16_39_54_+1000_8XGFp5gdvQyJPmgh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7iFATgG2atn1QN8RAnoiAJ4p0Hk26M2K13DgUt0wVOd2o5fJAACfQD5+
XWiCERDNRgIjs6BvH/3Ffcs=
=wQi8
-----END PGP SIGNATURE-----

--Signature=_Mon__17_Sep_2007_16_39_54_+1000_8XGFp5gdvQyJPmgh--
