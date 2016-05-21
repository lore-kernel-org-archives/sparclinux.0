From: David Miller <davem@davemloft.net>
Date: Sat, 21 May 2016 01:30:03 +0000
Subject: Re: [PATCH 0/5] sparc32: kgdb_32 and STRICT_MM_TYPECHECKS updates
Message-Id: <20160520.213003.519485393399272735.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160422173712.GA9705@ravnborg.org>
In-Reply-To: <20160422173712.GA9705@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 19:37:12 +0200

> A few cosmetic pathes for sparc32 follows.
> I noticed some inconsistency in kgdb_32 that triggered a few patches.
> The inconsistency in kgdb_32 turned out to have no functional impact.
> But I anyway fixed it so kgdb_32 and kgdb_64 became just a tiny
> bit more alike.
> 
> The STRICT_MM_TYPECHECKS patch was triggered by a
> discussion on linux-arch where Arnd considered removing
> this cruft.
> The resulting benary of srmmu.c (I checked an assembler file)
> was _smaller_ when I defined STRICT_MM_TYPECHECKS.
> But due to lack of testing I left it undefined.
> With the build errors fixed it should be trivial to
> try out if defining STRICT_MM_TYPECHECKS breaks anything.
> 
> Any takers?

Maybe the binary is smaller, but some things will undoubtedly be
slower.

Any non-inline function that returns a pte_t, pmd_t, or any other
of these types will do so by indirect reference.

It'll look something like this:

        ld      [%sp+64], %g1
        st      %o0, [%g1]
        jmp     %o7+12
         mov    %g1, %o0
  
The caller allocates a stack slot, the callee stores into that
stack slot and returns to an address one extra instruction past
the usual return address.

The reason for the weird return, is that the normal return address
has a special "unimp" instruction that encodes the size of the
object is expects the callee to return.

Anyways, it's not very efficient.  Especially for an aggregate which
is just a single word in size.  sparc64's calling conventions handle
this much better by just directly returning the value in register(s).

I really wouldn't want to turn this on unless it really holds back
a lot of other platforms for some reason.

> As I miss any working sparc32 gear for the moment this
> has only been build tested - so please consider if it
> is worth taking the risk to apply the patches.

This series looks great, all applied, thanks Sam.
