From: joshk@triplehelix.org (Joshua Kwan)
Date: Fri, 14 May 2004 20:08:31 +0000
Subject: Re: initrd testing
Message-Id: <20040514200831.GB29680@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uZ3hkaAS1mZxFaxD"
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
To: sparclinux@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 12:45:34PM -0400, Andy Dougherty wrote:
> I tried http://june.voxel.net/~joshk/d-i/images/2004-05-14/drom-mini.iso
> on two machines, an Ultra1 and an Ultra10; both failed, though
> differently.
>=20
> Ultra1:  On this one, I got (modulo any typos)
>=20
>     Loading initial ramdisk (1477684 bytes at 0x01x phys 022340800 virt) =
=2E..
>     [spinning \/]
>     Remapping the kernel ...  FP Disabled
>     ok

There's a chance that I could have botched the kernel, but I'm not sure
how...

>     RAMDISK: couldn't find valid ramdisk image starting at 0.
>     Freeing initrd memory 1443k freed
>     cramfs: wrong magic
>     sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
>     Kernel panic: VFS: Unable to mount root fs on 00:00

This is the error that everyone has been getting, frankly all it does is
confirm that an initrd does exist somewhere.

Thanks for trying it out. Ben, was that patch supposed to actually fix
something, or was it just supposed to be informative?

--=20
Joshua Kwan

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQKUnPqOILr94RG8mAQKDlRAA5x1mLiVUyjs8jY27I5Rx8KZVjdiyWIYL
B0L5paOFLoGSL4VEmTU5D387WeNsh8UUj3vw2qfzMowOZBbd9koXOtuMc6g24WNL
yAQZTbgdD5YRz/jgiFlBMT+UaPn0R28z2lAGX9re5LAS8zcaUdMX7ST+spEoQwUX
hEoMgg2vdqG3l7ypnUNpQ/LnIoHtuQD8ILK3X+Mm6zvkh3dYwT/8mWOKcs1Slqz4
u1kc7XN4+4oaPQ2X1C8FEeCc5a4b40Ar3rEgerOgTaQxQkFS5KUbsnzTPSEKJ62Z
hF9y6I+niC3lH8prcX3SjQ5alXn+4Gq8KjnxTLonKzd9H7uQkLewCuKgLdkEFmG9
HDjXE+vkX7KDwNvz8msWlUb+X7PQ/Hc3MmGY0P1JWf4+iJcY7e21EtfzDSgq/nHp
R1TVnFvYOD6xAwkHhBRbndIQ/nMvtmOs/qqV0Z4bpfDF95EN9+KclaCOf56+5Xoj
9ni0UA/flFwF+J/6B0cnpHze6XPQehNlJwzP24y7sE0b0NMWoF55w3o4SyGzn+81
Qxaq4excmKmJdJ6HCyp9dUy6DPAqgUKK5+e8lkTGE8bEEo91wU9F18maEGrlPvSG
wSXhzS3pADjjPVkwuMB5+cg1anDOaX8hKQTEettsbVD3oRi/X7vBrOss2aL7rdNk
Hk7ag+Bn5vU=
=0p4v
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
