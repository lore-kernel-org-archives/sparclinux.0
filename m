From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 26 Mar 2010 16:26:25 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <201003261126.34217.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1869215.iisYHG9UhN"
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
To: sparclinux@vger.kernel.org

--nextPart1869215.iisYHG9UhN
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 26 March 2010 10:33:50 am Stephen Smalley wrote:
> On Thu, 2010-03-25 at 15:48 -0500, Dennis Gilmore wrote:
> > On Thursday 25 March 2010 03:24:58 pm David Miller wrote:
> > > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > > Date: Wed, 24 Mar 2010 17:52:57 -0400
> > >=20
> > > > Attached is a patch which disables execmem for sparc. Without it,
> > > > selinux does not work at all on SPARC64.
> > > >=20
> > > > This patch should be reasonably non-controversial, because this is
> > > > already being done for PPC32.
> > > >=20
> > > > Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10,
> > > > T5220)
> > > >=20
> > > >            Dennis Gilmore <dgilmore@redhat.com>
> > > >=20
> > > > Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>
> > >=20
> > > What is the reason why it doesn't work, I'm just curious?
> > >=20
> > > Is there some dependency upon executable stacks or executable data
> > > segments always working?  Why can't SELINUX protect be used with
> > > that correctly?
> >=20
> > what happens is that almost all binaries end up with execmem set  and
> > selinux prevents them from running.  the system fails to even get close
> > to coming up in a usable state
> >=20
> > Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.160:3): avc:  den=
ied=20
> > { execmem } for  pid=3D208 comm=3D"consoletype"
> > scontext=3Dsystem_u:system_r:consoletype_t:s0
> > tcontext=3Dsystem_u:system_r:consoletype_t:s0 tclass=3Dprocess
> > Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.315:4): avc:  den=
ied=20
> > { execmem } for  pid=3D211 comm=3D"hostname"
> > scontext=3Dsystem_u:system_r:hostname_t:s0
> > tcontext=3Dsystem_u:system_r:hostname_t:s0 tclass=3Dprocess
> > Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.520:5): avc:  den=
ied=20
> > { execmem } for  pid=3D213 comm=3D"mount"
> > scontext=3Dsystem_u:system_r:mount_t:s0
> > tcontext=3Dsystem_u:system_r:mount_t:s0 tclass=3Dprocess
> > Dec 31 18:00:40 sparcbook kernel: type=3D1400 audit(8.570:6): avc:  den=
ied=20
> > { execmem } for  pid=3D203 comm=3D"readahead-colle"
> > scontext=3Dsystem_u:system_r:readahead_t:s0
> > tcontext=3Dsystem_u:system_r:readahead_t:s0 tclass=3Dprocess
> >=20
> > is a small sample of the logs you get  not everything fails but almost
> > everything
>=20
> I think we need to understand why this is happening - it usually
> reflects a toolchain problem (that was the case in the ppc32 situation,
> and was later fixed in Fedora through an updated toolchain and rebuilt
> userland).  eu-readelf -l /bin/hostname shows what?
eu-readelf -l /bin/hostname
Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz  MemSiz   Flg Align
  PHDR           0x000034 0x00010034 0x00010034 0x000100 0x000100 R E 0x4
  INTERP         0x000134 0x00010134 0x00010134 0x000013 0x000013 R   0x1
        [Requesting program interpreter: /lib/ld-linux.so.2]
  LOAD           0x000000 0x00010000 0x00010000 0x002204 0x002204 R E 0x100=
00
  LOAD           0x002204 0x00022204 0x00022204 0x000284 0x0002ac RWE 0x100=
00
  DYNAMIC        0x002218 0x00022218 0x00022218 0x0000d0 0x0000d0 RW  0x4
  NOTE           0x000148 0x00010148 0x00010148 0x000044 0x000044 R   0x4
  GNU_EH_FRAME   0x002110 0x00012110 0x00012110 0x00003c 0x00003c R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x000000 0x000000 RW  0x4

 Section to Segment mapping:
  Segment Sections...
   00    =20
   01      [RO: .interp]
   02      [RO: .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym=
=20
=2Edynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .text .fini=
=20
=2Erodata .eh_frame_hdr .eh_frame]
   03      .ctors .dtors .jcr .dynamic .got .plt .data .bss
   04      .dynamic
   05      [RO: .note.ABI-tag .note.gnu.build-id]
   06      [RO: .eh_frame_hdr]
   07    =20

>=20
> > > And since we're touching selinux code we need to at a minimum
> > > CC: them so they can have a look at your change.
> > >=20
> > > --------------------
> > > diff -up linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc
> > > linux-2.6.32.noarch/security/selinux/hooks.c ---
> > > linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc	2010-03-10
> > > 08:28:20.957571926 -0500 +++
> > > linux-2.6.32.noarch/security/selinux/hooks.c	2010-03-10
> > > 08:29:15.732698763 -0500 @@ -3010,7 +3010,7 @@ static int
> > > file_map_prot_check(struct fi
> > >=20
> > >  	const struct cred *cred =3D current_cred();
> > >  	int rc =3D 0;
> > >=20
> > > -#ifndef CONFIG_PPC32
> > > +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
> > >=20
> > >  	if ((prot & PROT_EXEC) && (!file || (!shared && (prot &
> > >  	PROT_WRITE)))) {
> > >  =09
> > >  		/*
> > >  	=09
> > >  		 * We are making executable an anonymous mapping or a
> > >=20
> > > @@ -3082,7 +3082,7 @@ static int selinux_file_mprotect(struct
> > >=20
> > >  	if (selinux_checkreqprot)
> > >  =09
> > >  		prot =3D reqprot;
> > >=20
> > > -#ifndef CONFIG_PPC32
> > > +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
> > >=20
> > >  	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> > >  =09
> > >  		int rc =3D 0;
> > >  		if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe sparclinux"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--nextPart1869215.iisYHG9UhN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkus4DoACgkQkSxm47BaWfekugCfWOZWIM1FTCSTNExmfsDJItD6
WSoAnApi3BsSlXC5U77fevI804H7azI6
=s2Sa
-----END PGP SIGNATURE-----

--nextPart1869215.iisYHG9UhN--
