From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 08:55:46 +0000
Subject: sparc unification - step 2
Message-Id: <20081116085546.GA10044@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is the second batch of sparc unification patches.

It includes the (corrected) final unification of Kconfig
and it then prepares for and unifies math-emu.

I removed some stale crud from sparc/math-emu while I was there.

I will slowly continue with the other directories,
but do not expect more this weekend.
Doing it slowly I hope we catch obviously mistakes early.

	Sam

Sam Ravnborg (5):
      sparc,sparc64: unify Kconfig
      sparc,sparc64: add BITS to arch Makefile
      sparc: cleanup math-emu
      sparc: prepare math-emu for unification
      sparc64: unify math-emu

 arch/sparc/Kconfig                                 |  351 ++++++++++++++--
 arch/sparc/Makefile                                |    7 +-
 arch/sparc/math-emu/Makefile                       |    6 +-
 arch/sparc/math-emu/ashldi3.S                      |   36 --
 arch/sparc/math-emu/{math.c => math_32.c}          |    2 +-
 .../math-emu/math.c => sparc/math-emu/math_64.c}   |    2 +-
 arch/sparc/math-emu/{sfp-util.h => sfp-util_32.h}  |    0
 .../sfp-util.h => sparc/math-emu/sfp-util_64.h}    |    0
 arch/sparc64/Kconfig                               |  438 +-------------------
 arch/sparc64/Makefile                              |    6 +-
 arch/sparc64/math-emu/Makefile                     |    7 -
 11 files changed, 321 insertions(+), 534 deletions(-)
