From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sun, 28 Nov 2004 11:58:49 +0000
Subject: Re: [gentoo-sparc] system lockup bug in >2.6.7-rc1-bk6 tracked down
Message-Id: <1101643129.21614.56.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-yXUEoreIW+Nmk4KIhrZg"
List-Id: <sparclinux.vger.kernel.org>
References: <1101553907.21614.24.camel@cid.outersquare.org>
In-Reply-To: <1101553907.21614.24.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-yXUEoreIW+Nmk4KIhrZg
Content-Type: multipart/mixed; boundary="=-Oaxe21t1rmVG0/Fnkq9Z"


--=-Oaxe21t1rmVG0/Fnkq9Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-27 at 03:11 -0800, Jeremy Huddleston wrote:
> A change between 2.6.7-rc1-bk6 and 2.6.7-rc2 can results in a system
> lockdown.  One situation in which this can be triggered is when we are a
> nfs client, and the nfs server shuts down (or on the server, you simply
> issue an 'ifconfig eth1 down').  I have tracked this down to a bug in
> dev_ifconf() in fs/compat_ioctl.c

Ok, well I've cleaned up the patch a bit to be less intrusive, but the
functionality is still pretty much the same (reverted to pre 2.6.7-rc2).

I've rattled my brain with it, but for the life of me, I don't see why
the >=3D2.6.7-rc2 approach breaks...  I've added some debugging printk's,
and all I've really discovered is that when the server goes down, the
client's dev_ifconf() gets called every few seconds until it goes back
up... and the ifc.ifc_len=3D11040

The 11K isn't enough to overflow the stack, with the
compat_alloc_user_space()...

copy_in_user() is fine...

The overlying logic is identical except that we use the user stack
instead of kmalloc() and don't switch to KERNEL_DS, so what gives?
Anybody?  I'm ready to just give up and use this patch as is, but I'd
like to figure out the root of this...

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-Oaxe21t1rmVG0/Fnkq9Z
Content-Disposition: attachment; filename=dev_ifconf.revert.nfslockup.patch
Content-Type: text/x-patch; name=dev_ifconf.revert.nfslockup.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi43LWdlbnRvby1yMTUvZnMvY29tcGF0X2lvY3RsLmMJMjAwNC0xMS0yNyAx
Njo0NTo0NS4wMDAwMDAwMDAgLTA4MDANCisrKyBsaW51eC0yLjYuNy1nZW50b28tcjE2L2ZzL2Nv
bXBhdF9pb2N0bC5jCTIwMDQtMTEtMjggMDI6NTg6NDQuNDEzMDY3Njk5IC0wODAwDQpAQCAtNDk1
LDExICs0OTUsMTEgQEAgc3RhdGljIGludCBkZXZfaWZjb25mKHVuc2lnbmVkIGludCBmZCwgdQ0K
IHsNCiAJc3RydWN0IGlmY29uZjMyIGlmYzMyOw0KIAlzdHJ1Y3QgaWZjb25mIGlmYzsNCi0Jc3Ry
dWN0IGlmY29uZiBfX3VzZXIgKnVpZmM7DQogCXN0cnVjdCBpZnJlcTMyIF9fdXNlciAqaWZyMzI7
DQotCXN0cnVjdCBpZnJlcSBfX3VzZXIgKmlmcjsNCisJc3RydWN0IGlmcmVxICppZnI7DQorCW1t
X3NlZ21lbnRfdCBvbGRfZnM7DQogCXVuc2lnbmVkIGludCBpLCBqOw0KLQlpbnQgZXJyOw0KKwlp
bnQgZXJyID0gMDsNCiANCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZpZmMzMiwgY29tcGF0X3B0cihh
cmcpLCBzaXplb2Yoc3RydWN0IGlmY29uZjMyKSkpDQogCQlyZXR1cm4gLUVGQVVMVDsNCkBAIC01
MDgsMzcgKzUwOCw0NiBAQCBzdGF0aWMgaW50IGRldl9pZmNvbmYodW5zaWduZWQgaW50IGZkLCB1
DQogCQlpZmMzMi5pZmNfbGVuID0gMDsNCiAJCWlmYy5pZmNfbGVuID0gMDsNCiAJCWlmYy5pZmNf
cmVxID0gTlVMTDsNCi0JCXVpZmMgPSBjb21wYXRfYWxsb2NfdXNlcl9zcGFjZShzaXplb2Yoc3Ry
dWN0IGlmY29uZikpOw0KIAl9IGVsc2Ugew0KIAkJc2l6ZV90IGxlbiA9KChpZmMzMi5pZmNfbGVu
IC8gc2l6ZW9mIChzdHJ1Y3QgaWZyZXEzMikpICsgMSkgKg0KIAkJCXNpemVvZiAoc3RydWN0IGlm
cmVxKTsNCi0JCXVpZmMgPSBjb21wYXRfYWxsb2NfdXNlcl9zcGFjZShzaXplb2Yoc3RydWN0IGlm
Y29uZikgKyBsZW4pOw0KIAkJaWZjLmlmY19sZW4gPSBsZW47DQotCQlpZnIgPSBpZmMuaWZjX3Jl
cSA9ICh2b2lkIF9fdXNlciAqKSh1aWZjICsgMSk7DQorDQorCQkvKiBOT1RFOiBVc2luZyBjb21w
YXRfYWxsb2NfdXNlcl9zcGFjZSgpIGFuZCBjYWxsaW5nIHN5c19pb2N0bCgpDQorCQkgKiB3aXRo
b3V0IGZpcnN0IGVudGVyaW5nIEtFUk5FTF9EUyBmb3Igc29tZSByZWFzb24gY2F1c2VzIGENCisJ
CSAqIGxvY2t1cCBvbiBzcGFyYzY0IC1KZXJlbXkgSHVkZGxlc3RvbiA8ZXJhZGljYXRvckBnZW50
b28ub3JnPg0KKwkJICovDQorCQlpZmMuaWZjX2J1ZiA9IGttYWxsb2MgKGxlbiwgR0ZQX0tFUk5F
TCk7DQorCQlpZiAoIWlmYy5pZmNfYnVmKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KKw0KKwkJaWZy
ID0gaWZjLmlmY19yZXE7DQogCQlpZnIzMiA9IGNvbXBhdF9wdHIoaWZjMzIuaWZjYnVmKTsNCiAJ
CWZvciAoaSA9IDA7IGkgPCBpZmMzMi5pZmNfbGVuOyBpICs9IHNpemVvZiAoc3RydWN0IGlmcmVx
MzIpKSB7DQotCQkJaWYgKGNvcHlfaW5fdXNlcihpZnIsIGlmcjMyLCBzaXplb2Yoc3RydWN0IGlm
cmVxMzIpKSkNCi0JCQkJcmV0dXJuIC1FRkFVTFQ7DQorCQkJaWYgKGNvcHlfZnJvbV91c2VyKGlm
ciwgaWZyMzIsIHNpemVvZihzdHJ1Y3QgaWZyZXEzMikpKSB7DQorCQkJCWVyciA9IC1FRkFVTFQ7
DQorCQkJCWdvdG8gX19kZXZfaWZjb25mX2V4aXQ7DQorCQkJfQ0KIAkJCWlmcisrOw0KIAkJCWlm
cjMyKys7IA0KIAkJfQ0KIAl9DQotCWlmIChjb3B5X3RvX3VzZXIodWlmYywgJmlmYywgc2l6ZW9m
KHN0cnVjdCBpZmNvbmYpKSkNCi0JCXJldHVybiAtRUZBVUxUOw0KIA0KLQllcnIgPSBzeXNfaW9j
dGwgKGZkLCBTSU9DR0lGQ09ORiwgKHVuc2lnbmVkIGxvbmcpdWlmYyk7CQ0KLQlpZiAoZXJyKQ0K
LQkJcmV0dXJuIGVycjsNCisJb2xkX2ZzID0gZ2V0X2ZzKCk7IHNldF9mcyAoS0VSTkVMX0RTKTsN
CisJZXJyID0gc3lzX2lvY3RsIChmZCwgU0lPQ0dJRkNPTkYsICh1bnNpZ25lZCBsb25nKSZpZmMp
OwkNCisJc2V0X2ZzIChvbGRfZnMpOw0KIA0KLQlpZiAoY29weV9mcm9tX3VzZXIoJmlmYywgdWlm
Yywgc2l6ZW9mKHN0cnVjdCBpZmNvbmYpKSkgDQotCQlyZXR1cm4gLUVGQVVMVDsNCisJaWYoZXJy
KQ0KKwkJZ290byBfX2Rldl9pZmNvbmZfZXhpdDsNCiANCiAJaWZyID0gaWZjLmlmY19yZXE7DQog
CWlmcjMyID0gY29tcGF0X3B0cihpZmMzMi5pZmNidWYpOw0KIAlmb3IgKGkgPSAwLCBqID0gMDsg
aSA8IGlmYzMyLmlmY19sZW4gJiYgaiA8IGlmYy5pZmNfbGVuOw0KIAkgICAgIGkgKz0gc2l6ZW9m
IChzdHJ1Y3QgaWZyZXEzMiksIGogKz0gc2l6ZW9mIChzdHJ1Y3QgaWZyZXEpKSB7DQotCQlpZiAo
Y29weV9pbl91c2VyKGlmcjMyLCBpZnIsIHNpemVvZiAoc3RydWN0IGlmcmVxMzIpKSkNCi0JCQly
ZXR1cm4gLUVGQVVMVDsNCisJCWlmIChjb3B5X3RvX3VzZXIoaWZyMzIsIGlmciwgc2l6ZW9mIChz
dHJ1Y3QgaWZyZXEzMikpKSB7DQorCQkJZXJyID0gLUVGQVVMVDsNCisJCQlnb3RvIF9fZGV2X2lm
Y29uZl9leGl0Ow0KKwkJfQ0KIAkJaWZyMzIrKzsNCiAJCWlmcisrOw0KIAl9DQpAQCAtNTU3LDkg
KzU2NiwxMiBAQCBzdGF0aWMgaW50IGRldl9pZmNvbmYodW5zaWduZWQgaW50IGZkLCB1DQogCQkJ
aWZjMzIuaWZjX2xlbiA9IGkgLSBzaXplb2YgKHN0cnVjdCBpZnJlcTMyKTsNCiAJfQ0KIAlpZiAo
Y29weV90b191c2VyKGNvbXBhdF9wdHIoYXJnKSwgJmlmYzMyLCBzaXplb2Yoc3RydWN0IGlmY29u
ZjMyKSkpDQotCQlyZXR1cm4gLUVGQVVMVDsNCisJCWVyciA9IC1FRkFVTFQ7DQogDQotCXJldHVy
biAwOw0KKwlfX2Rldl9pZmNvbmZfZXhpdDoNCisJaWYoaWZjLmlmY19idWYgIT0gTlVMTCkNCisJ
CWtmcmVlIChpZmMuaWZjX2J1Zik7DQorCXJldHVybiBlcnI7DQogfQ0KIA0KIHN0YXRpYyBpbnQg
ZXRodG9vbF9pb2N0bCh1bnNpZ25lZCBpbnQgZmQsIHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVk
IGxvbmcgYXJnKQ0K


--=-Oaxe21t1rmVG0/Fnkq9Z--

--=-yXUEoreIW+Nmk4KIhrZg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBqb14OpjtAl+gMRURAh/cAJ9mrDqKBL3M+G0Bj18ayLeoeY+0fACgv+0P
XB3SAisc9/sJyZG6DmFYyjY=
=0nDt
-----END PGP SIGNATURE-----

--=-yXUEoreIW+Nmk4KIhrZg--

