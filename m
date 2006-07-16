From: Raymond Burns <rayburns@comcast.net>
Date: Sun, 16 Jul 2006 03:31:25 +0000
Subject: sparc32 git tree, preamble scan_one_device
Message-Id: <Pine.LNX.4.10.10607152010260.10727-200000@coalcreekmill.cm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="279707904-648472730-1153020685=:10727"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707904-648472730-1153020685=:10727
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi

The attached patch avoids access past null for the sun4d. This does
not impact the kobject_add failed issue.

Minor restructure of the parent determination would simplify the code,
the sun4d should never have an sbi at the root node.

This gets me up to the kobject_add issue  ugh

Thanx
  Ray


--279707904-648472730-1153020685=:10727
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch_scan_one_device_sun4d_prom
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10607152031250.10727@coalcreekmill.cm.com>
Content-Description: patch scan_one_device sun4d prom
Content-Disposition: attachment; filename=patch_scan_one_device_sun4d_prom

ZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMva2VybmVsL29mX2RldmljZS5jIGIv
YXJjaC9zcGFyYy9rZXJuZWwvb2ZfZGV2aWNlLmMNCmluZGV4IGJiZDMyMDMu
LjVkNDFhNTUgMTAwNjQ0DQotLS0gYS9hcmNoL3NwYXJjL2tlcm5lbC9vZl9k
ZXZpY2UuYw0KKysrIGIvYXJjaC9zcGFyYy9rZXJuZWwvb2ZfZGV2aWNlLmMN
CkBAIC01NTksMTcgKzU1OSwxNyBAQCBzdGF0aWMgc3RydWN0IG9mX2Rldmlj
ZSAqIF9faW5pdCBzY2FuX29uDQogCQl9Ow0KIAkJc3RydWN0IGRldmljZV9u
b2RlICpidXNwID0gZHAtPnBhcmVudDsNCiAJCXN0cnVjdCBsaW51eF9wcm9t
X3JlZ2lzdGVycyAqcmVnczsNCi0JCWludCBib2FyZCA9IG9mX2dldGludHBy
b3BfZGVmYXVsdChidXNwLCAiYm9hcmQjIiwgMCk7DQotCQlpbnQgc2xvdDsN
CisJCWludCBib2FyZCwgc2xvdDsNCiANCisJCWlmIChidXNwKSBib2FyZCA9
IG9mX2dldGludHByb3BfZGVmYXVsdChidXNwLCAiYm9hcmQjIiwgMCk7DQog
CQlyZWdzID0gb2ZfZ2V0X3Byb3BlcnR5KGRwLCAicmVnIiwgTlVMTCk7DQot
CQlzbG90ID0gcmVncy0+d2hpY2hfaW87DQorCQlpZiAocmVncykgc2xvdCA9
IHJlZ3MtPndoaWNoX2lvOw0KIA0KIAkJZm9yIChpID0gMDsgaSA8IG9wLT5u
dW1faXJxczsgaSsrKSB7DQogCQkJaW50IHRoaXNfaXJxID0gb3AtPmlycXNb
aV07DQogCQkJaW50IHNidXNsID0gcGlsX3RvX3NidXNbdGhpc19pcnFdOw0K
IA0KLQkJCWlmIChzYnVzbCkNCisJCQlpZiAoYnVzcCAmJiByZWdzICYmIHNi
dXNsKQ0KIAkJCQl0aGlzX2lycSA9ICgoKGJvYXJkICsgMSkgPDwgNSkgKw0K
IAkJCQkJICAgIChzYnVzbCA8PCAyKSArDQogCQkJCQkgICAgc2xvdCk7DQo=
--279707904-648472730-1153020685=:10727--
