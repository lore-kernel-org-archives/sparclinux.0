From: "Christian Joensson" <christian.joensson@gmail.com>
Date: Sun, 28 May 2006 10:27:23 +0000
Subject: Re: 2.6.17-rc5 does not build for sparc
Message-Id: <5460e3330605280327q44965ce5q6232c85901a88ede@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4478bffd45960@wp.pl>
In-Reply-To: <4478bffd45960@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 5/28/06, BERTRAND Jo=EBl <mt1@systella.fr> wrote:
> Bob Breuer a =E9crit :
> > Krzysztof Helt wrote:
> >
> >>Hello,
> >>
> >>I tried to build the 2.6.17-rc5 for sparc with SMP enabled. The
> >>kernel was not build due to a missing macro. Here is a patch
> >>which fixes this (I copied the macro from a sparc64 header).
> >>
> >
> >
> > That's not all that is broken.  I think I have what could be 4 separate
> > patches for smp here: (combined in the attached patch)
> >   1. add topology_init - fixes a boot time crash
> >   2. setup cpu_possible_map - actually boot the additional cpu's
> >   3. fix smp related section mismatch warnings
> >   4. add the missing *_can_lock macros
> >
> > If you are running a local framebuffer, you may encounter a problem with
> > vmalloc.  Adding "migration_cost=10000" to the kernel command line
> > should cover up the problem.
> >
> > I haven't had the time to give it a thorough testing and see if it
> > self-recompiles recently, but I was previously able to successfully
> > rebuild the kernel with "make -j6" on a dual SuperSPARC II.
>
>         I have tried your patch too and I only can randomly use a SS20 wi=
th two
> SSI/75 (448 MB). I have tested the last kernel proposed on the
> debian-sparc mailing list without any trouble but with only one SSII
> (SMP is broken but I haven't seen any DMA error).
>
>         Question : does somebody use a SS20 with four ROSS ? I have seens=
 a
> very strange trouble. I have a lot of RT626, SS20 and memory chips. With
> all configurations I have tested with more than two RT626, Solaris 9
> returns "watchdog reset". All motherboards have been tested and work
> fine. Same observations for RT626 and memory. Thus, I don't know if the
> trouble I have seen with Linux 2.6 and 4*RT626 come from hardware
> incompatibility or software mistake. Any idea ? Currently, I retest a
> SS20 with Solaris 9 and 2*RT626 and I have built without any trouble
> gcc-4.1.0 and gcc-4.1.1.

sorry, I had one, quad 150 MHz, but I threw it away in january, 2.2
worked but not 2.4, and sparc32 smp is as far as I understand... well,
dead in 2.6....


--=20
Cheers,

/ChJ
