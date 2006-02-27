From: Jason Wever <weeve@gentoo.org>
Date: Mon, 27 Feb 2006 01:06:57 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060226180657.2c9b177a@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_EKp4EbGHqQ3DEmpqXu0N80R"
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Sig_EKp4EbGHqQ3DEmpqXu0N80R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Feb 2006 16:50:20 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> So what _exact_ GIT tree did you first test Christophe's ESP spinlock
> fix with, the one you refer to as "the same tree on the Ultra 1 as the
> original bug was posted against"?  Please always list such details and
> do not refer to specific kernel trees in such a vague manner.

Sorry about that.

The tree (non-git) that I originally ran into this with and tested
Christoph's patch against was 2.6.16-rc4 as a regular joe user
would download it from kernel.org (grab linux-2.6.15.tar.bz2
tarball and patch-2.6.16-rc4.bz2, unpack, apply 2.6.16-rc4 patch,
apply Christoph's patch).

When I did the "git bisect" method this time, I cloned the latest tree
(2.6.16-rc4-git7 I believe) so as to already have Christoph's patch
applied (and not taint the cloned tree with local modifications).
=20
> If have to admit that I do all of my kernel work with gcc-4.0.x these
> days as that has become the default compiler on all the Debian derive
> dists.

I'll try to setup a chroot for gcc-4.0.x to test this out and see if it
behaves any differently.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_EKp4EbGHqQ3DEmpqXu0N80R
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEAlCxdKvgdVioq28RAvsUAKCSHq1Cyyo7urS0oTTBbT0X7Y02KQCgpfTQ
lJyYm9j6Z7MyIe+HW0kPVb0=
=dKVM
-----END PGP SIGNATURE-----

--Sig_EKp4EbGHqQ3DEmpqXu0N80R--
