From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 11 Mar 2004 07:18:47 +0000
Subject: Passing arguments to a kernel image within a tftpboot image
Message-Id: <20040311071847.GE29906@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7mxbaLlpDEyR1+x6"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Would it be possible to pass kernel arguments using some sort of small
bootloader within a tftpboot image to, say, a Linux kernel that is
within?

This is currently wanted for the new Debian installer which should
preferably pass stuff like "DEBCONF_PRIORITY=3Dmedium devfs=3Dmount" to the
kernel in the tftpboot image.

--=20
Joshua Kwan

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQFAS1aOILr94RG8mAQLGwg//c1CpnfZTCH5HGGoMkoYACT8kkjYEwsfX
j4sPmWXVzqo92XtVxYdJ9VPHQTcbgQH0FzqR2mhq0BFYtp1wNZyBSYDmjm8cLuJh
ZswEmlGScxI+T6HUbTbrXF3lUGwRR4Y/+hvwxpXMjfbViXc5QqhCFmWla9ypUFoj
Rq9hf0WE9OwA8QH8nQ4ZMLUyHbIrL+VFvT7hfOr07ZOe3jtuAT63MbAKlD6LjuJ5
QS0gbswyGv9vuapQwHPTjMtnKmtkiCPMQ32hu33FnssqyscWjWtvHSTXrNlHNSgO
EVLTOYNOAP0VhSg/yhbN75muYVb4974Ky9eeAhe2ZI+hGm0APgMq9LORNEPV+bCn
p7tSjXetvhSeFSLXNB6QS0u/Tv2XGeSARfhz9MIEZAcbc006Kk5bUE0ieZ26+8mB
04PqjHe9NB1+i5C/M93/qmC8ljO9WqAOnjABONuye1T3cSwF0j7kRBh5Pm2nKlXa
iI+u/vy+1mFGkV5T4P7t4JDym0mZwVIeMMnYRxD/ROj+nbXy+o+J8t0BP2U7buBc
xNvvGWvnBIpxRydMAcO8+MxiMeG6nuDa5OuxeJ0/40dBnFohW+4PUzBFRxSeXIs9
WYhmNw1YyZglnlJvsB4n8QGSrkC/vhlFftmkVhTIVnVv45ozYSU7XiYfDZpq6bfd
Dh8piJXiKCg=
=U1C7
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
