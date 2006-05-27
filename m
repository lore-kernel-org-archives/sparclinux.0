From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Sat, 27 May 2006 21:09:17 +0000
Subject: 2.6.17-rc5 does not build for sparc
Message-Id: <4478bffd45960@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part4478bffd48074"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part4478bffd48074
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hello,

I tried to build the 2.6.17-rc5 for sparc with SMP enabled. The
kernel was not build due to a missing macro. Here is a patch
which fixes this (I copied the macro from a sparc64 header).

Best wishes,
Krzysztof


----------------------------------------------------
John Malkovich w filmie KLIMT.
Kontrowersyjny. Dekadencki. Rozpasany. Genialny.
W kinach od 26 maja.
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fklimt.html&sid=771

--part4478bffd48074
Content-Type: application/octet-stream; name="missing_raw_lock.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="missing_raw_lock.patch"

T25seSBpbiBsaW51eC0yLjYuMTdzbXAvaW5jbHVkZS9hc20tc3BhcmM6IGFzbS1vZmZzZXRzLmgK
ZGlmZiAtdXIgbGludXgtMi42LjE2L2luY2x1ZGUvYXNtLXNwYXJjL3NwaW5sb2NrLmggbGludXgt
Mi42LjE3c21wL2luY2x1ZGUvYXNtLXNwYXJjL3NwaW5sb2NrLmgKLS0tIGxpbnV4LTIuNi4xNi9p
bmNsdWRlL2FzbS1zcGFyYy9zcGlubG9jay5oCTIwMDYtMDUtMjcgMTk6MzU6MTYuMDAwMDAwMDAw
ICswMjAwCisrKyBsaW51eC0yLjYuMTdzbXAvaW5jbHVkZS9hc20tc3BhcmMvc3BpbmxvY2suaAky
MDA2LTA1LTI3IDIxOjMzOjI4LjAwMDAwMDAwMCArMDIwMApAQCAtMTU0LDYgKzE1NCw4IEBACiAj
ZGVmaW5lIF9fcmF3X3NwaW5fbG9ja19mbGFncyhsb2NrLCBmbGFncykgX19yYXdfc3Bpbl9sb2Nr
KGxvY2spCiAjZGVmaW5lIF9fcmF3X3JlYWRfdHJ5bG9jayhsb2NrKSBnZW5lcmljX19yYXdfcmVh
ZF90cnlsb2NrKGxvY2spCiAKKyNkZWZpbmUgX19yYXdfd3JpdGVfY2FuX2xvY2socncpCSghKHJ3
KS0+bG9jaykKKwogI2VuZGlmIC8qICEoX19BU1NFTUJMWV9fKSAqLwogCiAjZW5kaWYgLyogX19T
UEFSQ19TUElOTE9DS19IICovCg==

--part4478bffd48074--


