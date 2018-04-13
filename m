From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Apr 2018 16:33:17 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="001a114a4cf2f881360569bd6d69"
List-Id: <sparclinux.vger.kernel.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
 <20180413094211.GN16141@n2100.armlinux.org.uk>
In-Reply-To: <20180413094211.GN16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--001a114a4cf2f881360569bd6d69
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 13, 2018 at 2:42 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> Yes, it does solve the problem at hand with strace - the exact patch I
> tested against 4.16 is below.

Ok, good.

> However, FPE_FLTUNK is not defined in older kernels, so while we can
> fix it this way for the current merge window, that doesn't help 4.16.

I wonder if we should even bother with FPE_FLTUNK.

I suspect we might as well use FPE_FLTINV, I suspect, and not have
this complexity at all. That case is not worth worrying about, since
it's a "this shouldn't happen anyway" and the *real* reason will be in
the kernel logs due to vfs_panic().

So it's not like this is something that the user should ever care
about the si_code about.

> Given that the path we're talking about is unlikely to happen (as
> mentioned in my second paragraph) I still think reverting Eric's patch
> is the right way forward for older kernels.

I'd much rather get rid of that FPE_FIXME, and leave that whole mess behind.

So the attached patch seems simple and should work with 4.16 too.

Let's not leave this as some kind of nasty maintenance issue, and just
go for simple and stupid.

Hmm?

                Linus

--001a114a4cf2f881360569bd6d69
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfy68q9b0

IGFyY2gvYXJtL2luY2x1ZGUvdWFwaS9hc20vc2lnaW5mby5oIHwgMTMgLS0tLS0tLS0tLS0tLQog
YXJjaC9hcm0vdmZwL3ZmcG1vZHVsZS5jICAgICAgICAgICAgfCAgMiArLQogMiBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vaW5jbHVkZS91YXBpL2FzbS9zaWdpbmZvLmggYi9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNt
L3NpZ2luZm8uaApkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggZDA1MTM4ODBiZTIxLi4w
MDAwMDAwMDAwMDAKLS0tIGEvYXJjaC9hcm0vaW5jbHVkZS91YXBpL2FzbS9zaWdpbmZvLmgKKysr
IC9kZXYvbnVsbApAQCAtMSwxMyArMCwwIEBACi0jaWZuZGVmIF9fQVNNX1NJR0lORk9fSAotI2Rl
ZmluZSBfX0FTTV9TSUdJTkZPX0gKLQotI2luY2x1ZGUgPGFzbS1nZW5lcmljL3NpZ2luZm8uaD4K
LQotLyoKLSAqIFNJR0ZQRSBzaV9jb2RlcwotICovCi0jaWZkZWYgX19LRVJORUxfXwotI2RlZmlu
ZSBGUEVfRklYTUUJMAkvKiBCcm9rZW4gZHVwIG9mIFNJX1VTRVIgKi8KLSNlbmRpZiAvKiBfX0tF
Uk5FTF9fICovCi0KLSNlbmRpZgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vdmZwL3ZmcG1vZHVsZS5j
IGIvYXJjaC9hcm0vdmZwL3ZmcG1vZHVsZS5jCmluZGV4IDRjMzc1ZTExYWU5NS4uYWY0ZWUyY2Vm
MmY5IDEwMDY0NAotLS0gYS9hcmNoL2FybS92ZnAvdmZwbW9kdWxlLmMKKysrIGIvYXJjaC9hcm0v
dmZwL3ZmcG1vZHVsZS5jCkBAIC0yNTcsNyArMjU3LDcgQEAgc3RhdGljIHZvaWQgdmZwX3JhaXNl
X2V4Y2VwdGlvbnModTMyIGV4Y2VwdGlvbnMsIHUzMiBpbnN0LCB1MzIgZnBzY3IsIHN0cnVjdCBw
dF8KIAogCWlmIChleGNlcHRpb25zID09IFZGUF9FWENFUFRJT05fRVJST1IpIHsKIAkJdmZwX3Bh
bmljKCJ1bmhhbmRsZWQgYm91bmNlIiwgaW5zdCk7Ci0JCXZmcF9yYWlzZV9zaWdmcGUoRlBFX0ZJ
WE1FLCByZWdzKTsKKwkJdmZwX3JhaXNlX3NpZ2ZwZShGUEVfRkxUSU5WLCByZWdzKTsKIAkJcmV0
dXJuOwogCX0KIAo=
--001a114a4cf2f881360569bd6d69--
