From: joshk@triplehelix.org (Joshua Kwan)
Date: Tue, 18 May 2004 00:47:46 +0000
Subject: Re: initrd testing
Message-Id: <20040518004746.GM29680@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7vAdt9JsdkkzRPKN"
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
To: sparclinux@vger.kernel.org


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2004 at 10:40:11AM -0400, Ben Collins wrote:
> > >>RAMDISK: Couldn't find valid RAM disk image starting at 0.
> > >>Freeing initrd memory: 1442 freed
> > >>cramfs: wrong magic
>=20
> Wait a second. Is this ramdisk really cramfs, or is it romfs?

Neither. It's gzipped ext2.

--=20
Joshua Kwan

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQKldMaOILr94RG8mAQIl+hAAh/yUxFCDVMZxDBCRCqOshM8Un8qO9OMk
mi8/R+J9pkd17KHlk2rCUAoCCEKqrigwE+Q/FN8Dr+MPPAk5COwm+YYP1iaCREnq
JQgZ9ozLbUTeeuKKhItjxHbXuN+gjOK0tqqCbCujuw6aWUXd7O4h6AkFrcukBqc2
fZuZP4iaLm7hZM927ZRBFOvEUiMzHZ6bLKFNssy0kBTBcOXwpKoQG5yhbDBJQOhi
a1dYYDvBS+1Wewq9H1yLasE1eKNO+Hh7DcY7yb7jXv7phUdUcWUbAcsPJJDNUxat
iSS4OtnzDaF1Nx+UZntydsm5icIWU1v5gr4AW1o40Be4lhjid20yAr0mdMeszwQN
oerpE+pQeI781Y48f2jwIXd9i7U0/AH7LenNtiBQ4zKos3bz4cfxa/sW5TYOyTdd
aUIsIrrRI/BReQ5nuY0QUwBod3xUoyZ/yU0tMFx1Ptuk2j0quK/X+ByDYpPsPHta
VN8XTAfWnNf7XCmt7UL+pzKfq4KeLwabjyCwNyXR8WIFhP3knruo2TKfKODJGLGc
XJ7glVDNScBjyJ+zEBhHs7YKwxtyX/k/GYutzHWJWlHawHHvjj9oN+Y8Fai/FtzS
3u600tampw2ulW72C4Lhpwv+EWPUXm0bCt2QQPTKqvsNA1EAm9caGcyLCw1UtSqt
oN1ukSXnkgQ=
=JXiU
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
