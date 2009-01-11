From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sun, 11 Jan 2009 09:50:08 +0000
Subject: Re: cpumask change causes sparc build bustage
Message-Id: <20090111205008.db0a410e.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sun__11_Jan_2009_20_50_08_+1100_2NPpNzhxVnEL8+=4"
List-Id: <sparclinux.vger.kernel.org>
References: <20090111.003103.39502700.davem@davemloft.net>
In-Reply-To: <20090111.003103.39502700.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, travis@sgi.com, mingo@elte.hu

--Signature=_Sun__11_Jan_2009_20_50_08_+1100_2NPpNzhxVnEL8+=4
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 11 Jan 2009 00:31:03 -0800 (PST) David Miller <davem@davemloft.net>=
 wrote:
>
> I'm surprised linux-next builds didn't catch this.

So am I.  http://kisskb.ellerman.id.au/kisskb/compiler/5/ shows my latest
builds of both linux-next and Linus' tree are OK for defconfig and
allnoconfig (allmodconfig fails for a different reason).

What is different about the failing config (compiler)?  Are there other
configs it would be sensible to build test?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__11_Jan_2009_20_50_08_+1100_2NPpNzhxVnEL8+=4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAklpwNAACgkQjjKRsyhoI8zgzgCY+lB8esA4SSbL6SckrGEvfkTW
yACdEpS7aKGfKWNAlsYxj//iTN88Pnk=
=AUI2
-----END PGP SIGNATURE-----

--Signature=_Sun__11_Jan_2009_20_50_08_+1100_2NPpNzhxVnEL8+=4--
