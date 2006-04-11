From: Jason Wever <weeve@gentoo.org>
Date: Tue, 11 Apr 2006 02:31:38 +0000
Subject: Re: Issues with SILO 1.4.11
Message-Id: <20060410203138.6a4a5816@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_2FOI8C/8EZk2zXJws6iCXag"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.63.0604101839350.3168@bobcat>
In-Reply-To: <Pine.LNX.4.63.0604101839350.3168@bobcat>
To: sparclinux@vger.kernel.org

--Sig_2FOI8C/8EZk2zXJws6iCXag
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2006 18:53:44 -0700 (PDT)
Jurij Smakov <jurij@wooyd.org> wrote:

> Another piece of information regarding new SILO, is that it still
> fails to boot SunFire V880 from CD. Stephen Frost was kind enough to
> test it on his machine, and sent me the following transcript:
>=20
>    Rebooting with command: boot cdrom
>    Boot device: /pci@8,700000/scsi@1/disk@6,0:f  File and args:
>    SILO Version 1.4.11
>    Fast Data Access MMU Miss
>    {2} ok

=46rom what we've seen in the Gentoo world, this seems to be true on most
if not all UltraSPARC III or IIIi boxes currently.  Systems
reported to have the problem include Blade 1000s, 2000s, 2500s and
Netra 240s.

I can readily reproduce here on a Blade 1000 with OBP version 4.16.4.
However, it might be hard for me to debug as at least on a graphical
console, it does not dump me back to OBP when it does this.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_2FOI8C/8EZk2zXJws6iCXag
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEOxUMdKvgdVioq28RAieEAJ0dtMvVHcjSHQ366oyHrK2Yf8wGzACdExXk
NALIT0aW7BdRvyzg7gSnRFI=
=MgIJ
-----END PGP SIGNATURE-----

--Sig_2FOI8C/8EZk2zXJws6iCXag--
