From: Joshua Kwan <joshk@triplehelix.org>
Date: Fri, 27 Aug 2004 19:41:07 +0000
Subject: [PATCH] export more symbols on sparc32
Message-Id: <cgo2on$h2$1@sea.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig2467771BB735B1DE224C1A76"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2467771BB735B1DE224C1A76
Content-Type: multipart/mixed;
 boundary="------------020909030807040807040100"

This is a multi-part message in MIME format.
--------------020909030807040807040100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch against 2.6.8.1 exports a bunch of symbols that allow our 
highly modular configs to work.

Now, re: the pci hunk, it may not be worth applying; a better solution 
might be to turn off PCI for sparc32.. I have never seen a PCI-gifted 
sparc32 but the config is largely an 'allmodconfig' and I decided to 
just see what would happen.

Comments?

-- 
Joshua Kwan

--------------020909030807040807040100
Content-Type: text/plain;
 name="sparc32-export-more-ksyms.dpatch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="sparc32-export-more-ksyms.dpatch"

IyBEUDogZXhwb3J0IG1vcmUgc3ltYm9scyBmb3Igc3BhcmMzMiBzbyB3ZSBjYW4gZ2V0IG91
ciBzdHVmZiBidWlsdAojIERQOiB1cHN0cmVhbS1zdGF0dXM6IHVuc2VudAoKLS0tIGtlcm5l
bC1zb3VyY2UtMi42LjgvYXJjaC9zcGFyYy9rZXJuZWwvc3BhcmNfa3N5bXMuY34JMjAwNC0w
OC0yNyAwMTowOTowNi4wMDAwMDAwMDAgLTA3MDAKKysrIGtlcm5lbC1zb3VyY2UtMi42Ljgv
YXJjaC9zcGFyYy9rZXJuZWwvc3BhcmNfa3N5bXMuYwkyMDA0LTA4LTI3IDAxOjEwOjI3LjAw
MDAwMDAwMCAtMDcwMApAQCAtMjE0LDYgKzIxNCwxMCBAQAogRVhQT1JUX1NZTUJPTChwY2lf
ZG1hX3N5bmNfc2luZ2xlX2Zvcl9kZXZpY2UpOwogRVhQT1JUX1NZTUJPTChwY2lfZG1hX3N5
bmNfc2dfZm9yX2NwdSk7CiBFWFBPUlRfU1lNQk9MKHBjaV9kbWFfc3luY19zZ19mb3JfZGV2
aWNlKTsKK0VYUE9SVF9TWU1CT0wocGNpX21hcF9zZyk7CitFWFBPUlRfU1lNQk9MKHBjaV91
bm1hcF9zZyk7CitFWFBPUlRfU1lNQk9MKHBjaV9tYXBfcGFnZSk7CitFWFBPUlRfU1lNQk9M
KHBjaV91bm1hcF9wYWdlKTsKIC8qIEFjdHVhbGx5LCBpb3JlbWFwL2lvdW5tYXAgYXJlIG5v
dCBQQ0kgc3BlY2lmaWMuIEJ1dCBpdCBpcyBvayBmb3IgZHJpdmVycy4gKi8KIEVYUE9SVF9T
WU1CT0woaW9yZW1hcCk7CiBFWFBPUlRfU1lNQk9MKGlvdW5tYXApOwpAQCAtMjk4LDYgKzMw
Miw5IEBACiAvKiBDYWNoZSBmbHVzaGluZy4gICovCiBFWFBPUlRfU1lNQk9MKHNwYXJjX2Zs
dXNoX3BhZ2VfdG9fcmFtKTsKIAorLyogRm9yIHdoZW4gc2VyaWFsIHN0dWZmIGlzIGJ1aWx0
IGFzIG1vZHVsZXMuICovCitFWFBPUlRfU1lNQk9MKHN1bl9kb19icmVhayk7CisKIEVYUE9S
VF9TWU1CT0woX19yZXRfZWZhdWx0KTsKIAogRVhQT1JUX1NZTUJPTChtZW1jbXApOwo=
--------------020909030807040807040100--

--------------enig2467771BB735B1DE224C1A76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS+OVqOILr94RG8mAQII3Q//UKPJxP9UIFp5z02faUrcttj47/utfRTm
XIEHcUHrw1QZcjPrTO7U5/EVQMw1wNiS4ZYykQ//Ak/fkqfbXEY/lnNAsnvpvpt6
i29gfILXIWo+XXz/ZCyTWB9siCEMXOKDGKqQkDnLqLdABHuNPP34bacEqvVFWpGN
WkQRyT7UcXavSfJGqbXAOphNOCmTDnlqHKeuPVAe0o/3H29qoXJTrp6uXtszWxx6
e6YUCGBQlM5hO8Yp1lUNLtN4N3w83QJ5MVLMM77yzVvoQTU7wD0h7IxwnrWJTeSX
qwXRaUliZt423wvdD0lF1TS3soxwQd7vJP6AVSudmFzVxVfIJ5J0roxEKw71kJp1
D+w2c0M4YEoDXRFLlhxvLQ4Mv95jxa0y/ARap8O7+4gHCIvB8a8ztuNz5dmTP2M8
mIo2EGzHM2wY3pp6HB2EH6izYzpsD3Wq0QT5mv0NKmfEbezuFsrWHnufaDoXBUNm
5Dt5+WglY64fianOId++rutFImTIfS6FZB+JT6KDgHkl1UcpX7u2JDZVJzJdrh14
fx8nsrxKWuudVKVxmaekFxoEo/BHJIH3w0yvqVypVy/UsQSuaKrWgCckOUolVy8l
83vW6gVlMQKD/QsgTzbuAyf8knMuV+HjzoZOGEwzY1IJSZjOo0smvhc/0IEyizNx
uM+vss0Sppg=
=Qzon
-----END PGP SIGNATURE-----

--------------enig2467771BB735B1DE224C1A76--

