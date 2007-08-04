From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 04 Aug 2007 14:28:26 +0000
Subject: [PATCH] Fix Sparc32 Build
Message-Id: <Pine.LNX.4.61.0708041525230.24119@mtfhpc.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1750305931-449497145-1186237706=:24119"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1750305931-449497145-1186237706=:24119
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi David,

asm-generic/fcntl.h is needed in asm-sparc/fcntl.h.

The #defines in asm-generic/fcntl.h are protected with #if's so will not 
override thoes in asm-sparc/fcntl.h

Regards
 	Mark Fortescue.
--1750305931-449497145-1186237706=:24119
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fcntl.fix"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0708041528250.24119@mtfhpc.demon.co.uk>
Content-Description: 
Content-Disposition: attachment; filename="fcntl.fix"

RnJvbTogTWFyayBGb3J0ZXNjdWUgPG1hcmtAbXRmaHBjLmRlbW9uLmNvLnVr
Pg0KDQpDb3JyZWN0IGluY29ycmVjdCByZW1vdmFsIG9mIGFzbS1nZW5lcmlj
L2ZjbnRsLmggZnJvbSBhc20tc3BhcmMvZmNudGwuaCBieSANCmNvbW1pdCA2
YmE2MGQyMTk1Y2Q2NWQ3MmVhZjdjZTM5MDNhNzA3YzViZjIwYzdiLg0KDQpT
aWduZWQtb2ZmLWJ5OiBNYXJrIEZvcnRlc2N1ZSA8bWFya0BtdGZocGMuZGVt
b24uY28udWs+DQotLS0NCi0tLSBsaW51eC0yLjYvaW5jbHVkZS9hc20tc3Bh
cmMvZmNudGwuaAkyMDA3LTA4LTA0IDE0OjQwOjQ1LjAwMDAwMDAwMCArMDEw
MA0KKysrIGxpbnV4LXRlc3QvaW5jbHVkZS9hc20tc3BhcmMvZmNudGwuaAky
MDA3LTA4LTA0IDE1OjE4OjMyLjAwMDAwMDAwMCArMDEwMA0KQEAgLTMyLDUg
KzMyLDYgQEANCiAjZGVmaW5lIF9fQVJDSF9GTE9DS19QQUQJc2hvcnQgX191
bnVzZWQ7DQogI2RlZmluZSBfX0FSQ0hfRkxPQ0s2NF9QQUQJc2hvcnQgX191
bnVzZWQ7DQogDQorI2luY2x1ZGUgPGFzbS1nZW5lcmljL2ZjbnRsLmg+DQog
DQogI2VuZGlmDQo=

--1750305931-449497145-1186237706=:24119--
