From: Bob Breuer <breuerr@mc.net>
Date: Wed, 05 Apr 2006 16:51:37 +0000
Subject: Re: Building a small sparc32 kernel
Message-Id: <4433F599.2050101@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060404151927.GC2358@cassis>
In-Reply-To: <20060404151927.GC2358@cassis>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ludovic Court=E8s wrote:
> Hello,
>=20
> I'm trying to build a 2.6.11 kernel with Bob Breuer's sparc32 SMP
> patch[0] for a bi-processor SS20 (currently running a 2.4 SMP kernel).

2.6.11?  You shouldn't need to go back that far.  The patch in the
message you referenced was for 2.6.14, and also works for 2.6.15.  As
long as you don't enable spinlock debugging, you will never get the lock
errors.

> I'm having a hard time trying to figure out an appropriate build
> configuration such that the resulting kernel image is small enough
> (i.e., avoiding the "uncompressed image too long" message at boot time).
>=20
> Does anyone have an appropriate `.config' that may be posted?
>=20

It's nearly a requirement for the kernel to be stripped before silo will
load it.  Try using "strip arch/sparc/boot/image -o /boot/vmlinux" to
copy and strip the kernel in one step.

Bob

> [0] http://article.gmane.org/gmane.linux.ports.sparc/5650/
