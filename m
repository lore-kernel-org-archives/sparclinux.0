From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Mon, 05 Jun 2006 07:21:15 +0000
Subject: [PATCH] migration cost tune up in sparc smp
Message-Id: <4483db6b9a343@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part4483db6b9ca4b"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part4483db6b9ca4b
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch sets the max_cache_size value required to tune up
scheduler in SMP systems. Otherwise, the calculated
migration_cost is too high and task scheduling may lock up.
Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch is for 2.6.17-rc5 kernel. This patch helps with Bob
Breuer's patch. Default cache size (20MB) leads to calculation of
the migration cost 20000 (20msecs).  The calculated cost of
migration is 4000 (4msecs) on dual SM81 with the patch.

The same trick is used with setting up max_cache_size  on i386
architecture. I assume the value should be set to on sparc64 as
well to correctly tune up the scheduler.=20

Regards,
Krzysztof

----------------------------------------------------
Nowe serie superksi=B1=BFek o Czarodziejkach WITCH!
Poznaj =B6wiat bohaterek WITCH!=20
Will, Irma, Taranee, Cornelia i Hay-Lin zapraszaj=B1 do ksi=EAgarni.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fwitch.html&s=
id=3D781

--part4483db6b9ca4b
Content-Type: text/x-patch; name="sparc32-migration-cost.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparc32-migration-cost.patch"

ZGlmZiAtdXJwIGxpbnV4LTIuNi4xNi9hcmNoL3NwYXJjL2tlcm5lbC9zbXAuYyBsaW51eC0yLjYu
MTcvYXJjaC9zcGFyYy9rZXJuZWwvc21wLmMKLS0tIGxpbnV4LTIuNi4xNi9hcmNoL3NwYXJjL2tl
cm5lbC9zbXAuYwkyMDA2LTA2LTA1IDA4OjU2OjA2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgt
Mi42LjE3L2FyY2gvc3BhcmMva2VybmVsL3NtcC5jCTIwMDYtMDYtMDUgMDk6MTU6MjguMDAwMDAw
MDAwICswMjAwCkBAIC02OSw2ICs2OSwxNyBAQCB2b2lkIF9faW5pdCBzbXBfc3RvcmVfY3B1X2lu
Zm8oaW50IGlkKQogCQkJCQkJICAgICAiY2xvY2stZnJlcXVlbmN5IiwgMCk7CiAJY3B1X2RhdGEo
aWQpLnByb21fbm9kZSA9IGNwdV9ub2RlOwogCWNwdV9kYXRhKGlkKS5taWQgPSBjcHVfZ2V0X2h3
bWlkKGNwdV9ub2RlKTsKKworCS8qIHRoaXMgaXMgcmVxdWlyZWQgdG8gdHVuZSB0aGUgc2NoZWR1
bGVyIGNvcnJlY3RseSAqLworCS8qIGlzIGl0IHBvc3NpYmxlIHRvIGhhdmUgQ1BVcyB3aXRoIGRp
ZmZlcmVudCBjYWNoZSBzaXplcz8gKi8KKwlpZiAoaWQgPT0gYm9vdF9jcHVfaWQpIHsKKwkJaW50
IGNhY2hlX2xpbmUsY2FjaGVfbmxpbmVzOworCQljYWNoZV9saW5lID0gMHgyMDsKKwkJY2FjaGVf
bGluZSA9IHByb21fZ2V0aW50ZGVmYXVsdChjcHVfbm9kZSwgImVjYWNoZS1saW5lLXNpemUiLCBj
YWNoZV9saW5lKTsKKwkJY2FjaGVfbmxpbmVzID0gMHg4MDAwOworCQljYWNoZV9ubGluZXMgPSBw
cm9tX2dldGludGRlZmF1bHQoY3B1X25vZGUsICJlY2FjaGUtbmxpbmVzIiwgY2FjaGVfbmxpbmVz
KTsKKwkJbWF4X2NhY2hlX3NpemUgPSBjYWNoZV9saW5lICogY2FjaGVfbmxpbmVzOworCX0KIAlp
ZiAoY3B1X2RhdGEoaWQpLm1pZCA8IDApCiAJCXBhbmljKCJObyBNSUQgZm91bmQgZm9yIENQVSVk
IGF0IG5vZGUgMHglMDhkIiwgaWQsIGNwdV9ub2RlKTsKIH0K

--part4483db6b9ca4b--


