From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Wed, 15 Dec 2004 20:21:35 +0000
Subject: [PATCH] OBP naming for 64-bit systems
Message-Id: <1103142095.24105.91.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-7Y07cwmWGDieXyTLY/dB"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-7Y07cwmWGDieXyTLY/dB
Content-Type: multipart/mixed; boundary="=-vGsDOCbeGAcSIUTxvfra"


--=-vGsDOCbeGAcSIUTxvfra
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This was Keith M Wesolowski's work back before he was working for Sun,
but his employment contract prohibits him from making contributions
(including asking for this patch to be pushed into mainline), so I am
asking.

Here are his words on this patch:
> Also, what are the problems with the obp64-naming patch that you
mention
> in the patch header?  You said it is totally broken on Cheetah/Jalapeno.

> Change the OBP naming for 64-bit systems.  This better matches the
> reg/offset calculations done by the PROM on Spitfire systems, and
> prevents duplicate names (!) in openpromfs.  It's utterly broken on
> Cheetah/Jalapeno however.

The sunfire systems and some of the smaller Cheetah-based boards also
use a different board numbering system that's incompatible with the
overly simple algorithm I included.  In other words, we trade one kind
of breakage for another - the patch is useful because the systems it
breaks are rare and the ones it fixes are common. :-)


--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-vGsDOCbeGAcSIUTxvfra
Content-Disposition: attachment; filename=1340_sparc-obp64-naming.patch
Content-Type: text/x-patch; name=1340_sparc-obp64-naming.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

RnJvbSBodHRwOi8vZGV2LmdlbnRvby5vcmcvfndlc29sb3dzDQoNCkNoYW5nZSB0aGUgT0JQIG5h
bWluZyBmb3IgNjQtYml0IHN5c3RlbXMuICBUaGlzIGJldHRlciBtYXRjaGVzIHRoZQ0KcmVnL29m
ZnNldCBjYWxjdWxhdGlvbnMgZG9uZSBieSB0aGUgUFJPTSBvbiBTcGl0ZmlyZSBzeXN0ZW1zLCBh
bmQNCnByZXZlbnRzIGR1cGxpY2F0ZSBuYW1lcyAoISkgaW4gb3BlbnByb21mcy4gIEl0J3MgdXR0
ZXJseSBicm9rZW4gb24NCkNoZWV0YWgvSmFsYXBlbm8gaG93ZXZlci4NCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KDQo9PT09PSBhcmNoL3NwYXJjNjQvcHJvbS90cmVlLmMgMS4xIHZzIGVkaXRl
ZCA9PT09PQ0KLS0tIDEuMS9hcmNoL3NwYXJjNjQvcHJvbS90cmVlLmMJVHVlIEZlYiAgNSAwOTo0
MDoyOSAyMDAyDQorKysgZWRpdGVkL2FyY2gvc3BhcmM2NC9wcm9tL3RyZWUuYwlNb24gTWFyIDI5
IDExOjU3OjQ0IDIwMDQNCkBAIC0xOTYsNiArMTk2LDcgQEANCiB7DQogCWludCBpLCBzYnVzID0g
MDsNCiAJaW50IHBjaSA9IDAsIGVidXMgPSAwLCBpZGUgPSAwOw0KKwljaGFyICpuYW1lOw0KIAlz
dHJ1Y3QgbGludXhfcHJvbV9yZWdpc3RlcnMgKnJlZzsNCiAJc3RydWN0IGxpbnV4X3Byb202NF9y
ZWdpc3RlcnMgcmVnNjRbUFJPTVJFR19NQVhdOw0KIAkNCkBAIC0yNDEsNiArMjQyLDcgQEANCiAJ
CXJldHVybiAtMTsNCiAJfQ0KIAlidWZmZXIgW2ldID0gMDsNCisJbmFtZSA9IGJ1ZmZlcjsNCiAJ
bGVuIC09IGk7DQogCWkgPSBwcm9tX2dldHByb3BlcnR5IChub2RlLCAicmVnIiwgKGNoYXIgKily
ZWc2NCwgc2l6ZW9mIChyZWc2NCkpOw0KIAlpZiAoaSA8PSAwKSByZXR1cm4gMDsNCkBAIC0yNjcs
OSArMjY5LDE1IEBADQogCX0gZWxzZSBpZiAoaSA9PSA0KSB7CS8qIEhhcHBlbnMgb24gODA0Midz
IGNoaWxkcmVuIG9uIFVsdHJhL1BDSS4gKi8NCiAJCXJlZyA9IChzdHJ1Y3QgbGludXhfcHJvbV9y
ZWdpc3RlcnMgKilyZWc2NDsNCiAJCXNwcmludGYgKGJ1ZmZlciwgIkAleCIsIHJlZ1swXS53aGlj
aF9pbyk7DQorCX0gZWxzZSBpZiAoIXN0cmNtcChuYW1lLCAiZmhjIikgfHwgIXN0cmNtcChuYW1l
LCAiY291bnRlci10aW1lciIpKSB7DQorCQlzcHJpbnRmKGJ1ZmZlciwgIkAleCwleCIsDQorCQkJ
KHVuc2lnbmVkIGludCkoKHJlZzY0WzBdLnBoeXNfYWRkciA+PiAzMykgJiAweDFmKSwNCisJCQko
dW5zaWduZWQgaW50KShyZWc2NFswXS5waHlzX2FkZHIpKTsNCiAJfSBlbHNlIHsNCi0JCXNwcmlu
dGYgKGJ1ZmZlciwgIkAleCwleCIsDQotCQkJICh1bnNpZ25lZCBpbnQpKHJlZzY0WzBdLnBoeXNf
YWRkciA+PiAzNiksDQorCQlpbnQgdXBhaWQgPSBwcm9tX2dldGludChub2RlLCAidXBhLXBvcnRp
ZCIpOw0KKwkJaWYgKHVwYWlkIDwgMCkNCisJCQl1cGFpZCA9ICh1bnNpZ25lZCBpbnQpKHJlZzY0
WzBdLnBoeXNfYWRkciA+PiAzNik7DQorCQlzcHJpbnRmIChidWZmZXIsICJAJXgsJXgiLCB1cGFp
ZCwNCiAJCQkgKHVuc2lnbmVkIGludCkocmVnNjRbMF0ucGh5c19hZGRyKSk7DQogCX0NCiAJcmV0
dXJuIDA7DQo=


--=-vGsDOCbeGAcSIUTxvfra--

--=-7Y07cwmWGDieXyTLY/dB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBwJzPOpjtAl+gMRURAv/SAJ0ZDSd7fd+gILOMj+A76O7S6Q2NUACfQnkJ
lKe6/IOurQLiDt7GXFYxj5E=
=o2+X
-----END PGP SIGNATURE-----

--=-7Y07cwmWGDieXyTLY/dB--

