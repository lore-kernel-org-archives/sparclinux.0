From: Nawab Ali <alin@ececs.uc.edu>
Date: Wed, 21 Jan 2004 00:33:59 +0000
Subject: Re: TLB miss handler code
Message-Id: <Pine.GSO.4.43.0401201834380.10022-100000@gatekeeper.ececs.uc.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
In-Reply-To: <Pine.GSO.4.43.0401191315430.13707-100000@gatekeeper.ececs.uc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Ed,
Thanx for pointing out the file. I checked out the do_sparc64_fault
function in arch/sparc64/mm/fault.c (2.6.0).

This is the code snippet I found.
if ((fault_code & FAULT_CODE_ITLB) && (fault_code & FAULT_CODE_DTLB))
	BUG();

-----
BUG() has been defined as following in
linux-2.6.0/include/asm-sparc64/bug.h

#ifdef CONFIG_DEBUG_BUGVERBOSE
extern void do_BUG(const char *file, int line);
#define BUG() do {                                      \
        do_BUG(__FILE__, __LINE__);                     \
        __builtin_trap();                               \
} while (0)
#else
#define BUG()           __builtin_trap()
#endif
------

My question is, where has __builtin_trap() been implemented?? Also is
__builtin_trap() where the missing PTE is picked up from the page table and put in the
TLB because that's exactly what I'm looking for??

Thanx
nawab


On Mon, 19 Jan 2004, Ed L Cashin wrote:

> Nawab Ali <alin@ececs.uc.edu> writes:
>
> > Hi,
> > I have a Sun Ultra-10 running Debian woody. I need to modify the TLB miss
> > handler code. Basically everytime there is a TLB miss, I'm trying to log
> > the new PTE that is brought into the TLB.
> >
> > I know that SPARC machines handle TLB refills in software. Can someone
> > please point me to the TLB miss handler code(which file???) in the linux
> > kernel(2.4.24)??? I'm a bit lost here.
> >
> > Any help would be greatly appreciated.
>
> Well, I am not sure about 2.4.24, but in 2.6.0, the do_sparc64_fault
> routine in arch/sparc64/mm/fault.c is invoked during TLB miss
> handling.  When it's a TLB miss you can tell by the fact that
> (fault_code & FAULT_CODE_DTLB || fault_code & FAULT_CODE_ITLB).
>
> --
> --Ed L Cashin            |   PGP public key:
>   ecashin@uga.edu        |   http://noserose.net/e/pgp/
>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

==
Ask not what Mozilla can do for you...
---------------------------------------------------------
  Nawab Ali.			Graduate Student
  3238 Bishop Street #2.	www.ececs.uc.edu/~alin
  Cincinnati. OH - 45220.	Email: alin@ececs.uc.edu
---------------------------------------------------------

