From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sun, 12 Dec 2004 00:06:39 +0000
Subject: Re: [PATCH] updated asm-sparc/{processor,signal,sigcontext}.h to
Message-Id: <1102809999.21413.103.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-k2RWqDjFILH6G13YE2U9"
List-Id: <sparclinux.vger.kernel.org>
References: <1102503203.20234.7.camel@cid.outersquare.org>
In-Reply-To: <1102503203.20234.7.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-k2RWqDjFILH6G13YE2U9
Content-Type: multipart/mixed; boundary="=-q3fETKwVEBoLvH1Hl0sS"


--=-q3fETKwVEBoLvH1Hl0sS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > Ok, here's the updated one.  It's much cleaner now, and I also did NOT
> > do asm-x86_64's '#include <signal.h>' if we're !__KERNEL__.  I found
> > that to be a rather ugly kludge.  It's the userland code that should
> > change there, not us.
>=20
> Applied, thanks Jeremy.

In changing from the glibc check to __KERNEL__, processor.h doesn't work
for some userland code.  Here's an update to correct this.

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-q3fETKwVEBoLvH1Hl0sS
Content-Disposition: attachment; filename=sparchead.patch
Content-Type: text/x-patch; name=sparchead.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGluY2x1ZGUvYXNtLXNwYXJjL3Byb2Nlc3Nvci5oLm9yaWcJMjAwNC0xMi0xMSAxNTo0OToy
NC41MjI2MDM5MTIgLTA4MDANCisrKyBpbmNsdWRlL2FzbS1zcGFyYy9wcm9jZXNzb3IuaAkyMDA0
LTEyLTExIDE1OjQ5OjE4Ljg2NTQ2MzkyOCAtMDgwMA0KQEAgLTQ0LDExICs0NCwxMyBAQA0KIHN0
cnVjdCB0YXNrX3N0cnVjdDsNCiANCiAjaWZkZWYgX19LRVJORUxfXw0KLXN0cnVjdCBmcHEgew0K
KyNkZWZpbmUgX19mcHEgZnBxDQorI2VuZGlmDQorDQorc3RydWN0IF9fZnBxIHsNCiAJdW5zaWdu
ZWQgbG9uZyAqaW5zbl9hZGRyOw0KIAl1bnNpZ25lZCBsb25nIGluc247DQogfTsNCi0jZW5kaWYN
CiANCiB0eXBlZGVmIHN0cnVjdCB7DQogCWludCBzZWc7DQpAQCAtNjcsMTMgKzY5LDE3IEBAIHN0
cnVjdCB0aHJlYWRfc3RydWN0IHsNCiAJdW5zaWduZWQgbG9uZyAgIGZsb2F0X3JlZ3NbMzJdIF9f
YXR0cmlidXRlX18gKChhbGlnbmVkICg4KSkpOw0KIAl1bnNpZ25lZCBsb25nICAgZnNyOw0KIAl1
bnNpZ25lZCBsb25nICAgZnBxZGVwdGg7DQotCXN0cnVjdCBmcHEJZnBxdWV1ZVsxNl07DQorCXN0
cnVjdCBfX2ZwcQlmcHF1ZXVlWzE2XTsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJbW1fc2Vn
bWVudF90IGN1cnJlbnRfZHM7DQogCXN0cnVjdCBleGVjIGNvcmVfZXhlYzsgICAgIC8qIGp1c3Qg
d2hhdCBpdCBzYXlzLiAqLw0KIAlpbnQgbmV3X3NpZ25hbDsNCiB9Ow0KIA0KKyNpZmRlZiBfX0tF
Uk5FTF9fDQorI3VuZGVmIF9fZnBxDQorI2VuZGlmDQorDQogI2RlZmluZSBTUEFSQ19GTEFHX0tU
SFJFQUQgICAgICAweDEgICAgLyogdGFzayBpcyBhIGtlcm5lbCB0aHJlYWQgKi8NCiAjZGVmaW5l
IFNQQVJDX0ZMQUdfVU5BTElHTkVEICAgIDB4MiAgICAvKiBpcyBhbGxvd2VkIHRvIGRvIHVuYWxp
Z25lZCBhY2Nlc3NlcyAqLw0KIA0K


--=-q3fETKwVEBoLvH1Hl0sS--

--=-k2RWqDjFILH6G13YE2U9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBu4uPOpjtAl+gMRURAoCIAKDd0Det/bvUUiG/vG15vTxWZebjewCg2dHd
BkxhpDC6AH6JdNNs67po4tg=
=7Onm
-----END PGP SIGNATURE-----

--=-k2RWqDjFILH6G13YE2U9--

