From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 16 Apr 2005 07:10:17 +0000
Subject: Problem with copy_siginfo_to_user32()
Message-Id: <Pine.LNX.4.61.0504160233090.5720@bobcat>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463804416-1150893954-1113635417=:5720"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804416-1150893954-1113635417=:5720
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hello,

In Debian's bug 272683 [0] submitter describes incorrect behavior of the 
F_NOTIFY function of fcntl(), which reports the wrong number of the 
file descriptor, on which the event has occured. I believe that the 
culprit in this case is the copy_siginfo_to_user32() function in 
arch/sparc64/kernel/signal32.c. Comparison with other arches (like
ppc64), shows that the __SI_POLL branch in the case statement should 
fill out the si_band and si_fd fields of the siginfo_t structure (si_fd is 
used by fcntl() to pass the fd number back to user). Currently it does not 
do that. Attached patch (against 2.6.11.7) separates __SI_FAULT and 
__SI_POLL branches and does (presumably) the right thing in the latter by 
copying the si_band and si_fd into the siginfo_t passed to user. With this 
change the test program attached to the bug [0] works as expected (tested 
on 2.6.8, against which the original bug was filed).

Please review and apply if it makes sense :-).

[0] http://bugs.debian.org/272683

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
---1463804416-1150893954-1113635417=:5720
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sparc64_sigpoll-2.6.11.7.patch"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="sparc64_sigpoll-2.6.11.7.patch"

LS0tIGEvYXJjaC9zcGFyYzY0L2tlcm5lbC9zaWduYWwzMi5jCTIwMDUtMDQt
MDcgMTQ6NTg6NDIuMDAwMDAwMDAwIC0wNDAwDQorKysgYi9hcmNoL3NwYXJj
NjQva2VybmVsL3NpZ25hbDMyLmMJMjAwNS0wNC0xNiAwMzowMTowMC4xNjIz
MDA2MzIgLTA0MDANCkBAIC0xOTIsMTAgKzE5MiwxMyBAQA0KIAkJCWVyciB8
PSBfX3B1dF91c2VyKGZyb20tPnNpX3VpZCwgJnRvLT5zaV91aWQpOw0KIAkJ
CWJyZWFrOw0KIAkJY2FzZSBfX1NJX0ZBVUxUID4+IDE2Og0KLQkJY2FzZSBf
X1NJX1BPTEwgPj4gMTY6DQogCQkJZXJyIHw9IF9fcHV0X3VzZXIoZnJvbS0+
c2lfdHJhcG5vLCAmdG8tPnNpX3RyYXBubyk7DQogCQkJZXJyIHw9IF9fcHV0
X3VzZXIoKHVuc2lnbmVkIGxvbmcpZnJvbS0+c2lfYWRkciwgJnRvLT5zaV9h
ZGRyKTsNCiAJCQlicmVhazsNCisJCWNhc2UgX19TSV9QT0xMID4+IDE2Og0K
KwkJCWVyciB8PSBfX3B1dF91c2VyKGZyb20tPnNpX2JhbmQsICZ0by0+c2lf
YmFuZCk7DQorCQkJZXJyIHw9IF9fcHV0X3VzZXIoZnJvbS0+c2lfZmQsICZ0
by0+c2lfZmQpOw0KKwkJCWJyZWFrOw0KIAkJY2FzZSBfX1NJX1JUID4+IDE2
OiAvKiBUaGlzIGlzIG5vdCBnZW5lcmF0ZWQgYnkgdGhlIGtlcm5lbCBhcyBv
ZiBub3cuICAqLw0KIAkJY2FzZSBfX1NJX01FU0dRID4+IDE2Og0KIAkJCWVy
ciB8PSBfX3B1dF91c2VyKGZyb20tPnNpX3BpZCwgJnRvLT5zaV9waWQpOw0K

---1463804416-1150893954-1113635417=:5720--
