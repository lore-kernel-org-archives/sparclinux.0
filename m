From: Dennis Gilmore <dennis@ausil.us>
Date: Thu, 25 Mar 2010 20:48:50 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <201003251548.57310.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2105392.nBsXhUgJZx"
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
To: sparclinux@vger.kernel.org

--nextPart2105392.nBsXhUgJZx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 25 March 2010 03:24:58 pm David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Wed, 24 Mar 2010 17:52:57 -0400
>=20
> > Attached is a patch which disables execmem for sparc. Without it,
> > selinux does not work at all on SPARC64.
> >=20
> > This patch should be reasonably non-controversial, because this is
> > already being done for PPC32.
> >=20
> > Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10, T5220)
> >=20
> >            Dennis Gilmore <dgilmore@redhat.com>
> >=20
> > Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>
>=20
> What is the reason why it doesn't work, I'm just curious?
>=20
> Is there some dependency upon executable stacks or executable data
> segments always working?  Why can't SELINUX protect be used with
> that correctly?

what happens is that almost all binaries end up with execmem set  and selin=
ux=20
prevents them from running.  the system fails to even get close to coming u=
p=20
in a usable state

Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.160:3): avc:  denied =
 {=20
execmem } for  pid=3D208 comm=3D"consoletype"=20
scontext=3Dsystem_u:system_r:consoletype_t:s0=20
tcontext=3Dsystem_u:system_r:consoletype_t:s0 tclass=3Dprocess
Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.315:4): avc:  denied =
 {=20
execmem } for  pid=3D211 comm=3D"hostname"=20
scontext=3Dsystem_u:system_r:hostname_t:s0=20
tcontext=3Dsystem_u:system_r:hostname_t:s0 tclass=3Dprocess
Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.520:5): avc:  denied =
 {=20
execmem } for  pid=3D213 comm=3D"mount" scontext=3Dsystem_u:system_r:mount_=
t:s0=20
tcontext=3Dsystem_u:system_r:mount_t:s0 tclass=3Dprocess
Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.570:6): avc:  denied =
 {=20
execmem } for  pid=3D203 comm=3D"readahead-colle"=20
scontext=3Dsystem_u:system_r:readahead_t:s0=20
tcontext=3Dsystem_u:system_r:readahead_t:s0 tclass=3Dprocess

is a small sample of the logs you get  not everything fails but almost=20
everything

>=20
> And since we're touching selinux code we need to at a minimum
> CC: them so they can have a look at your change.
>=20
> --------------------
> diff -up linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc
> linux-2.6.32.noarch/security/selinux/hooks.c ---
> linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc	2010-03-10
> 08:28:20.957571926 -0500 +++
> linux-2.6.32.noarch/security/selinux/hooks.c	2010-03-10 08:29:15.732698763
> -0500 @@ -3010,7 +3010,7 @@ static int file_map_prot_check(struct fi
>  	const struct cred *cred =3D current_cred();
>  	int rc =3D 0;
>=20
> -#ifndef CONFIG_PPC32
> +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
>  	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
>  		/*
>  		 * We are making executable an anonymous mapping or a
> @@ -3082,7 +3082,7 @@ static int selinux_file_mprotect(struct
>  	if (selinux_checkreqprot)
>  		prot =3D reqprot;
>=20
> -#ifndef CONFIG_PPC32
> +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
>  	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
>  		int rc =3D 0;
>  		if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--nextPart2105392.nBsXhUgJZx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkurzDkACgkQkSxm47BaWfeBOQCbBsMsC985RpHSXNMxgAETFq/S
BrQAnjdl5yF1V6YWRI8DqPrsCgsjOYAR
=6LxF
-----END PGP SIGNATURE-----

--nextPart2105392.nBsXhUgJZx--
