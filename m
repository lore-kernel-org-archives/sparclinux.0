From: Jason Wever <weeve@gentoo.org>
Date: Tue, 16 Mar 2004 23:33:57 +0000
Subject: Re: missing define for SNDRV_DMA_TYPE_PCI in 2.6.5_rc1
Message-Id: <Pine.LNX.4.58.0403161629400.7544@stargazer.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463810780-369545579-1079480037=:7544"
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
In-Reply-To: <Pine.LNX.4.58.0403161427310.7544@stargazer.weeve.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810780-369545579-1079480037=:7544
Content-Type: TEXT/PLAIN; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 16 Mar 2004, Jason Wever wrote:

> As a real stab in the dark as I don't know what defines what a buffer type
> is (so one knows how to define the macro), or if it's arbitrary value, i added
> an entry for SNDRV_DMA_TYPE_PCI as buffer type 5 in
> include/sound/memalloc.h.  Between doing that and fixing a small syntax
> error in cs4231, it now builds.  Patch is attached...

So after looking into this a little more, and testing my previous patch, I 
realized it wasn't correct.  snd-malloc would complain about invalid 
device type in the kernel log.  After further reviewing the changes from 
2.6.4 to 2.6.5-rc1, I saw that there was a move to use SNDRV_DMA_TYPE_DEV 
instead of SNDRV_DMA_TYPE_PCI, but that those changes hadn't been 
incorporated into sound/sparc/cs4231.c.

The attached patch fixes that and actually works now.   Thanks for 
tolerating me while i fumbled towards an answer. :)

- -- 
Jason Wever
Gentoo/Sparc Co-Team Lead
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAV47ndKvgdVioq28RAvs4AJ9fVwMaPA6r+eq/X/ifTgl8VBeuYACgs+3e
wuxxi2732PFl+Rklff5gaig=
=8epA
-----END PGP SIGNATURE-----
---1463810780-369545579-1079480037=:7544
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cs4231-take2.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0403161633570.7544@stargazer.weeve.org>
Content-Description: cs4231 patch that actually works
Content-Disposition: attachment; filename="cs4231-take2.patch"

LS0tIHNvdW5kL3NwYXJjL2NzNDIzMS5jLm9yaWcJMjAwNC0wMy0xNiAxNjoy
ODowNC44MTk2ODQwMDAgLTA3MDANCisrKyBzb3VuZC9zcGFyYy9jczQyMzEu
YwkyMDA0LTAzLTE2IDE2OjE3OjI1LjMxOTY4NDAwMCAtMDcwMA0KQEAgLTE1
NzAsOCArMTU3MCw4IEBADQogDQogI2lmZGVmIEVCVVNfU1VQUE9SVA0KIAlp
ZiAoY2hpcC0+ZmxhZ3MgJiBDUzQyMzFfRkxBR19FQlVTKSB7DQotCQlzbmRf
cGNtX2xpYl9wcmVhbGxvY2F0ZV9wYWdlc19mb3JfYWxsKHBjbSwgU05EUlZf
RE1BX1RZUEVfUENJLA0KLQkJCQkJCSAgICAgIHNuZF9kbWFfcGNpX2RhdGEo
Y2hpcC0+ZGV2X3UucGRldikNCisJCXNuZF9wY21fbGliX3ByZWFsbG9jYXRl
X3BhZ2VzX2Zvcl9hbGwocGNtLCBTTkRSVl9ETUFfVFlQRV9ERVYsDQorCQkJ
CQkJICAgICAgc25kX2RtYV9wY2lfZGF0YShjaGlwLT5kZXZfdS5wZGV2KSwN
CiAJCQkJCQkgICAgICA2NCoxMDI0LCAxMjgqMTAyNCk7DQogCX0gZWxzZSB7
DQogI2VuZGlmDQo=

---1463810780-369545579-1079480037=:7544--
