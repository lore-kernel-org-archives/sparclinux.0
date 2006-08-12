From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 12 Aug 2006 19:14:44 +0000
Subject: [PATCH] sparc32: max_cache_size fallback
Message-Id: <44de28a4e7531@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44de28a4e9c4d"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part44de28a4e9c4d
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Krzysztof Helt (krzysztof.h1@wp.pl)

It adds a fallback for CPU cache size detection. According to Sun
documentation, it is possible to have SMP system with SM40 modules.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---

It is added after sparc64 architecture.

Regards,
Krzysztof

----------------------------------------------------
Pensjonat Albatros? wypoczynek w pi=EAknym zak=B1tku W=B3adys=B3awowa.
O krok od pla=BFy, atrakcyjne ceny, dobrze wyposa=BFone pokoje.
Czeg=F3=BF chcie=E6 wi=EAcej? Zapami=EAtaj: albatros.gda.pl - Kliknij:
http://klik.wp.pl/?adr=3Dwww.albatros.gda.pl&sid=3D841

--part44de28a4e9c4d
Content-Type: application/octet-stream; name="sparc32-max-cache-fix.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparc32-max-cache-fix.patch"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4xNy9hcmNoL3NwYXJjL2tlcm5lbC9zbXAuYyBsaW51eC1uZXcv
YXJjaC9zcGFyYy9rZXJuZWwvc21wLmMKLS0tIGxpbnV4LTIuNi4xNy9hcmNoL3NwYXJjL2tlcm5l
bC9zbXAuYwkyMDA2LTA4LTEwIDA4OjU4OjMxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtbmV3
L2FyY2gvc3BhcmMva2VybmVsL3NtcC5jCTIwMDYtMDgtMTIgMTk6MTE6MjAuMDAwMDAwMDAwICsw
MjAwCkBAIC03OSw2ICs3OCw5IEBAIHZvaWQgX19jcHVpbml0IHNtcF9zdG9yZV9jcHVfaW5mbyhp
bnQgaWQKIAkJY2FjaGVfbmxpbmVzID0gMHg4MDAwOwogCQljYWNoZV9ubGluZXMgPSBwcm9tX2dl
dGludGRlZmF1bHQoY3B1X25vZGUsICJlY2FjaGUtbmxpbmVzIiwgY2FjaGVfbmxpbmVzKTsKIAkJ
bWF4X2NhY2hlX3NpemUgPSBjYWNoZV9saW5lICogY2FjaGVfbmxpbmVzOworCQkvKiB0aGlzIGlz
IGZvciBTTTQwIFN1cGVyU3BhcmMgbW9kdWxlcyAqLworCQlpZiAobWF4X2NhY2hlX3NpemUgPT0g
MCkKKwkJCW1heF9jYWNoZV9zaXplID0gMzYgKiAxMDI0OwogCX0KIAlpZiAoY3B1X2RhdGEoaWQp
Lm1pZCA8IDApCiAJCXBhbmljKCJObyBNSUQgZm91bmQgZm9yIENQVSVkIGF0IG5vZGUgMHglMDhk
IiwgaWQsIGNwdV9ub2RlKTsKCg==

--part44de28a4e9c4d--


