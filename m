From: Jason Wever <weeve@gentoo.org>
Date: Sat, 12 Nov 2005 20:39:05 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051112133905.26627897@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Sat__12_Nov_2005_13_39_05_-0700_Uw1_688c_d0_Ct4x"
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
To: sparclinux@vger.kernel.org

--Signature_Sat__12_Nov_2005_13_39_05_-0700_Uw1_688c_d0_Ct4x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Nov 2005 11:45:28 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> And without the IRQ stack patch applied the "kernel BUG at
> kernel/fork.c:731" problem does not occur?

Correct, an unpatched 2.6.14, 2.6.14-git14 or 2.6.15-rc1 does not show
this problem.  All 3 of those kernels when patched, do.

Another discovery found while testing this patch but unrelated to it
(happens both with and without the patch) is that if the new
driver for a radeonfb is compiled into the kernel (i.e. for XVR-100
users) and -p is passed to the kernel at boot time, the kernel will
panic.  The error message is right as the kernel is detecting the CPUs
on the Blade 1000 and says something to the effect of "cannot contact
remote CPUs".

This also only appears to happen when the graphical console is detected
as booting the system without a keyboard and mouse connected boots
normally.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Sat__12_Nov_2005_13_39_05_-0700_Uw1_688c_d0_Ct4x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdlLrdKvgdVioq28RAvAuAKCT+VnBOQWFDcWhyVX0u0mGQdKJ7wCfQ2di
cEkopr4cLsUuOKe8c3qBWuQ=
=QjPg
-----END PGP SIGNATURE-----

--Signature_Sat__12_Nov_2005_13_39_05_-0700_Uw1_688c_d0_Ct4x--
