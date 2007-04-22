From: "Marcel van Nies" <morcles@gmail.com>
Date: Sun, 22 Apr 2007 14:00:43 +0000
Subject: Re: QuadEthernet driver broken
Message-Id: <c75cfb180704220700t74b5eb18n9ed6178f85236943@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_156246_1227737.1177250443033"
List-Id: <sparclinux.vger.kernel.org>
References: <87lkgxgxvj.fsf@chbouib.org>
In-Reply-To: <87lkgxgxvj.fsf@chbouib.org>
To: sparclinux@vger.kernel.org

------=_Part_156246_1227737.1177250443033
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On 4/22/07, David Miller <davem@davemloft.net> wrote:
> Your email client adds newlines and other damage to your patches.
Hmm, I see :(
I used diff -u, but I should have used diff -up.  Gmail took care of the rest...

> I'll fix them up this time but next time I will likely not be so kind
> :-)
Thanks.

> If in doubt, email the patch to yourself and try to apply it.  This
> will save your time as well as mine.
Good point. I'm still learning...

I'll resend the patches as attachments.
Sorry for any inconvenience caused.

Signed-off-by: Marcel van Nies <morcles@gmail.com>

------=_Part_156246_1227737.1177250443033
Content-Type: application/octet-stream; 
	name=sunqe-fix-mac-addresses-and-module-unload.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0ti2kgm
Content-Disposition: attachment; filename="sunqe-fix-mac-addresses-and-module-unload.patch"

LS0tIGxpbnV4LTIuNi4yMS1yYzctZ2l0NS11cC9kcml2ZXJzL25ldC9zdW5xZS5jLm9yZwkyMDA3
LTAyLTA0IDE5OjQ0OjU0LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjIxLXJjNy1naXQ1
LXVwL2RyaXZlcnMvbmV0L3N1bnFlLmMJMjAwNy0wNC0yMSAyMDoxNTowOC4wMDAwMDAwMDAgKzAy
MDAKQEAgLTg0NSw2ICs4NDUsOCBAQCBzdGF0aWMgaW50IF9faW5pdCBxZWNfZXRoZXJfaW5pdChz
dHJ1Y3QgCiAJaWYgKCFkZXYpCiAJCXJldHVybiAtRU5PTUVNOwogCisJbWVtY3B5KGRldi0+ZGV2
X2FkZHIsIGlkcHJvbS0+aWRfZXRoYWRkciwgNik7CisKIAlxZSA9IG5ldGRldl9wcml2KGRldik7
CiAKIAlpID0gb2ZfZ2V0aW50cHJvcF9kZWZhdWx0KHNkZXYtPm9mZGV2Lm5vZGUsICJjaGFubmVs
IyIsIC0xKTsKQEAgLTk2MCw3ICs5NjIsNyBAQCBzdGF0aWMgaW50IF9fZGV2ZXhpdCBxZWNfc2J1
c19yZW1vdmUoc3RyCiAJc3RydWN0IHN1bnFlICpxcCA9IGRldl9nZXRfZHJ2ZGF0YSgmZGV2LT5k
ZXYpOwogCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRfZGV2ID0gcXAtPmRldjsKIAotCXVucmVnaXN0
ZXJfbmV0ZGV2aWNlKG5ldF9kZXYpOworCXVucmVnaXN0ZXJfbmV0ZGV2KG5ldF9kZXYpOwogCiAJ
c2J1c19pb3VubWFwKHFwLT5xY3JlZ3MsIENSRUdfUkVHX1NJWkUpOwogCXNidXNfaW91bm1hcChx
cC0+bXJlZ3MsIE1SRUdTX1JFR19TSVpFKTsK
------=_Part_156246_1227737.1177250443033
Content-Type: application/octet-stream; 
	name=sunlance-fix-module-unload.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0ti2yui
Content-Disposition: attachment; filename="sunlance-fix-module-unload.patch"

LS0tIGxpbnV4LTIuNi4yMS1yYzctZ2l0NS11cC9kcml2ZXJzL25ldC9zdW5sYW5jZS5jLm9yZwky
MDA3LTAyLTA0IDE5OjQ0OjU0LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42LjIxLXJjNy1n
aXQ1LXVwL2RyaXZlcnMvbmV0L3N1bmxhbmNlLmMJMjAwNy0wNC0yMSAxOTozNjo1Mi4wMDAwMDAw
MDAgKzAyMDAKQEAgLTE1NTAsNyArMTU1MCw3IEBAIHN0YXRpYyBpbnQgX19leGl0IHN1bmxhbmNl
X3N1bjRfcmVtb3ZlKHYKIAlzdHJ1Y3QgbGFuY2VfcHJpdmF0ZSAqbHAgPSBkZXZfZ2V0X2RydmRh
dGEoJnN1bjRfc2Rldi5vZmRldi5kZXYpOwogCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRfZGV2ID0g
bHAtPmRldjsKIAotCXVucmVnaXN0ZXJfbmV0ZGV2aWNlKG5ldF9kZXYpOworCXVucmVnaXN0ZXJf
bmV0ZGV2KG5ldF9kZXYpOwogCiAJbGFuY2VfZnJlZV9od3Jlc291cmNlcyhscCk7CiAKQEAgLTE1
OTAsNyArMTU5MCw3IEBAIHN0YXRpYyBpbnQgX19kZXZleGl0IHN1bmxhbmNlX3NidXNfcmVtb3YK
IAlzdHJ1Y3QgbGFuY2VfcHJpdmF0ZSAqbHAgPSBkZXZfZ2V0X2RydmRhdGEoJmRldi0+ZGV2KTsK
IAlzdHJ1Y3QgbmV0X2RldmljZSAqbmV0X2RldiA9IGxwLT5kZXY7CiAKLQl1bnJlZ2lzdGVyX25l
dGRldmljZShuZXRfZGV2KTsKKwl1bnJlZ2lzdGVyX25ldGRldihuZXRfZGV2KTsKIAogCWxhbmNl
X2ZyZWVfaHdyZXNvdXJjZXMobHApOwogCg==
------=_Part_156246_1227737.1177250443033
Content-Type: application/octet-stream; 
	name=sunhme-fix-sbus-module-unload.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0ti34s4
Content-Disposition: attachment; filename="sunhme-fix-sbus-module-unload.patch"

LS0tIGxpbnV4LTIuNi4yMS1yYzctZ2l0NS11cC9kcml2ZXJzL25ldC9zdW5obWUuYy5vcmcJMjAw
Ny0wMi0wNCAxOTo0NDo1NC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LTIuNi4yMS1yYzctZ2l0
NS11cC9kcml2ZXJzL25ldC9zdW5obWUuYwkyMDA3LTA0LTIxIDE5OjM2OjA5LjAwMDAwMDAwMCAr
MDIwMApAQCAtMzMxNCw3ICszMzE0LDcgQEAgc3RhdGljIGludCBfX2RldmV4aXQgaG1lX3NidXNf
cmVtb3ZlKHN0cgogCXN0cnVjdCBoYXBweV9tZWFsICpocCA9IGRldl9nZXRfZHJ2ZGF0YSgmZGV2
LT5kZXYpOwogCXN0cnVjdCBuZXRfZGV2aWNlICpuZXRfZGV2ID0gaHAtPmRldjsKIAotCXVucmVn
aXN0ZXJfbmV0ZGV2aWNlKG5ldF9kZXYpOworCXVucmVnaXN0ZXJfbmV0ZGV2KG5ldF9kZXYpOwog
CiAJLyogWFhYIHFmZSBwYXJlbnQgaW50ZXJydXB0Li4uICovCiAK
------=_Part_156246_1227737.1177250443033--
