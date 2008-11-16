From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 20:11:17 +0000
Subject: Re: [PATCH] sparc,sparc64: unify Kconfig
Message-Id: <20081116201117.GA6234@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 16, 2008 at 01:06:09AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 16 Nov 2008 09:56:57 +0100
> 
> > +config ARCH_SPARSEMEM_DEFAULT
> > +	def_bool y if PSARC64
> 
> Come on Sam... obvious typo making ARCH_SPARSEMEM_DEFAULT not
> get set after this change on sparc64.
> 
> Also, there are other bugs, RWSEM_XCHGADD_ALGORITHM is now also
> different.  sparc32 just has it as "bool" whereas sparc64 makes it:
> 
> 	bool
> 	default y
> 
> Every time I get this patch I start with a fresh "make oldconfig"
> of arch/sparc64/defconfig, I apply the change, and I rerun
> "make oldconfig" and diff the result.  Are you doing this too? :)

So this time I was a bit more carefull...
I have checked the result before and after using the
scripts/diffconfig tool and none of allnoconfig, allyesconfig,
allmodconfig nor a couple of randconfig showed any differences.
I checked for both sparc and sparc64.
And I also trid to introduce mistakes in the patch to check
that they were caught and the testing caught it with no problem.

This submissions is of the quality that the first
submission should have been.

It includes unification of:
Kconfig
math-emu/
oprofile/
mm/

The unified result has been build checked only as I do not have
a sparc/sparc64 target.

This time I used "git format-patch -M -B -n" when generating
the patches. This makes them git specific but they are
much more review friendly.

	Sam

Sam Ravnborg (8):
      sparc,sparc64: unify Kconfig files
      sparc,sparc64: add BITS to arch Makefile
      sparc: cleanup math-emu
      sparc: prepare math-emu for unification
      sparc64: unify math-emu
      sparc64: unify arch/sparc64/oprofile/
      sparc: prepare mm/ for unification
      sparc,sparc64: unify mm/

 arch/sparc/Kconfig                                 |  347 ++++++++++++++--
 arch/sparc/Makefile                                |    7 +-
 arch/sparc/math-emu/Makefile                       |    6 +-
 arch/sparc/math-emu/ashldi3.S                      |   36 --
 arch/sparc/math-emu/{math.c => math_32.c}          |    2 +-
 .../math-emu/math.c => sparc/math-emu/math_64.c}   |    2 +-
 arch/sparc/math-emu/{sfp-util.h => sfp-util_32.h}  |    0
 .../sfp-util.h => sparc/math-emu/sfp-util_64.h}    |    0
 arch/sparc/mm/Makefile                             |   42 ++-
 arch/sparc/mm/{fault.c => fault_32.c}              |    0
 arch/{sparc64/mm/fault.c => sparc/mm/fault_64.c}   |    0
 arch/sparc/mm/{generic.c => generic_32.c}          |    0
 .../mm/generic.c => sparc/mm/generic_64.c}         |    0
 arch/{sparc64 => sparc}/mm/hugetlbpage.c           |    0
 arch/sparc/mm/{init.c => init_32.c}                |    0
 arch/{sparc64/mm/init.c => sparc/mm/init_64.c}     |    2 +-
 arch/{sparc64/mm/init.h => sparc/mm/init_64.h}     |    0
 arch/{sparc64 => sparc}/mm/tlb.c                   |    0
 arch/{sparc64 => sparc}/mm/tsb.c                   |    0
 arch/{sparc64 => sparc}/mm/ultra.S                 |    0
 arch/sparc64/Kconfig                               |  438 +-------------------
 arch/sparc64/Makefile                              |   10 +-
 arch/sparc64/math-emu/Makefile                     |    7 -
 arch/sparc64/mm/Makefile                           |    9 -
 arch/sparc64/oprofile/Makefile                     |    9 -
 arch/sparc64/oprofile/init.c                       |   23 -
 26 files changed, 349 insertions(+), 591 deletions(-)
