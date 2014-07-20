From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:35:02 +0000
Subject: [PATCH 0/6] sparc64 io refactoring
Message-Id: <20140720113501.GA3712@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following patchset refactor io_64.h. This was triggered by
another patchset by Thierry Reding that updates the the generic
io.h such that it may be used by sparc64 and thus make sparc
and sparc64 more equal in this area.

Before attempting to introduce the generic version it was
necessary to clean up the current state to avoid any mistakes.
The updates from Thierry needs to go in before I will attempt
introducing the generic io.h.

The sparcspkr used inb()/outb() primitives
for of_ioremap() memory. Update this driver to use sbus_ variants.
This change was triggered by a number of new warnings that would otherwise
have been seen when dropping the macro indirections.
Likewise PeeCeeI.c had some warnings that was fixed by
using another IO varaint - which simplified the code too.

The patchs has been generated with the --histogram option
to make the patch that re-order functions in io_64.h
more readable.
So to see the same patches locally you need this option too.

I have not yet any working sparc64 HW - so this is not tested.
But I brought a SUN NetraX1 that I am working on gettting
running. That may allow me to do some minimal tests in the future.

	Sam

Sam Ravnborg (6):
      sparcspkr: use sbus_*() primitives for IO
      sparc64: update IO access functions in PeeCeeI
      sparc64: remove macro indirection in io_64.h
      sparc64: drop unused SLOW_DOWN_IO definitions
      sparc64: reorder functions in io_64.h
      sparc64: avoid code duplication in io_64.h

 arch/sparc/include/asm/io_64.h | 381 ++++++++++++++++-------------------------
 arch/sparc/lib/PeeCeeI.c       |  36 ++--
 drivers/input/misc/sparcspkr.c |  22 +--
 3 files changed, 174 insertions(+), 265 deletions(-)
