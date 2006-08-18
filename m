From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 18 Aug 2006 17:32:54 +0000
Subject: Re: [PATCH] sunlance probing problem
Message-Id: <44e5f9c66eac3@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44e5f9c6711d9"
List-Id: <sparclinux.vger.kernel.org>
References: <44dcfea4406f9@wp.pl>
In-Reply-To: <44dcfea4406f9@wp.pl>
To: sparclinux@vger.kernel.org

<ec7cefb0608111611v82ad973hf1650b184536001b@mail.gmail.com>
<44ddd5b780824@wp.pl> <20060817.181056.71088906.davem@davemloft.net>
In-reply-to: <44dcfea4406f9@wp.pl>
<ec7cefb0608111611v82ad973hf1650b184536001b@mail.gmail.com>
<44ddd5b780824@wp.pl> <20060817.181056.71088906.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="part44e5f9c6711d9"
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-WP-IP: 213.76.92.125
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.504504) AS3=NO AS4=NO AS5=NO                                                             

This is a multi-part message in MIME format.

--part44e5f9c6711d9
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



Dnia 18-08-2006 o godz. 3:10 David Miller napisa=B3(a):
> If you return "0" as the error, the caller in the device
probing layer
> grabs a reference to the device which will be a leak of the
undelying
> of_device object.
>=20
> A better way to fix this is probably to only match "le" and have
> the probe code check the device parent for "ledma" or "lebuffer".
> You should be able to confine all of your changes to the probe
> match table and sunlance_sbus_probe().
>=20
> Could you implement it like that and give it a test?
>=20
> Thanks.
>=20

This is a tested patch according to your sugestions  (as far as=20
I understood them).

Regards,
Krzysztof
PS. Forget the previous patch. It is incorrect if "le" is standalone.

----------------------------------------------------
Najnowsze odkrycie =B6wiatowej muzyki- smacznej i snobistycznej.
Wschodz=B1ca gwiazda, wybitnie utalentowana Sophie Solomon
wraz z zespo=B3em w Warszawie!!
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fsophie_solom=
on_w_fabryce_trzciny.html&sid=3D846

--part44e5f9c6711d9
Content-Type: application/octet-stream; name="lance-id.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lance-id.patch"

LS0tIGxpbnV4LTIuNi4xNy9kcml2ZXJzL25ldC9zdW5sYW5jZS5jCTIwMDYtMDgtMTAgMDg6MjM6
MzAuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTdhL2RyaXZlcnMvbmV0L3N1bmxhbmNl
LmMJMjAwNi0wOC0xOCAxOTowMzoxMC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE1NjYsMjAgKzE1NjYs
MjEgQEAgc3RhdGljIGludCBfX2V4aXQgc3VubGFuY2Vfc3VuNF9yZW1vdmUodgogc3RhdGljIGlu
dCBfX2RldmluaXQgc3VubGFuY2Vfc2J1c19wcm9iZShzdHJ1Y3Qgb2ZfZGV2aWNlICpkZXYsIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoKQogewogCXN0cnVjdCBzYnVzX2RldiAqc2Rl
diA9IHRvX3NidXNfZGV2aWNlKCZkZXYtPmRldik7Ci0Jc3RydWN0IGRldmljZV9ub2RlICpkcCA9
IGRldi0+bm9kZTsKIAlpbnQgZXJyOwogCi0JaWYgKCFzdHJjbXAoZHAtPm5hbWUsICJsZSIpKSB7
Ci0JCWVyciA9IHNwYXJjX2xhbmNlX3Byb2JlX29uZShzZGV2LCBOVUxMLCBOVUxMKTsKLQl9IGVs
c2UgaWYgKCFzdHJjbXAoZHAtPm5hbWUsICJsZWRtYSIpKSB7Ci0JCXN0cnVjdCBzYnVzX2RtYSAq
bGVkbWEgPSBmaW5kX2xlZG1hKHNkZXYpOworCWlmIChzZGV2LT5wYXJlbnQpIHsKKwkJc3RydWN0
IG9mX2RldmljZSAqcGFyZW50ID0gJnNkZXYtPnBhcmVudC0+b2ZkZXY7CiAKLQkJZXJyID0gc3Bh
cmNfbGFuY2VfcHJvYmVfb25lKHNkZXYtPmNoaWxkLCBsZWRtYSwgTlVMTCk7Ci0JfSBlbHNlIHsK
LQkJQlVHX09OKHN0cmNtcChkcC0+bmFtZSwgImxlYnVmZmVyIikpOworCQlpZiAoIXN0cmNtcChw
YXJlbnQtPm5vZGUtPm5hbWUsICJsZWRtYSIpKSB7CisJCQlzdHJ1Y3Qgc2J1c19kbWEgKmxlZG1h
ID0gZmluZF9sZWRtYSh0b19zYnVzX2RldmljZSgmcGFyZW50LT5kZXYpKTsKIAotCQllcnIgPSBz
cGFyY19sYW5jZV9wcm9iZV9vbmUoc2Rldi0+Y2hpbGQsIE5VTEwsIHNkZXYpOwotCX0KKwkJCWVy
ciA9IHNwYXJjX2xhbmNlX3Byb2JlX29uZShzZGV2LCBsZWRtYSwgTlVMTCk7CisJCX0gZWxzZSBp
ZiAoIXN0cmNtcChwYXJlbnQtPm5vZGUtPm5hbWUsICJsZWJ1ZmZlciIpKSB7CisJCQllcnIgPSBz
cGFyY19sYW5jZV9wcm9iZV9vbmUoc2RldiwgTlVMTCwgdG9fc2J1c19kZXZpY2UoJnBhcmVudC0+
ZGV2KSk7CisJCX0gZWxzZQorCQkJZXJyID0gc3BhcmNfbGFuY2VfcHJvYmVfb25lKHNkZXYsIE5V
TEwsIE5VTEwpOworCX0gZWxzZQorCQllcnIgPSBzcGFyY19sYW5jZV9wcm9iZV9vbmUoc2Rldiwg
TlVMTCwgTlVMTCk7CiAKIAlyZXR1cm4gZXJyOwogfQpAQCAtMTYwNCwxMiArMTYwNSw2IEBAIHN0
YXRpYyBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHN1bmxhbmNlX3NidXMKIAl7CiAJCS5uYW1lID0gImxl
IiwKIAl9LAotCXsKLQkJLm5hbWUgPSAibGVkbWEiLAotCX0sCi0JewotCQkubmFtZSA9ICJsZWJ1
ZmZlciIsCi0JfSwKIAl7fSwKIH07CiAK

--part44e5f9c6711d9--


