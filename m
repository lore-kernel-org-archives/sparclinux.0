From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Wed, 26 Jan 2005 08:24:42 +0000
Subject: FPU context switching fix for SMP
Message-Id: <41f753cabb795@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="part41f753cac058d"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.

--part41f753cac058d
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Here is a patch for FPU context switching in SMP.

A copy_thread() function clears PF_USEDFPU flag for a new thread,
but it does not clear the PSR_EF bit. Thus, a first FPU exception
called from the child thread is not handled properly. I made the
patch after PPC and MIPS architectures - both clear a similar bit
in copy_thread.
This bug does not exist in the UP kernel, probably because it
does not rely on PF_USEDFPU flag.

The patch below should be applied for both 2.4 and 2.6 branches.

I tested it with a test-fenv program from  glibc testsuite. The
test fails the same test cases in both SMP and UP with  the patch
applied. Without the patch, the test on SMP kernel failes in
almost two times more testcases.

Regards,
Krzysztof

----------------------------------------------------
Reklama Twojej strony WWW ju=BF od 20 groszy? - Oczywi=B6cie!
To nie jest =BFadna =B6ciema! - Sprawd=BC:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fbiznes.szukaj.wp.pl%2Fboksy.html&sid=
=3D299

--part41f753cac058d
Content-Type: application/octet-stream; name="copy_thread-fpu.24.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="copy_thread-fpu.24.patch"

LS0tIGxpbnV4LTIuNC4yOS9hcmNoL3NwYXJjL2tlcm5lbC9wcm9jZXNzLmMub3JpZwkyMDA1LTAx
LTI2IDA4OjM4OjAxLjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi40LjI5L2FyY2gvc3BhcmMv
a2VybmVsL3Byb2Nlc3MuYwkyMDA1LTAxLTI2IDA4OjM4OjU0LjAwMDAwMDAwMCArMDEwMApAQCAt
Myw2ICszLDggQEAKICAqCiAgKiAgQ29weXJpZ2h0IChDKSAxOTk1IERhdmlkIFMuIE1pbGxlciAo
ZGF2ZW1AY2FpcC5ydXRnZXJzLmVkdSkKICAqICBDb3B5cmlnaHQgKEMpIDE5OTYgRWRkaWUgQy4g
RG9zdCAgIChlY2RAc2t5bmV0LmJlKQorICoKKyAqCTIwMDUtMDEtMjYJS3J6eXN6dG9mIEhlbHQJ
LQljbGVhcmVkIFBTUl9FRiBpbiBjb3B5X3RocmVhZAogICovCiAKIC8qCkBAIC01MTIsNiArNTE0
LDEwIEBACiAJCX0KIAl9CiAKKyAgCS8qIEZQVSBtdXN0IGJlIGRpc2FibGVkIGluIFNNUC4gKi8K
KyAgCS8qIEl0IGRvZXMgbm90IGh1cnQgaW4gVVAgZWl0aGVyLiAqLworICAJY2hpbGRyZWdzLT5w
c3IgJj0gflBTUl9FRjsKKyAgCiAJLyogU2V0IHRoZSByZXR1cm4gdmFsdWUgZm9yIHRoZSBjaGls
ZC4gKi8KIAljaGlsZHJlZ3MtPnVfcmVnc1tVUkVHX0kwXSA9IGN1cnJlbnQtPnBpZDsKIAljaGls
ZHJlZ3MtPnVfcmVnc1tVUkVHX0kxXSA9IDE7Cg==

--part41f753cac058d--


