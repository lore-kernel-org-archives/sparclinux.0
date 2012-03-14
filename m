From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 14 Mar 2012 04:01:02 +0000
Subject: Re: New build failures in sparc.
Message-Id: <20120314040102.GA26084@thor.bakeyournoodle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <sparclinux.vger.kernel.org>
References: <CAP=VYLpfM0AFWQp7Q=xYHnCd_6vEXKKL1EL5daGcO9gsJZH=7Q@mail.gmail.com>
 <20120313.154848.265971549311147422.davem@davemloft.net>
 <20120314102830.aa7b1139bff158d30ac57505@canb.auug.org.au>
 <20120313.173741.18086192847996966.davem@davemloft.net>
In-Reply-To: <20120313.173741.18086192847996966.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 05:37:41PM -0700, David Miller wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 14 Mar 2012 10:28:30 +1100
>=20
> > Yeah, we updated our sparc64 toolchain yesterday ... Tony says he
> > will try applying the patch(es) from the bugzilla.
>=20
> Meanwhile I'll add a workaround to the sparc makefiles, and
> push that to Linus.  This way it will work no matter what
> combination of tools someone has.

Thanks Dave, we may be hitting a related but different issue as gcc
4.6.3 seems to have that patch already.

Yours Tony

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPYBf+AAoJEEsCiJRY75GK4HIQAMl+Pt09j9/OFVaTRHfsfD1Q
5l6E3k4qNomCNKxa7P3tVZGOeCBP8lJF9WRWwYSGyZMLl1kxJcBsR9Qm6mWcWdAt
rWIKTAigm3AY2HM3kgXswjwO33DbQRCQXgmx96+EMdyMVConWleqIkl30y/veOrr
2xbtSS3a+qiDf154EbXYIBrQJtDzYHrmzPE8qq63yrTO7BEDDLQeQl8cLsKq8NUN
nmYcgDgYVYOOjsJToVVLHeQlY6P5UsvjZ4n4nFSaABdeI/Que8G8Gggdd+O2CZPF
KBK2Wd0gV3/gbhKDGh0kH1Pb6hVfr/FKR1cWOgs3dIFeUW2X91X5sAPRqOPGrrnn
ktkvEj9VEMz0LB4Js6uY3yTVm1oTNSP4KXkeAw0ObgBT8zTMX/FS+q2gXqc/eKgn
nQ5sGs68RWFb0oxTIfDqWePWjgZmtRWC7QiWjBU2HcgkNtRerDlMJUy0I4no7fIs
dhCfPzoPqAT5Vr6z00Bja/u5wxLoVpAlro+I0rpbK8sMRst5eWLz5KzOJBigZFwm
EmrT721Q2b3oLiH5s4DSRFkk/ICoEfrifz6i96t2L5tR14VX/6nizp2FAKERO+gV
aZ6Hy7bfw0VmCnOzcNr/0CN8zzR8hxhbePIHJwQ3Gn/Ppbv4wbWXM0KVHhyoqAxR
DCGsyLJoGph7ug5573Nw
=7MJ0
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
