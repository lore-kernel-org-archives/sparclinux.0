From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:07:45 +0000
Subject: Unify module.*
Message-Id: <20081222220745.GA30716@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Following patchset unifies module.h and module.c.

The unification is done in a few smaller steps to make
it obvious what is happeing.

The first two patches unify module.h and prepare for
unification of module.c.

The third and fourth patch do all the preparations of module_64.c
without introducing any sparc32 specific code but all
sparc64 specific code is ifdef'ed.


I really did not like this part:
#ifdef CONFIG_SPARC64
                BUG_ON(((u64)location >> (u64)32) != (u64)0);
#endif /* CONFIG_SPARC64 */

I think it should be safe to do:

		BUG_ON(((unsigned long)location >> (unsigned long)32) !		       (unsigned long)0);

As to my best understanding unsigned long
is 32 bit on sparc32 and 64 bit on sparc64.
So we should with the above code not get any warnings.

But I did not really see the point of the BUG_ON in the first place,
and my limited digging did not turn up when it was added.

So to be safe I kept the ugly ifdef for now.
If is easy to spot/remove.

The final patch that unifies module.c adds one specific entry
to the case that is sparc32 specific:

                case R_SPARC_32:
+               case R_SPARC_UA32:

But this should not cause any problems.

The patch serie is build tested on a defconfig for
sparc and sparc64.

	Sam

Sam Ravnborg (5):
      sparc: introduce CONFIG_BITS
      sparc: unify module.h
      sparc64: use bit neutral Elf symbols
      sparc64: prepare module_64.c for unification
      sparc: unify module.c

 arch/sparc/Kconfig                          |    6 +-
 arch/sparc/include/asm/module.h             |   32 ++++--
 arch/sparc/include/asm/module_32.h          |    7 -
 arch/sparc/include/asm/module_64.h          |    7 -
 arch/sparc/kernel/Makefile                  |    2 +-
 arch/sparc/kernel/{module_64.c => module.c} |  112 +++++++++++++------
 arch/sparc/kernel/module_32.c               |  163 ---------------------------
 7 files changed, 107 insertions(+), 222 deletions(-)
