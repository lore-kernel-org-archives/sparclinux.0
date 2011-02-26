From: Dennis Gilmore <dennis@ausil.us>
Date: Sat, 26 Feb 2011 00:06:00 +0000
Subject: Re: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <201102251806.09729.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart27074517.dZmZATiUVL"
List-Id: <sparclinux.vger.kernel.org>
References: <1298678235-29164-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1298678235-29164-1-git-send-email-dennis@ausil.us>
To: sparclinux@vger.kernel.org

--nextPart27074517.dZmZATiUVL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

This is due to gcc-4.6 it throws warnings for defined but unused variables.=
=20
without this we cant build the kernel at all.  i have buil tested but not=20
tried to run yet

Dennis

On Friday, February 25, 2011 05:57:15 PM Dennis Gilmore wrote:
> Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
> ---
>  arch/sparc/kernel/Makefile |    1 -
>  arch/sparc/lib/Makefile    |    1 -
>  arch/sparc/mm/Makefile     |    1 -
>  arch/sparc/prom/Makefile   |    1 -
>  4 files changed, 0 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index 599398f..e38a367 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -3,7 +3,6 @@
>  #
>=20
>  asflags-y :=3D -ansi
> -ccflags-y :=3D -Werror
>=20
>  extra-y     :=3D head_$(BITS).o
>  extra-y     +=3D init_task.o
> diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
> index 846d1c4..c2ed034 100644
> --- a/arch/sparc/lib/Makefile
> +++ b/arch/sparc/lib/Makefile
> @@ -2,7 +2,6 @@
>  #
>=20
>  asflags-y :=3D -ansi -DST_DIV0=3D0x02
> -ccflags-y :=3D -Werror
>=20
>  lib-$(CONFIG_SPARC32) +=3D mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrd=
i3.o
>  lib-$(CONFIG_SPARC32) +=3D memcpy.o memset.o
> diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
> index 79836a7..3945501 100644
> --- a/arch/sparc/mm/Makefile
> +++ b/arch/sparc/mm/Makefile
> @@ -2,7 +2,6 @@
>  #
>=20
>  asflags-y :=3D -ansi
> -ccflags-y :=3D -Werror
>=20
>  obj-$(CONFIG_SPARC64)   +=3D ultra.o tlb.o tsb.o
>  obj-y                   +=3D fault_$(BITS).o
> diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
> index 8287bbe..52e4e77 100644
> --- a/arch/sparc/prom/Makefile
> +++ b/arch/sparc/prom/Makefile
> @@ -2,7 +2,6 @@
>  # Linux.
>  #
>  asflags :=3D -ansi
> -ccflags :=3D -Werror
>=20
>  lib-y                 :=3D bootstr_$(BITS).o
>  lib-y                 +=3D init_$(BITS).o

--nextPart27074517.dZmZATiUVL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEABECAAYFAk1oQ/EACgkQkSxm47BaWffwJgCfYQb0P/0rNWBK5CBI69cvNby3
nR8An3wCTt15hLUGu7nh8iG7kJorpeC+
=H3gQ
-----END PGP SIGNATURE-----

--nextPart27074517.dZmZATiUVL--
