From: Benjamin Schieder <blindcoder@scavenger.homeip.net>
Date: Wed, 25 May 2005 10:35:23 +0000
Subject: __you_cannot_kmalloc_that_much error
Message-Id: <20050525103523.GA20728@scavenger.homeip.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

I'm trying to create a sparc64 live system to boot from and have an install
server up and running.
I'm using the ROCK Linux toolkit for that.

Now, everything but silo works fine until the kernel (2.6.10) is built, whi=
ch
fails with:

  LD      arch/sparc/boot/image
drivers/built-in.o(.text+0x456c): In function `fbcon_startup':
synaptics.c: undefined reference to `__you_cannot_kmalloc_that_much'
make[1]: *** [arch/sparc/boot/image] Error 1
make: *** [image] Error 2

Now, all references to that error I've found aren't as recent as 2.6.10.
2.6.6 being the most recent one I've found.

I'm building on a SunBlade 150 using gcc 3.4.0.
I've put the build log and kernel configuration here:
http://scavenger.homeip.net/~blindcoder/ERROR-LOG
http://scavenger.homeip.net/~blindcoder/ERROR-LOG.gz
http://scavenger.homeip.net/~blindcoder/config

The patches mentioned in the ERROR-LOG are available here:
http://www.rocklinux.net/svn/rock-linux/trunk/package/base/linux/linux26/

Can someone tell me what I'm doing wrong here?


Thank you,
      Benjamin.

--=20
Benjamin 'blindCoder' Schieder
Registered Linux User #289529: http://counter.li.org
finger blindcoder@scavenger.homeip.net | gpg --import
--=20
/lusr/bin/brain: received signal: SIGIDIOT

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFClFTr7Wabow2Um2YRAloWAJ4weHSssDGwodNqq7JjXHZQYFsAdwCfbE/Q
xwGYEZcqXxbOXZFR2cJ/1IM=
=vABY
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
