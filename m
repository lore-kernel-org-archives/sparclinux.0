From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 12 Aug 2006 13:20:55 +0000
Subject: Re: [PATCH] sunlance probing problem
Message-Id: <44ddd5b780824@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44ddd5b782f55"
List-Id: <sparclinux.vger.kernel.org>
References: <44dcfea4406f9@wp.pl>
In-Reply-To: <44dcfea4406f9@wp.pl>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part44ddd5b782f55
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia 12-08-2006 o godz. 1:11 Eric Brower napisa=B3(a):
> The "le" is not always a child of lebuffer or ledma.  Attached is
> output from an SS2, where le hangs directly off sbus.  Granted,
this
> is an older "le" implementation.
>=20

Thank you for the hint. This is a corrected patch which checks if
the "le" is child of ledma or lebuffer.

From: Krzysztof Helt (krzysztof.h1@wp.pl)

The patch skips probing of the "le" device if it is a child of
"ledma" or "lebuffer".

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---
I tested it on SS20 and 2.6.18-rc4 kernel.


----------------------------------------------------
Czy 10 minut rozmowy =3D ponad 11 z=B3 oszcz=EAdno=B6ci ?
Sprawd=BC: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Ftelefon.wp.pl%2Foszczednos=
ci.html&sid=3D842

--part44ddd5b782f55
Content-Type: application/octet-stream; name="lance-id.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lance-id.patch"

ZGlmZiAtdXByIGxpbnV4LTIuNi4xNy9kcml2ZXJzL25ldC9zdW5sYW5jZS5jIGxpbnV4LW5ldy9k
cml2ZXJzL25ldC9zdW5sYW5jZS5jCi0tLSBsaW51eC0yLjYuMTcvZHJpdmVycy9uZXQvc3VubGFu
Y2UuYwkyMDA2LTA4LTEwIDA4OjU4OjM0LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtbmV3L2Ry
aXZlcnMvbmV0L3N1bmxhbmNlLmMJMjAwNi0wOC0xMiAxNTowMjoyMC4wMDAwMDAwMDAgKzAyMDAK
QEAgLTE1NzAsNyArMTU3MCwxNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzdW5sYW5jZV9zYnVz
X3Byb2JlCiAJaW50IGVycjsKIAogCWlmICghc3RyY21wKGRwLT5uYW1lLCAibGUiKSkgewotCQll
cnIgPSBzcGFyY19sYW5jZV9wcm9iZV9vbmUoc2RldiwgTlVMTCwgTlVMTCk7CisJCWlmIChzZGV2
LT5wYXJlbnQpIHsKKwkJCXN0cnVjdCBvZl9kZXZpY2UgKnBhcmVudCA9ICZzZGV2LT5wYXJlbnQt
Pm9mZGV2OworCisJCQlpZiAoIXN0cmNtcChwYXJlbnQtPm5vZGUtPm5hbWUsICJsZWRtYSIpIHx8
CisJCQkgICAgIXN0cmNtcChwYXJlbnQtPm5vZGUtPm5hbWUsICJsZWJ1ZmZlciIpKSB7CisJCQkJ
LyogdGhpcyBpcyBhIGNoaWxkIG9mIGFscmVhZHkgcHJvYmVkIGRldmljZSAqLworCQkJCWVyciA9
IDA7CisJCQl9IGVsc2UKKwkJCQllcnIgPSBzcGFyY19sYW5jZV9wcm9iZV9vbmUoc2Rldi0+Y2hp
bGQsIE5VTEwsIE5VTEwpOworCQl9IGVsc2UKKwkJCWVyciA9IHNwYXJjX2xhbmNlX3Byb2JlX29u
ZShzZGV2LT5jaGlsZCwgTlVMTCwgTlVMTCk7CiAJfSBlbHNlIGlmICghc3RyY21wKGRwLT5uYW1l
LCAibGVkbWEiKSkgewogCQlzdHJ1Y3Qgc2J1c19kbWEgKmxlZG1hID0gZmluZF9sZWRtYShzZGV2
KTsKIAo=

--part44ddd5b782f55--


