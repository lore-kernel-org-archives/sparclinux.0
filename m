From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 19 Jan 2016 20:56:08 +0000
Subject: Re: using ptrace to cancel a syscall on sparc
Message-Id: <20160119205608.GH14840@vapier.lan>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CEUtFxTsmBsHRLs3"
List-Id: <sparclinux.vger.kernel.org>
References: <20151220054754.GZ11489@vapier.lan>
In-Reply-To: <20151220054754.GZ11489@vapier.lan>
To: sparclinux@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Jan 2016 15:10, David Miller wrote:
> From: Mike Frysinger <vapier@gentoo.org>
> Date: Mon, 18 Jan 2016 06:32:30 -0500
>=20
> > looks like the bug is in arch/sparc/kernel/syscalls.S:linux_syscall_tra=
ce32
> > (and linux_syscall_trace).  they don't reload the args from the pt_regs
> > struct after calling syscall_trace_enter.  i put in a small hack:
>=20
> Mike, please give this patch a test, thanks!

it fixes my reduced test case, and seems to fix my original testcase
(a program that uses ptrace to monitor fs behavior in static progs).
thanks !

Tested-by: Mike Frysinger <vapier@gentoo.org>
-mike

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnqLnAAoJEEFjO5/oN/WBenoP/3BaBWeDxnlBONla3cbk32Bb
v9OTUL523UMhgG0AqovySDdsegsgud5GvCBkbAvvceVtPWCWYBBg+uW0fRkHiYv5
kY8I9MENy+j2mQU6sMeKk/G4UWnR/Q9HRVy3Xic/IqerRbDEgdJJI+BJCjEHHfGk
8jtX7KTiVJENUGLDA3w92exn1XijrAycFtTkLZ8wB34fuxI+ooH9ZhAIGhGm5PKW
zvK6FQwogw6ouN03MJ4aWzJKFQRbGW7+z2iHJJl4LDZI2SDWPAAUPqms2tg25bRT
lgMSZx7a+PQHACOwv81i/gz2ID0DxlYzsi5c1Rp0UZjJVfpFzwklmIbGK7+j5F6U
R24LyRhJ9+qxKCCZ2D7QYz8BLDNIl3524TzsqYtA62knpf+qfh/hd0sHGrlzZOcH
llDewEide9XrjeKRS2Gttml/boeQ7tGB9ZJB2wnjYysB4eouaojx1+5N55eZI8aY
TnpXOhrCeZRWzWrtXRzOIm9vvEM5O8tSIn71bPzGja2/wxw3fI/7r8zdN+KpAuzT
HMeN0Qty4Gk21XMhyr/6/4vU7N/6jWCZfRaJ6q8KQs/Er7K3FldxwJUV7NuibXnx
LNLu3VW/15SOn94n3asXpkXKcjI93XO/R1uq+AECs7CA8mTx6QYQis68HUgar9Ux
0kj8UI5a+hDmi/+vFaT3
=IkwM
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
