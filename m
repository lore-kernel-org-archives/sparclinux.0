From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Thu, 24 Aug 2006 20:44:51 +0000
Subject: [PATCH] sparc32: enabling of the 2nd CPU in 2.6.18-rc4
Message-Id: <44ee0fc356c3e@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part44ee0fc35bab9"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part44ee0fc35bab9
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

From: Krzysztof Helt (krzysztof.h1@wp.pl)

This is smp_setup_cpu_possible_map() move after the patch did by
davem to sparc64.

Signed-off-by: Krzysztof Helt (krzysztof.h1@wp.pl)
---
This boots up the second CPU on my SS20. It is diff-ed agains
2.6.18-rc4 kernel, so maybe it was already posted by someone.

Regards,
Krzysztof


----------------------------------------------------
Games Convention Lipsk 23-27.08.2006 - Nie mo=BFesz tam by=E6?
Zobacz relacje na =BFywo:
http://klik.wp.pl/?adr=3Dwww.gc2006.gry.wp.pl&sid=3D852

--part44ee0fc35bab9
Content-Type: application/octet-stream; name="sparc32-smp-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparc32-smp-fix.diff"

LS0tIGxpbnV4LTIuNi4xNy9hcmNoL3NwYXJjL2tlcm5lbC9zZXR1cC5jCTIwMDYtMDgtMDkgMjM6
MTI6NTMuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTdzbXAvYXJjaC9zcGFyYy9rZXJu
ZWwvc2V0dXAuYwkyMDA2LTA4LTI0IDIyOjEzOjU2LjAwMDAwMDAwMCArMDIwMApAQCAtMzQ4LDkg
KzM0OCw5IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hhciAqKmNtZGxpbmVfcCkKIAlpbml0
X21tLmNvbnRleHQgPSAodW5zaWduZWQgbG9uZykgTk9fQ09OVEVYVDsKIAlpbml0X3Rhc2sudGhy
ZWFkLmtyZWdzID0gJmZha2Vfc3dhcHBlcl9yZWdzOwogCi0Jc21wX3NldHVwX2NwdV9wb3NzaWJs
ZV9tYXAoKTsKLQogCXBhZ2luZ19pbml0KCk7CisKKwlzbXBfc2V0dXBfY3B1X3Bvc3NpYmxlX21h
cCgpOwogfQogCiBzdGF0aWMgaW50IF9faW5pdCBzZXRfcHJlZmVycmVkX2NvbnNvbGUodm9pZCkK

--part44ee0fc35bab9--


