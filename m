From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Tue, 17 Oct 2006 09:36:25 +0000
Subject: [PATCH] Sparc compilation fix with floppy enabled
Message-Id: <4534a4192f1c2@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part4534a41931841"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part4534a41931841
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

This patch fixes a typo to make kernel compilable when floppy driver for Sparc is build.

Krzysztof Helt

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

Found in linux-2.6.19-rc2.

--part4534a41931841
Content-Type: text/x-patch; name="fix-floppy-compilation.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fix-floppy-compilation.diff"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4xOC9hcmNoL3NwYXJjL2tlcm5lbC9pcnEuYyBsaW51eC1uZXcv
YXJjaC9zcGFyYy9rZXJuZWwvaXJxLmMKLS0tIGxpbnV4LTIuNi4xOC9hcmNoL3NwYXJjL2tlcm5l
bC9pcnEuYwkyMDA2LTEwLTE3IDExOjE5OjAzLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtbmV3
L2FyY2gvc3BhcmMva2VybmVsL2lycS5jCTIwMDYtMTAtMTcgMTE6MjA6NTcuMDAwMDAwMDAwICsw
MjAwCkBAIC0zNTEsNyArMzUxLDcgQEAgdm9pZCBoYW5kbGVyX2lycShpbnQgaXJxLCBzdHJ1Y3Qg
cHRfcmVncwogfQogCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfRkQKLWV4dGVybiB2b2lkIGZsb3Bw
eV9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqZGV2X2lkKQorZXh0ZXJuIHZvaWQgZmxvcHB5X2lu
dGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpOwogCiB2b2lkIHNwYXJjX2Zsb3BweV9pcnEo
aW50IGlycSwgdm9pZCAqZGV2X2lkLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIHsK

--part4534a41931841--


