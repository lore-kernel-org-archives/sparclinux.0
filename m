From: Ludovic =?iso-8859-1?Q?Court=E8s?= <ludo@chbouib.org>
Date: Wed, 14 Jun 2006 17:35:26 +0000
Subject: Re: [PATCH 0/4] sparc32: smp fixes
Message-Id: <20060614173522.GA2333@cassis>
List-Id: <sparclinux.vger.kernel.org>
References: <448BB4E4.4060408@mc.net>
In-Reply-To: <448BB4E4.4060408@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

2 days, 18 hours, 3 minutes, 4 seconds ago,=20
Bob Breuer wrote:
> Ludovic Court=E8s wrote:
> > However, when trying to compile natively rc6 with your patches, with
> > either GCC 4.1.1 or 4.0.4 (from Debian unstable), I get an ICE:
> >=20
> >   CC      kernel/sched.o
> >   kernel/sched.c: In function 'effective_prio':
> >   kernel/sched.c:659: internal compiler error: in choose_multiplier, at=
 expmed.c:3269
> >=20
> > What compiler and what platform do you use to compile the kernel?
> > Has anyone experienced similar problems?
>=20
> That's strange, I didn't touch kernel/sched.c, but I did modify a couple
> of sparc specific header files.  Can you narrow down which patch broke
> it for you?
>=20
> I compiled it both with gcc 3.3.4 and 3.4.2 from Aurora, specifically:
>   gcc version 3.3.4 20040623 (Red Hat 3.3.4-2)
>   gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)

Using GCC 3.4.6 (from Debian sid) fixes the problem.

However, the resulting kernel hangs right after the "Booting Linux..."
message.  Unfortunately, I might have a few objects compiled with 4.x in
the middle of those compiled with 3.4.6.  Is this likely to cause
troubles?

In the meantime, could you make SMP images available?  Then I could
spend my CPU time compiling natively, which would be more useful.

Thanks,
Ludovic.

