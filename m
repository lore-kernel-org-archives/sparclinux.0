From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Mon, 30 Mar 2020 19:26:45 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <31e71908-3508-5f71-01c8-49f861257835@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org



On 30/03/2020 07:18, John Paul Adrian Glaubitz wrote:
> Hi Rolf!
>=20
> On 3/30/20 10:41 AM, Rolf Eike Beer wrote:
>> I run a 32 bit Gentoo userspace on my T5120 with a 64 bit kernel (5.5.7 =
at the=20
>> moment). This is nothing really new, I see this for a while, but it seem=
s to=20
>> got a bit worse lately.
>=20
> Debian's glibc maintainer told me that the glibc testsuite on SPARC has m=
ore failures
> on 32-bit than on 64-bit. Maybe we should look into trying to get some of=
 these failures
> fixed first. CC'ing Adhemerval from glibc upstream who has done a lot of =
bug fixing
> on SPARC in glibc.

I have been seeing some sparc32 issues on 64-bit kernels as well. I have
documented some on glibc release wiki [1].  I noted the wait and nanosleep
issue on 2.31 and after the changes required for y2038 safeness and some
refactoring in syscall handling on master branch I didn't see them anymore.
So I am not sure if they are related to kernel, code generation or glibc
itself.

The sparc32 master still show some issues:

FAIL: nptl/tst-cancel24-static
FAIL: nptl/tst-cancelx20
FAIL: nptl/tst-cancelx21
FAIL: nptl/tst-cond8-static
FAIL: nptl/tst-mutex8-static
FAIL: nptl/tst-mutexpi8-static

>=20
> It could be useful in this context if Gentoo could provide a small Gentoo=
 SPARC LDOM
> running 32-bit userland for the GCC Compile Farm. This way upstream devel=
opers get
> easy access to a Gentoo SPARC instance to be able to reproduce issues lik=
e this.
>=20
>> When I read about https://sourceware.org/git/?
>> p=3Dglibc.git;a=3Dcommit;h=B33e946fbb1659d2c5937c4dd756a7c49a132dff I th=
ought that=20
>> this may solve the issue, but I rebuild my glibc in a chroot with that p=
atch=20
>> and at least the fish testsuite hangs are unchanged.
>>
>> Has anyone a clue what's going on there?

Funny thing about b33e946fbb1659d2c5937c4dd756a7c49a132dff is the original =
code
has been working for age (in fact since the port has been included), meaning
that gcc used to *not* generate a stack frame for:

static void
__rt_sigreturn_stub (void)
{
  __asm__ ("mov %0, %%g1\n\t"
	   "ta	0x6d\n\t"
	   : /* no outputs */
	   : "i" (__NR_rt_sigreturn));
}

static void
__sigreturn_stub (void)
{
  __asm__ ("mov %0, %%g1\n\t"
	   "ta	0x6d\n\t"
	   : /* no outputs */
	   : "i" (__NR_sigreturn));
}

The only recent change prior the move to assembly was on 2.25 where we had
to disable the stack protector.  For 2.31 release, for instance, I used the
gcc 7.5.0 since it didn't trigger this issue.

> I know that there have been some stability issues with the Linux kernel o=
n SPARC
> with older hardware like the UltraSPARC IIIi. The T5120 we have and newer=
 machines
> seem to run relatively fine with a 64-bit userland.

Not only stability issues, but I noticed that kernel developers had=20
fixed a SysV IPC kernel issue on 32-bits kernels that has been=20
lingering for years.  So I am not sure how well maintained is
32-bit sparc is in general.

[1] https://sourceware.org/glibc/wiki/Release/2.31
