From: Max Loparyev <maxl@mcst.ru>
Date: Wed, 05 May 2004 10:04:27 +0000
Subject: sun_floppy_init patch
Message-Id: <1083751467.6618.35.camel@topaz.lab.sun.mcst.ru>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-60sqjJiEQev4SdoS0ERw"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-60sqjJiEQev4SdoS0ERw
Content-Type: multipart/mixed; boundary="=-/Tk5QPk/SRihoRlCNEkT"


--=-/Tk5QPk/SRihoRlCNEkT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

I've found the following problem while developing floppy controller for
sparc. 82077 or pc8477 can work in 4 modes and not in all of them they
provides SRA reg, that located at 82072 status reg address. So, i think
that the right way is to define the status register function pointers
and than try to check it, rather than static 82072 status register.

--=20
Max Loparyev <maxl@mcst.ru>
Moscow center for SPARC technology

--=-/Tk5QPk/SRihoRlCNEkT
Content-Disposition: attachment; filename=sun_floppy_init.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=sun_floppy_init.patch; charset=KOI8-R

LS0tIGluY2x1ZGUvYXNtLXNwYXJjL2Zsb3BweS5oCTIwMDQtMDQtMTQgMTE6MTM6MjkuMDAwMDAw
MDAwICswNDAwDQorKysgaW5jbHVkZS9hc20tc3BhcmMvZmxvcHB5LmgubmV3CTIwMDQtMDUtMDUg
MTI6MzA6MTcuMDY2OTY5MDA0ICswNDAwDQpAQCAtMzI3LDIzICszMjcsMjUgQEANCiAJc3VuX2Zk
YyA9IChzdHJ1Y3Qgc3VuX2ZscHlfY29udHJvbGxlciAqKQ0KIAkgICAgc2J1c19pb3JlbWFwKCZy
LCAwLCBmZF9yZWdzWzBdLnJlZ19zaXplLCAiZmxvcHB5Iik7DQogDQorDQorICAgIGlmKHNwYXJj
X2NwdV9tb2RlbCA9PSBzdW40Yykgew0KKyAgICAJc3VuX2Zkb3BzLmZkX2luYiA9IHN1bl84MjA3
Ml9mZF9pbmI7DQorICAgIAlzdW5fZmRvcHMuZmRfb3V0YiA9IHN1bl84MjA3Ml9mZF9vdXRiOw0K
KyAgICAJZmRjX3N0YXR1cyA9ICZzdW5fZmRjLT5zdGF0dXNfODIwNzI7DQorICAgICAgICAvKiBw
cmludGsoIkFVWElPIEAweCVseFxuIiwgYXV4aW9fcmVnaXN0ZXIpOyAqLyAvKiBQMyAqLw0KKyAg
ICB9IGVsc2Ugew0KKyAgICAJc3VuX2Zkb3BzLmZkX2luYiA9IHN1bl84MjA3N19mZF9pbmI7DQor
ICAgIAlzdW5fZmRvcHMuZmRfb3V0YiA9IHN1bl84MjA3N19mZF9vdXRiOw0KKyAgICAJZmRjX3N0
YXR1cyA9ICZzdW5fZmRjLT5zdGF0dXNfODIwNzc7DQorICAgICAgICAvKiBwcmludGsoIkRPUiBA
MHglcFxuIiwgJnN1bl9mZGMtPmRvcl84MjA3Nyk7ICovIC8qIFAzICovDQorCX0JDQorCQkNCiAJ
LyogTGFzdCBtaW51dGUgc2FuaXR5IGNoZWNrLi4uICovDQotCWlmKHN1bl9mZGMtPnN0YXR1c184
MjA3MiA9PSAweGZmKSB7DQorCWlmKHN1bl9mZGMtPnN0YXR1cyA9PSAweGZmKSB7DQogCQlzdW5f
ZmRjID0gTlVMTDsNCiAJCWdvdG8gbm9fc3VuX2ZkYzsNCiAJfQ0KIA0KLSAgICAgICAgaWYoc3Bh
cmNfY3B1X21vZGVsID09IHN1bjRjKSB7DQotICAgICAgICAgICAgICAgIHN1bl9mZG9wcy5mZF9p
bmIgPSBzdW5fODIwNzJfZmRfaW5iOw0KLSAgICAgICAgICAgICAgICBzdW5fZmRvcHMuZmRfb3V0
YiA9IHN1bl84MjA3Ml9mZF9vdXRiOw0KLSAgICAgICAgICAgICAgICBmZGNfc3RhdHVzID0gJnN1
bl9mZGMtPnN0YXR1c184MjA3MjsNCi0gICAgICAgICAgICAgICAgLyogcHJpbnRrKCJBVVhJTyBA
MHglbHhcbiIsIGF1eGlvX3JlZ2lzdGVyKTsgKi8gLyogUDMgKi8NCi0gICAgICAgIH0gZWxzZSB7
DQotICAgICAgICAgICAgICAgIHN1bl9mZG9wcy5mZF9pbmIgPSBzdW5fODIwNzdfZmRfaW5iOw0K
LSAgICAgICAgICAgICAgICBzdW5fZmRvcHMuZmRfb3V0YiA9IHN1bl84MjA3N19mZF9vdXRiOw0K
LSAgICAgICAgICAgICAgICBmZGNfc3RhdHVzID0gJnN1bl9mZGMtPnN0YXR1c184MjA3NzsNCi0g
ICAgICAgICAgICAgICAgLyogcHJpbnRrKCJET1IgQDB4JXBcbiIsICZzdW5fZmRjLT5kb3JfODIw
NzcpOyAqLyAvKiBQMyAqLw0KLQl9DQogDQogCS8qIFN1Y2Nlc3MuLi4gKi8NCiAJYWxsb3dlZF9k
cml2ZV9tYXNrID0gMHgwMTsNCg==

--=-/Tk5QPk/SRihoRlCNEkT--

--=-60sqjJiEQev4SdoS0ERw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: =?koi8-r?Q?=FC=D4=C1?= =?koi8-r?Q?_=DE=C1=D3=D4=D8?=
	=?koi8-r?Q?_=D3=CF=CF=C2=DD=C5=CE=C9=D1?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=C1=CE=C1?=
	=?koi8-r?Q?_=C3=C9=C6=D2=CF=D7=CF=CA?=
	=?koi8-r?Q?_=D0=CF=C4=D0=C9=D3=D8=C0?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAmLwrnvIZnpJJz0kRAuS4AKCG8PURmGxqUO/fyHeYcgiRgHcRVgCgwWKZ
u+6ORzHaqwUC1DLC5foiYwg=
=o9tl
-----END PGP SIGNATURE-----

--=-60sqjJiEQev4SdoS0ERw--

