From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:37:12 +0000
Subject: [PATCH 0/5] sparc32: kgdb_32 and STRICT_MM_TYPECHECKS updates
Message-Id: <20160422173712.GA9705@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few cosmetic pathes for sparc32 follows.
I noticed some inconsistency in kgdb_32 that triggered a few patches.
The inconsistency in kgdb_32 turned out to have no functional impact.
But I anyway fixed it so kgdb_32 and kgdb_64 became just a tiny
bit more alike.

The STRICT_MM_TYPECHECKS patch was triggered by a
discussion on linux-arch where Arnd considered removing
this cruft.
The resulting benary of srmmu.c (I checked an assembler file)
was _smaller_ when I defined STRICT_MM_TYPECHECKS.
But due to lack of testing I left it undefined.
With the build errors fixed it should be trivial to
try out if defining STRICT_MM_TYPECHECKS breaks anything.

Any takers?

As I miss any working sparc32 gear for the moment this
has only been build tested - so please consider if it
is worth taking the risk to apply the patches.

	Sam

Sam Ravnborg (5):
      sparc32: drop hardcoding trap_level in kgdb_trap
      sparc32: drop local prototype in kgdb_32
      sparc32: use proper prototype for trapbase
      sparc32: fix build with STRICT_MM_TYPECHECKS
      sparc32: drop superfluous cast in calls to __nocache_pa()

 arch/sparc/include/asm/head_32.h    |  8 ++++----
 arch/sparc/include/asm/kgdb.h       |  2 +-
 arch/sparc/include/asm/page_32.h    |  2 --
 arch/sparc/include/asm/pgalloc_32.h |  4 ++--
 arch/sparc/include/asm/pgtable_32.h |  2 +-
 arch/sparc/kernel/entry.S           | 10 ++++------
 arch/sparc/kernel/kernel.h          |  1 +
 arch/sparc/kernel/kgdb_32.c         | 11 +++++------
 arch/sparc/kernel/setup_32.c        |  4 +---
 arch/sparc/mm/io-unit.c             |  4 ++--
 arch/sparc/mm/srmmu.c               | 19 ++++++++++++-------
 11 files changed, 33 insertions(+), 34 deletions(-)

