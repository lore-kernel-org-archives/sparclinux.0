From: joshk@triplehelix.org (Joshua Kwan)
Date: Thu, 06 May 2004 22:12:31 +0000
Subject: [PATCH] 2.4 fix roundup [0/4]
Message-Id: <20040506221231.GA29031@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

The following are some fixes to the 2.4 sparc/sparc64 arch section that
I've used to allow a successful cross compile on i386 to happen for the
Debian 2.4 kernel packages. Most are also minor fixes and one of them is
a tentative patch that has been compile-tested. It'll all become clear
in the following messages...

The patches apply to 2.4.26 vanilla, but probably work for 2.4.25 and
before as well (considering the amount of bitrot that is addressed
here.)

Thanks,

--=20
Joshua Kwan

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQJq4TqOILr94RG8mAQLsJhAAkAfN0u4ZG2GlVkMwk40r58HMzrBGeRtc
OglpaX5AKYBsPL57/Ygft6Zsqmjg8on+IQ7GHoZF/lP4yWbJuMV/2wqb4cM2aXG3
qumYiyUlRUWmDz0lD5cYi93kfk5CAMmb07uuX1WI8ei6S9BxUAdv1DRM93P5y8JR
+D9dIj9nU3e1mK72O8/oTxYEPBA8vwoaZvNJ1x6HeyGuaAEWWGY0luYOygfUf0yu
5dvXQ+cyKJsjsIepQvzifN4OJJVGKXKXkk+jQ5/7Sz2DAMtcH23pf8fhAov6O+p6
JcCcCC9bZOAsXvAQqnb/mEhAxAPlTvrU09d0EJnnpfneo8mc1wjvToHwCTzDZ7zd
8I+e6YvuHHJnl9ZZDL6Lerp+HAMvrD6cr3A6WHr/UPjmjpVeIw4L6EO/srL4+eHm
lEXwLDnpp69EF/M/TVPxL79Cy1otGRoG0r+j3PeQmLv8VtRev94vJ01iVRNLsRPj
8xqr7GX3udplIjfimn7XQM24sxzqD41VeaAHdvLhqR4hhENPWe1McpVNNSSJawmd
CvPDot/v8yuTaLM9e76d+U1y0wzYpIO7QWp/SQi+tQ9IBBevLEvJsWjSLcpqDWf/
hbWMQ5ryDAlRJ047DKklFLoBW/i/AEXLJvuuH2dLfZmupC0MtMPsymBVfY9LePKt
Xo9iR1sfdvQ=
=gzrp
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
