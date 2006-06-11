From: Bob Breuer <breuerr@mc.net>
Date: Sun, 11 Jun 2006 23:28:14 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <448CA70E.4030805@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Ludovic Court=E8s wrote:
> However, when trying to compile natively rc6 with your patches, with
> either GCC 4.1.1 or 4.0.4 (from Debian unstable), I get an ICE:
>=20
>   CC      kernel/sched.o
>   kernel/sched.c: In function 'effective_prio':
>   kernel/sched.c:659: internal compiler error: in choose_multiplier, at e=
xpmed.c:3269
>=20
> What compiler and what platform do you use to compile the kernel?
> Has anyone experienced similar problems?

That's strange, I didn't touch kernel/sched.c, but I did modify a couple
of sparc specific header files.  Can you narrow down which patch broke
it for you?

I compiled it both with gcc 3.3.4 and 3.4.2 from Aurora, specifically:
  gcc version 3.3.4 20040623 (Red Hat 3.3.4-2)
  gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)

Bob
