From: David Miller <davem@davemloft.net>
Date: Wed, 25 Jul 2007 06:19:35 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070724.231935.78494091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 12 Jul 2007 11:50:38 +0200

> 	Process stops at line 17384 in clamav-strace:
>=20
> futex(0x25944f0, FUTEX_WAIT
>=20
> Line terminaison was written ("2, NULL)   =3D ? ERESTARTSYS (To be=20
> restarted)") when I have pressed ctrl+C, but process remains in sleep=20
> state. I have tried kill -15 (without any success). Only kill -9 kills=20
> clamd.

Can you give this patch a try?

diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
index 876312f..3b5797e 100644
--- a/include/asm-sparc64/futex.h
+++ b/include/asm-sparc64/futex.h
@@ -14,6 +14,7 @@
 	"	cmp	%2, %1\n"			\
 	"	bne,pn	%%icc, 1b\n"			\
 	"	 mov	0, %0\n"			\
+	"	sra	%1, 0, %1\n"			\
 	"3:\n"						\
 	"	.section .fixup,#alloc,#execinstr\n"	\
 	"	.align	4\n"				\
@@ -88,6 +89,7 @@ futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldv=
al, int newval)
 {
 	__asm__ __volatile__(
 	"\n1:	casa	[%3] %%asi, %2, %0\n"
+	"	sra	%0, 0, %0\n"
 	"2:\n"
 	"	.section .fixup,#alloc,#execinstr\n"
 	"	.align	4\n"
