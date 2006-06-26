From: Will Simoneau <simoneau@ele.uri.edu>
Date: Mon, 26 Jun 2006 19:46:11 +0000
Subject: Re: 2.6.17 + sym53c876 causes many i/o errors
Message-Id: <20060626194611.GA16752@ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
List-Id: <sparclinux.vger.kernel.org>
References: <20060620175656.GA12525@ele.uri.edu>
In-Reply-To: <20060620175656.GA12525@ele.uri.edu>
To: sparclinux@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13:56 Tue 20 Jun     , Will Simoneau wrote:
> I just tried out 2.6.17 on my U80 (4x450, 2560MB), which boots off the
> onboard SCSI card (Symbios 53c876) from a sw raid1 of 2 disks. The disks
> are original Sun UW-SCSI Seagate 18G 10k disks, internal cabling is all
> original. Filesystem is ext3 with dir_index on. Distro is Gentoo,
> running ~sparc.
>=20
> Result: many I/O errors, leading to some filesystem corruption! I was
> lucky to notice and quickly go back to 2.6.15 and run a full fsck, which
> found some problems. One of the disks was marked failed by the raid1
> driver, since it was returning lots of errors... it looks like the raid1
> driver didn't give up as easily on the last disk, allowing the machine
> to still function.
>=20
> The old kernel is 2.6.15-gentoo-r7 installed via portage. Toolchain and
> utility versions from ver_linux:
[long stuff snipped]
>=20
> This is obviously a really dangerous bug, whatever it is, as it will
> easily cause corruption on the root filesystem before booting is finished=
=2E Both SCSI channels on the dual channel card return errors easily. This =
wasn't a
> problem on 2.6.15.
>=20
> Full kernel log from 2.6.17 boot to shutdown, and .config are attached.
> This kernel is gentoo-sources-2.6.17 from portage, let me know if you
> need a list of patches that are included.
>=20
> BTW, I can't fiddle much with this machine besides testing a couple
> patches. Doing a bisect to find the bad patch is out of the question.
>=20
> What gives?
[long stuff snipped]

Just an update: 2.6.17.1 had the same problem until I changed both the
max # and default # of tagged queue commands to 64 instead of 256 like I
had them. The doc file for the driver seems to indicate that at most 255
tagged queue commands are supported, but the help text in 'make
menuconfig' indicates that up to 256 are supported. Maybe setting it to
256 causes badness in the driver?

Anyway, 2.6.17.1 is fine on this machine now.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEoDmDLYBaX8VDLLURAodKAJ0fxSsYxttBFGnNwb3NpdTqWXqQcwCdH5B7
Ezxg+luGRZixhtCVf/IckMg=
=KCTB
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
