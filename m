From: joshk@triplehelix.org (Joshua Kwan)
Date: Fri, 14 May 2004 05:48:58 +0000
Subject: Re: initrd testing
Message-Id: <20040514054858.GA29680@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
To: sparclinux@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ Sorry for the huge crosspost, but this is a pretty big deal. ]

On Thu, May 13, 2004 at 04:21:46PM -0400, Ben Collins wrote:
> Some people have reported problems with initrd on sparc64. I'm trying to
> trace that problem (hard, because I can't reproduce it). If you've had
> the problem where silo reports loading the initrd into memory, but the
> kernel fails to detect and use it, please try the second.b in the url
> below, and recompile a kernel using one of the two patches there aswell
> (2.4 and 2.6).
>=20
> The new second.b will show the phys address that the initrd was loaded
> to, in addition to the virtual address.

I've built debian-installer images for sparc based on kernels with this
patch (for 2.4) and the new second.b.

You probably want the CDROM image since it's the one most commonly
reported as not being able to boot. (cdrom-mini.iso) I am personally not
able to try these out until I receive a sparc64 machine, which should
happen sometime in the near future.

http://june.voxel.net/~joshk/d-i/images/2004-05-14/

I hope that this resolves the issues with SILO and initrd!

--=20
Joshua Kwan

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQKRdyaOILr94RG8mAQIIHxAA3d7hKZp5ReSKoSDy1UMZcRMVb/dKhHak
nIyXyz1rlGzHiy9DUk2JzS97/tm94ujJ33tP2O0DTIbIOX4VsUVGwwHCLL1HEkIf
u0YZYaZ7GTyuO78LW7yrxeKBnN/45Y2B00W70kp/C8B0HLUnE7K04A3diRDyj7JH
oRu7kwqicwxntpTERFrccr3qGP1k/drbGoc/KhDJeXll6baY/b16kSi/VodFCWlU
6hgr92JhjhZaTmciloJsSRrRSWAi3I9l0vv+MZ2QHU6b8SmCBI9oacI2J3ukJsEB
f4J5TFVB8U1KsQPP/msPnxDt7tDrWMPu/97fgFiSHqs5xHY+ue41Vm7Gzz/gwzES
X6wAdudehBSglVln+ocxwWDaafyluTuaceluABRC8MXwSLoxFQ2N4np81KuaWZTx
oHfg+w3CSQFL8fIG/XimBO12fSM3xRzWkqeu7WbJ1QVLFtlZ0YuzpkKcxvzmX/GK
c0VCLyAhYKJa1FkKJ27dcY+zuNe9nQyfEdXlTEFmc6Egu0FqDDX1hAKihlxx4SVm
mq2vZwEzhA0FoGrrhuR+ySX2zXzqDjtutIQM/i/p5B5pxGDDl7seOkv+x8gO9JXG
sHfxHSG6SXkoeee8vG6gfwXjoQVJ/oVJacResuvzC6aSVzIDFKvDod+KXfC4Ju2M
KdNNFdAN4bI=
=2GCh
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
