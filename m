From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 11 Aug 2006 22:03:16 +0000
Subject: [PATCH] sunlance probing problem
Message-Id: <44dcfea4406f9@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44dcfea442e0d"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part44dcfea442e0d
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Krzysztof Helt (krzysztof.h1@wp.pl)

The patch removes the "le" device from matching list of probed
devices.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---
The sunlance driver allows probing of three devices: le, ledma
and lebuffer. The "le" device is a child entry for either ledma
or lebuffer devices. Thus, each Ethernet adapter is probed twice
and registered as two Ethernet adapters.

I tested it on SS20 and 2.6.18-rc4 kernel.



----------------------------------------------------
Czy 10 minut rozmowy =3D ponad 11 z=B3 oszcz=EAdno=B6ci ?
Sprawd=BC: http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Ftelefon.wp.pl%2Foszczednos=
ci.html&sid=3D842

--part44dcfea442e0d
Content-Type: application/octet-stream; name="lance-id.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lance-id.patch"

ZGlmZiAtdXIgbGludXgtMi42LjE3L2RyaXZlcnMvbmV0L3N1bmxhbmNlLmMgbGludXgtbmV3L2Ry
aXZlcnMvbmV0L3N1bmxhbmNlLmMKLS0tIGxpbnV4LTIuNi4xNy9kcml2ZXJzL25ldC9zdW5sYW5j
ZS5jCTIwMDYtMDgtMTAgMDg6NTg6MzQuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC1uZXcvZHJp
dmVycy9uZXQvc3VubGFuY2UuYwkyMDA2LTA4LTExIDIzOjMzOjExLjAwMDAwMDAwMCArMDIwMApA
QCAtMTU2OSw5ICsxNTY5LDcgQEAKIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKmRwID0gZGV2LT5ub2Rl
OwogCWludCBlcnI7CiAKLQlpZiAoIXN0cmNtcChkcC0+bmFtZSwgImxlIikpIHsKLQkJZXJyID0g
c3BhcmNfbGFuY2VfcHJvYmVfb25lKHNkZXYsIE5VTEwsIE5VTEwpOwotCX0gZWxzZSBpZiAoIXN0
cmNtcChkcC0+bmFtZSwgImxlZG1hIikpIHsKKwlpZiAoIXN0cmNtcChkcC0+bmFtZSwgImxlZG1h
IikpIHsKIAkJc3RydWN0IHNidXNfZG1hICpsZWRtYSA9IGZpbmRfbGVkbWEoc2Rldik7CiAKIAkJ
ZXJyID0gc3BhcmNfbGFuY2VfcHJvYmVfb25lKHNkZXYtPmNoaWxkLCBsZWRtYSwgTlVMTCk7CkBA
IC0xNjAyLDkgKzE2MDAsNiBAQAogCiBzdGF0aWMgc3RydWN0IG9mX2RldmljZV9pZCBzdW5sYW5j
ZV9zYnVzX21hdGNoW10gPSB7CiAJewotCQkubmFtZSA9ICJsZSIsCi0JfSwKLQl7CiAJCS5uYW1l
ID0gImxlZG1hIiwKIAl9LAogCXsK

--part44dcfea442e0d--


