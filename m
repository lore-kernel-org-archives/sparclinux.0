From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Thu, 12 Apr 2018 11:03:14 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180412110314.GA28070@altlinux.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
List-Id: <sparclinux.vger.kernel.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
In-Reply-To: <20180412095811.GC16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:58:11AM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> > A similar commit v4.16-rc1~159^2~37
> > ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> > introduced a similar ABI regression to compat arm.
>=20
> So, could you explain how can this change cause a regression?
>=20
> +#define FPE_FIXME      0
> -               vfp_raise_sigfpe(0, regs);
> +               vfp_raise_sigfpe(FPE_FIXME, regs);

No, this hunk hasn't caused the regression, but another one did:

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/as=
m/siginfo.h
new file mode 100644
index 0000000..d051388
--- /dev/null
+++ b/arch/arm/include/uapi/asm/siginfo.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_SIGINFO_H
+#define __ASM_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+/*
+ * SIGFPE si_codes
+ */
+#ifdef __KERNEL__
+#define FPE_FIXME      0       /* Broken dup of SI_USER */
+#endif /* __KERNEL__ */
+
+#endif

This is due to FPE_FIXME handling in kernel/signal.c


--=20
ldv

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJazzzyAAoJEAVFT+BVnCUIw1YP/0I5ff8Z4fOIPctdlF7NS3Jh
c2TAv7D40LUzHOnfXWx2Fy8hzScahtMi1FGOhwFCHvQawI1XYYKG1QAKOtOBV/ut
bpPe/p/4Ib0Qjep1MNB+nhfmXHUS/GVGoFDp5cueyKqw9axCjkJGU1zZ1s4Frpme
KMufr8I5JOh7mKh11lHiktGkP4oQFfVhHAnpn3GgsDDr0Lm3ASA759nEHQYSQ0yc
uDNQrSYjdFoWsXoijWOq5zmABNcYi0c3L+6HJQVXH/FEXLDHyxv3uLSLWQ6KZt1G
28vT61+SEko2RWM7ethcXc9J0VEgl20cQ5BLsYhExrje872YillIwAVHrbxE8SZh
u6lHx+VYlHpYP+H3p67/pb1RbMGUNLK8fUv+oOif5FaPwShhRVtJGKhGsg4yyKAz
3Kh6PkeE5LhRo4OUhq8SjeMHSPlgidmcAXZJSsNlW2A1+5IEnd640JfKyP7jcgOg
AZEos39gLXAp0iMIff9IdrLmNtqc/LCKP5bE1PKXdpsyhMI/B3tN6h4DkTcU5X5I
2V4SofWNC084zpxE8fHAQZ+Iwj9AEwCAatCnnoFxFm2AxyiCQmChXoS5RN+hPAOB
6S70Qob9vxMPPPdHPyDvor6DwKUwHiPYAvfxGRq08nkDkkRLy09NCjofMBwvnGZF
5FZOXAQ3wERpSpjaklJH
=kR/I
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
