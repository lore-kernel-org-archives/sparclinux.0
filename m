From: Eric Brower <ebrower@gmail.com>
Date: Wed, 10 Nov 2004 22:51:07 +0000
Subject: [PATCH] remove unnecessary pm_idle comment
Message-Id: <ec7cefb04111014511a1326a3@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_393_2483895.1100127067898"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

------=_Part_393_2483895.1100127067898
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a trivial matter, but we ought to remove the 2.6 kernel
comments that indicate confusion over the conditional use of pm_idle
in process.c-- systems with APC or PMC (basically, SS4/5 and Voyager)
have the ability to idle the CPU and do so.  Please see
.../kernel/apc.c or pmc.c for details.

Please review attached patch-- no need for confusion.

Thanks,
E

------=_Part_393_2483895.1100127067898
Content-Type: application/octet-stream; name="pm_idle_comment.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pm_idle_comment.patch"

LS0tIGFyY2gvc3BhcmMva2VybmVsL3Byb2Nlc3MuYy5vcmlnCTIwMDQtMTEtMDggMjA6MzA6NTQu
MDAwMDAwMDAwIC0wODAwCisrKyBhcmNoL3NwYXJjL2tlcm5lbC9wcm9jZXNzLmMJMjAwNC0xMS0x
MCAxMzo1ODozOC4wMDAwMDAwMDAgLTA4MDAKQEAgLTQ1LDcgKzQ1LDcgQEAKIAogLyogCiAgKiBQ
b3dlciBtYW5hZ2VtZW50IGlkbGUgZnVuY3Rpb24gCi0gKiBTZXQgaW4gcG0gcGxhdGZvcm0gZHJp
dmVycworICogU2V0IGluIHBtIHBsYXRmb3JtIGRyaXZlcnMgKGFwYy5jIGFuZCBwbWMuYykKICAq
Lwogdm9pZCAoKnBtX2lkbGUpKHZvaWQpOwogCkBAIC0xMjIsNyArMTIyLDcgQEAKIAkJfQogCiAJ
CXdoaWxlKCghbmVlZF9yZXNjaGVkKCkpICYmIHBtX2lkbGUpIHsKLQkJCSgqcG1faWRsZSkoKTsJ
CS8qIFhYWCBIdWg/IE9uIHNwYXJjPyEgKi8KKwkJCSgqcG1faWRsZSkoKTsKIAkJfQogCiAJCXNj
aGVkdWxlKCk7Cg==
------=_Part_393_2483895.1100127067898--
