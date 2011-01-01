From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 20:57:01 +0000
Subject: [PATCH v2 0/9] sparc: unify sparc/boot/piggyback
Message-Id: <20110101205701.GA4544@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I decided to complete the unification of piggyback.
This was inspired by comments from Julian Calaby.

The patchset documents my findings while reverse engineering
piggyback. And some limited refactoring also increased
readability a lot.
piggyback now takes an argument that tell if this is for
sparc or sparc64 and uses this info to adjust behaviour
as sparc and sparc64 differs in a few places.

With these additions we can now use the same piggyback for
both sparc and sparc64.

My testing turned out that piggyback_64 was broken on my x86 box,
because it was hardcoded to assume a big-endian host.
I also found a few code-spots that assuemd the host was big-endian.
All cases are fixed to be endian neutral.

Julian Calaby acknowledged that piggyback_64 had endian troubles.

This is boot tested on my sparc box.
I have only build tested the sparc64 bits!

Since v1 of the patchset I have included 4 additional patches,
the original 5 patches has not seen any updates.
And the patches are properly numbered this time.

	Sam
 

Sam Ravnborg (9):
      sparc: refactor piggy_32.c
      sparc: use trapbase in setup_arch
      sparc: use _start for the start entry (like 64 bit does)
      sparc: additional comments to piggyback_32.c
      sparc: remove obsolete ELF support in piggyback_32.c
      sparc: add $BITS to piggyback arguments
      sparc: use piggyback_32 for sparc64
      sparc: rename piggyback_32 to piggyback
      sparc: unify strip command in boot/Makefile

 arch/sparc/boot/Makefile       |   28 ++---
 arch/sparc/boot/piggyback.c    |  266 ++++++++++++++++++++++++++++++++++++++++
 arch/sparc/boot/piggyback_32.c |  137 ---------------------
 arch/sparc/boot/piggyback_64.c |  110 -----------------
 arch/sparc/kernel/head_32.S    |    3 +-
 arch/sparc/kernel/setup_32.c   |    3 +-
 arch/sparc/mm/sun4c.c          |    8 +-
 7 files changed, 280 insertions(+), 275 deletions(-)
