From: mt1@systella.fr
Date: Tue, 20 Mar 2007 21:42:04 +0000
Subject: Re: [2.6.20.3] Oops with syscall_is_too_hard...
Message-Id: <20070320214204.GA31760@rayleigh.systella.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320185247.GC27466@rayleigh.systella.fr>
In-Reply-To: <20070320185247.GC27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Mar 20, 2007 at 04:28:54PM -0500, Tom spot Callaway wrote:
> On Tue, 2007-03-20 at 19:52 +0100, BERTRAND =3D?utf-8?Q?Jo=EBl?=3D wrote:
> > 	Hello,
> >=20
> > 	I have tried to untar the sources of 2.6.21-rc4 kernel. My SS20 runs w=
ith
> > 	2.6.20.3/SMP.
>=20
> As Dave has recently pointed out, sparc32 is unmaintained.
> sparc32 SMP is known to be broken. And bug reports are going to fall on
> deaf ears, sadly.

	Even with SMP support, 2.6 kernel is more stable than the 2.4 (and its lot
	of unexpected watchdog reset). I have used all kernel on sparc32 since
	2.2. The last stable SMP kernel is the 2.2. Problem : NetBSD SMP support
	is broken, Solaris 9 too (it works only with two CPU, three and four are
	started, but kernel is not stable and randomly panics. It's not an
	hardware problem.).

	Thus, only two choices: definitively shutting down all sparc32 or use
	old OS ?

	I would help to debug this kernel, but I have no idea to fix it.

	Regards,

	JKB
