From: Jason Wever <weeve@gentoo.org>
Date: Tue, 16 Mar 2004 21:47:52 +0000
Subject: missing define for SNDRV_DMA_TYPE_PCI in 2.6.5_rc1
Message-Id: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810780-464173766-1079473672=:7544"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810780-464173766-1079473672=:7544
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Looking around in 2.6.5_rc1, it looks like the driver for cs4231 had some 
work.  Among the changes for the driver, two new macros, 
SNDRV_DMA_TYPE_PCI and SNDRV_DMA_TYPE_SBUS, were added.  
SNDRV_DMA_TYPE_PCI however, is not defined in include/sound/memalloc.h, 
where SNDRV_DMA_TYPE_SBUS is. In 2.6.4 SNDRV_DMA_TYPE_PCI was defined as 
buffer type 3, but in 2.6.5_rc1 3 is now SNDRV_DMA_TYPE_DEV_SG.

As a real stab in the dark as I don't know what defines what a buffer type 
is (so one knows how to define the macro), or if it's arbitrary value, i added
an entry for SNDRV_DMA_TYPE_PCI as buffer type 5 in 
include/sound/memalloc.h.  Between doing that and fixing a small syntax 
error in cs4231, it now builds.  Patch is attached...  

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAV3YLdKvgdVioq28RAqqbAKCuNz4LAVnAvWiTVvltP7Ur7/lj6gCgtGBe
NN5SFsrZiOy+A1YfPBB0uVM=
=f7Rt
-----END PGP SIGNATURE-----
---1463810780-464173766-1079473672=:7544
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cs4231.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403161447520.7544@stargazer.weeve.org>
Content-Description: memalloc and cs4231 patch
Content-Disposition: attachment; filename="cs4231.patch"

LS0tIGluY2x1ZGUvc291bmQvbWVtYWxsb2MuaC5vcmlnCTIwMDQtMDMtMTYg
MTQ6Mzk6MTguMzAzMjMzMDAwIC0wNzAwDQorKysgaW5jbHVkZS9zb3VuZC9t
ZW1hbGxvYy5oCTIwMDQtMDMtMTYgMTQ6Mzk6NDkuMjUzMjMzMDAwIC0wNzAw
DQpAQCAtNTEsNiArNTEsNyBAQA0KICNkZWZpbmUgU05EUlZfRE1BX1RZUEVf
REVWCQkyCS8qIGdlbmVyaWMgZGV2aWNlIGNvbnRpbnVvdXMgKi8NCiAjZGVm
aW5lIFNORFJWX0RNQV9UWVBFX0RFVl9TRwkJMwkvKiBnZW5lcmljIGRldmlj
ZSBTRy1idWZmZXIgKi8NCiAjZGVmaW5lIFNORFJWX0RNQV9UWVBFX1NCVVMJ
CTQJLyogU0JVUyBjb250aW51b3VzICovDQorI2RlZmluZSBTTkRSVl9ETUFf
VFlQRV9QQ0kJCTUJLyogUENJIGNvbnRpbnVvdXMgKi8NCiANCiAvKg0KICAq
IGluZm8gZm9yIGJ1ZmZlciBhbGxvY2F0aW9uDQotLS0gc291bmQvc3BhcmMv
Y3M0MjMxLmMub3JpZwkyMDA0LTAzLTE2IDE0OjM5OjI3LjQ5MzIzMzAwMCAt
MDcwMA0KKysrIHNvdW5kL3NwYXJjL2NzNDIzMS5jCTIwMDQtMDMtMTYgMTQ6
NDA6MDYuMDUzMjMzMDAwIC0wNzAwDQpAQCAtMTU3MSw3ICsxNTcxLDcgQEAN
CiAjaWZkZWYgRUJVU19TVVBQT1JUDQogCWlmIChjaGlwLT5mbGFncyAmIENT
NDIzMV9GTEFHX0VCVVMpIHsNCiAJCXNuZF9wY21fbGliX3ByZWFsbG9jYXRl
X3BhZ2VzX2Zvcl9hbGwocGNtLCBTTkRSVl9ETUFfVFlQRV9QQ0ksDQotCQkJ
CQkJICAgICAgc25kX2RtYV9wY2lfZGF0YShjaGlwLT5kZXZfdS5wZGV2KQ0K
KwkJCQkJCSAgICAgIHNuZF9kbWFfcGNpX2RhdGEoY2hpcC0+ZGV2X3UucGRl
diksDQogCQkJCQkJICAgICAgNjQqMTAyNCwgMTI4KjEwMjQpOw0KIAl9IGVs
c2Ugew0KICNlbmRpZg0K

---1463810780-464173766-1079473672=:7544--
