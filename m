From: Joshua Kwan <joshk@triplehelix.org>
Date: Sat, 05 Jun 2004 00:19:32 +0000
Subject: Take 3: sparc64 CDs work?
Message-Id: <20040605001932.GA22926@darjeeling.triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Folks,

Thanks to some surprising sleuth work by Boris Gontar we might have a
workaround for the dastardly initrd bug affecting certain sparc64
machines.

So, without further ado:

* http://june.voxel.net/~joshk/d-i/images/2004-06-04/cdrom-mini.iso (4.7M)
* http://gluck.debian.org/cdimage/testing/daily/sparc/current/ (whole
  shebang, if you're really confident)

I'm hoping one of these works. If neither do, make sure silo.conf
includes 'rootfstype=3Dext2'. I could have screwed up.

Hoping to end this bug!

--=20
Joshua Kwan

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQMERlKOILr94RG8mAQLBTw/+JRwL/ST9XgPY2oNJt1XHkWZJ4T++Vnh9
9MrOdd8f7XUXwoBYLi9PfQX60q2e+Wn9CpgbmVpPAMVYNjIm2j17c+zlBy1AGaZf
7pkJOFgl1rvJxT4GDuYnE2qGeAVwsH+OlZHs1nK2jdL4r/E8EcYAZMPJ47eCCQbO
DTsKsg2rEcG17HP2EN42MyEsNhulEmD/2v9I77BNB7BcA6UGsUKvW/yDjPfnYTw0
aJZNBOtJnKkSic4Julnt0/Y4NbeJVHxrKST09SbEHvZ76FpRgt1qLVjSJ5mQHQGT
+DrFtwje23JuM2ZpUL6xEqn3GcrlG520yenB5BPiwPzCten8HlI0kP5MdkWXc/SF
4R95Lx7yiAzrzrkyuAl/oosnDy0zicuDBROCUTK364FRCMJFvfxf0w6hqwkhVUZC
tllfzZWIvGM90q8s52cR/3KOa8mzk+yVGS2oZwRFLTIIwxwMxAUlR4yOUq1og9vT
XHLn/DzLlU/sWSEtE4mtFDtbSV2eQWT3VzZ67KqOEYMucGg26VWHs6OtUGHK2/Kb
b41t7E1EYhct/PBctjXBEOKXzeqxI8EDxPXDd9XfjPjx2UO1bY/YymJi4n/JUu3u
S7PLABZZbb/mx39b0M6xjiMT7NJ6P2+1+8c1SnqBUt4mvMKnnxwNKfoVlTN18Mk0
Q/kmKRb5ung=
=wzX4
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
