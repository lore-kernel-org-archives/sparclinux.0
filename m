From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 05 Apr 2005 23:52:17 +0000
Subject: Re: [PATCH] Fix compat stat handling on sparc64
Message-Id: <20050406095217.5a728d04.sfr@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R"
List-Id: <sparclinux.vger.kernel.org>
References: <20050405135737.0a413358.davem@davemloft.net>
In-Reply-To: <20050405135737.0a413358.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 5 Apr 2005 13:57:37 -0700 "David S. Miller" <davem@davemloft.net> w=
rote:
>
> --- 1.19/include/asm-sparc64/compat.h	2005-02-17 21:53:03 -08:00
> +++ edited/include/asm-sparc64/compat.h	2005-04-05 12:37:58 -07:00
> @@ -51,11 +51,11 @@
>  	compat_dev_t	st_rdev;
>  	compat_off_t	st_size;
>  	compat_time_t	st_atime;
> -	u32		__unused1;
> +	u32		st_atime_nsec;

Surely you meant to put compat_ulong_t instead of u32 ... :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUyS14CJfqux9a+8RAseYAJ9qg9J1uQpXS88cgkmzrUJ+R9cNzgCfRqRq
p2gWqx2o27LDxzX32Pf9SnE=
=FEhu
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Apr_2005_09_52_17_+1000_+__DcEdER1fyw8/R--
