From: Jurij Smakov <jurij@wooyd.org>
Date: Thu, 10 Mar 2005 02:39:39 +0000
Subject: Sunsab serial console problems - partially solved
Message-Id: <Pine.LNX.4.61.0503092118230.2897@bobcat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463804416-198694600-1110422379=:2897"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804416-198694600-1110422379=:2897
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello,

For the last few days I have been trying to fix the problems with serial 
console on the machines with sunsab serial controller (I can reproduce 
them myself on my Ultra 5, another person reported similar issues on an 
Ultra 10). When booting a 2.6 kernel using serial console, some junk gets 
occasionally printed on it (see [0] and [1] for thescreenshots). Machine
also eventually hangs. After poking around a bit and comparing sunsab.c 
driver with the working sunzilog.c driver, I came up with the patch 
against 2.6.11 (attached), which takes care of the hang, but does not 
eliminate garbage on the console. I am pretty sure by now that this is a 
result of improper handling of the mode changes, as I see numerous calls 
to sunsab_set_mctrl() and sunsab_set_termios() right before and/or during 
the appearance of spurious symbols. As it is a little bit over my head, I 
hope someone more knowledgeable can give me a clue on how to debug this 
further.

[0] http://www.wooyd.org/misc/sunsab.1.png
[1] http://www.wooyd.org/misc/sunsab.2.png

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
---1463804416-198694600-1110422379=:2897
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sunsab-2.6.11.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="sunsab-2.6.11.patch"

ZGlmZiAtYXVyIGEvZHJpdmVycy9zZXJpYWwvc3Vuc2FiLmMgYi9kcml2ZXJz
L3NlcmlhbC9zdW5zYWIuYw0KLS0tIGEvZHJpdmVycy9zZXJpYWwvc3Vuc2Fi
LmMJMjAwNS0wMy0wMiAwMjozODowNy4wMDAwMDAwMDAgLTA1MDANCisrKyBi
L2RyaXZlcnMvc2VyaWFsL3N1bnNhYi5jCTIwMDUtMDMtMDkgMTk6NDQ6NTEu
MDAwMDAwMDAwIC0wNTAwDQpAQCAtMjk1LDIwICsyOTUsMjIgQEANCiBzdGF0
aWMgdm9pZCBjaGVja19zdGF0dXMoc3RydWN0IHVhcnRfc3Vuc2FiX3BvcnQg
KnVwLA0KIAkJCSB1bmlvbiBzYWI4MjUzMl9pcnFfc3RhdHVzICpzdGF0KQ0K
IHsNCi0JaWYgKHN0YXQtPnNyZWcuaXNyMCAmIFNBQjgyNTMyX0lTUjBfQ0RT
QykNCi0JCXVhcnRfaGFuZGxlX2RjZF9jaGFuZ2UoJnVwLT5wb3J0LA0KKwlp
ZiAodGVzdF9iaXQoU0FCODI1MzJfTU9ERU1fU1RBVFVTLCAmdXAtPmlycWZs
YWdzKSkgew0KKwkJaWYgKHN0YXQtPnNyZWcuaXNyMCAmIFNBQjgyNTMyX0lT
UjBfQ0RTQykNCisJCQl1YXJ0X2hhbmRsZV9kY2RfY2hhbmdlKCZ1cC0+cG9y
dCwNCiAJCQkJICAgICAgICEocmVhZGIoJnVwLT5yZWdzLT5yLnZzdHIpICYg
U0FCODI1MzJfVlNUUl9DRCkpOw0KIA0KLQlpZiAoc3RhdC0+c3JlZy5pc3Ix
ICYgU0FCODI1MzJfSVNSMV9DU0MpDQotCQl1YXJ0X2hhbmRsZV9jdHNfY2hh
bmdlKCZ1cC0+cG9ydCwNCisJCWlmIChzdGF0LT5zcmVnLmlzcjEgJiBTQUI4
MjUzMl9JU1IxX0NTQykNCisJCQl1YXJ0X2hhbmRsZV9jdHNfY2hhbmdlKCZ1
cC0+cG9ydCwNCiAJCQkJICAgICAgIChyZWFkYigmdXAtPnJlZ3MtPnIuc3Rh
cikgJiBTQUI4MjUzMl9TVEFSX0NUUykpOw0KIA0KLQlpZiAoKHJlYWRiKCZ1
cC0+cmVncy0+ci5wdnIpICYgdXAtPnB2cl9kc3JfYml0KSBeIHVwLT5kc3Ip
IHsNCi0JCXVwLT5kc3IgPSAocmVhZGIoJnVwLT5yZWdzLT5yLnB2cikgJiB1
cC0+cHZyX2Rzcl9iaXQpID8gMCA6IDE7DQotCQl1cC0+cG9ydC5pY291bnQu
ZHNyKys7DQotCX0NCisJCWlmICgocmVhZGIoJnVwLT5yZWdzLT5yLnB2cikg
JiB1cC0+cHZyX2Rzcl9iaXQpIF4gdXAtPmRzcikgew0KKwkJCXVwLT5kc3Ig
PSAocmVhZGIoJnVwLT5yZWdzLT5yLnB2cikgJiB1cC0+cHZyX2Rzcl9iaXQp
ID8gMCA6IDE7DQorCQkJdXAtPnBvcnQuaWNvdW50LmRzcisrOw0KKwkJfQ0K
IA0KLQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnVwLT5wb3J0LmluZm8tPmRl
bHRhX21zcl93YWl0KTsNCisJCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmdXAt
PnBvcnQuaW5mby0+ZGVsdGFfbXNyX3dhaXQpOw0KKwl9DQogfQ0KIA0KIHN0
YXRpYyBpcnFyZXR1cm5fdCBzdW5zYWJfaW50ZXJydXB0KGludCBpcnEsIHZv
aWQgKmRldl9pZCwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQpAQCAtNzg4LDYg
Kzc5MCwxMSBAQA0KIA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmdXAtPnBvcnQu
bG9jaywgZmxhZ3MpOw0KIAlzdW5zYWJfY29udmVydF90b19zYWIodXAsIHRl
cm1pb3MtPmNfY2ZsYWcsIHRlcm1pb3MtPmNfaWZsYWcsIGJhdWQpOw0KKyAg
ICAgICAgaWYgKFVBUlRfRU5BQkxFX01TKCZ1cC0+cG9ydCwgdGVybWlvcy0+
Y19jZmxhZykpDQorICAgICAgICAgICAgICAgIHNldF9iaXQoU0FCODI1MzJf
TU9ERU1fU1RBVFVTLCAmdXAtPmlycWZsYWdzKTsNCisgICAgICAgIGVsc2UN
CisgICAgICAgICAgICAgICAgY2xlYXJfYml0KFNBQjgyNTMyX01PREVNX1NU
QVRVUywgJnVwLT5pcnFmbGFncyk7DQorCXVhcnRfdXBkYXRlX3RpbWVvdXQo
cG9ydCwgdGVybWlvcy0+Y19jZmxhZywgYmF1ZCk7DQogCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnVwLT5wb3J0LmxvY2ssIGZsYWdzKTsNCiB9DQogDQpk
aWZmIC1hdXIgYS9kcml2ZXJzL3NlcmlhbC9zdW5zYWIuaCBiL2RyaXZlcnMv
c2VyaWFsL3N1bnNhYi5oDQotLS0gYS9kcml2ZXJzL3NlcmlhbC9zdW5zYWIu
aAkyMDA1LTAzLTAyIDAyOjM4OjMzLjAwMDAwMDAwMCAtMDUwMA0KKysrIGIv
ZHJpdmVycy9zZXJpYWwvc3Vuc2FiLmgJMjAwNS0wMy0wOSAxOTo0NDo1MS4w
MDAwMDAwMDAgLTA1MDANCkBAIC0xMjYsNiArMTI2LDcgQEANCiAvKiBpcnFm
bGFncyBiaXRzICovDQogI2RlZmluZSBTQUI4MjUzMl9BTExTCQkJMHgwMDAw
MDAwMQ0KICNkZWZpbmUgU0FCODI1MzJfWFBSCQkJMHgwMDAwMDAwMg0KKyNk
ZWZpbmUgU0FCODI1MzJfTU9ERU1fU1RBVFVTCQkweDAwMDAwMDA0DQogDQog
LyogUkZJRk8gU3RhdHVzIEJ5dGUgKi8NCiAjZGVmaW5lIFNBQjgyNTMyX1JT
VEFUX1BFCQkweDgwDQo=

---1463804416-198694600-1110422379=:2897--
