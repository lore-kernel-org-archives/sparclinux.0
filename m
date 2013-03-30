From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 21:39:45 +0000
Subject: [PATCH 0/5] random collection of sparc patches
Message-Id: <20130330213945.GA24087@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just a random collection of patches that I have accumulated.
They are all made on top of -linus.

Two of the patches fixes build errors with sparc64:

      sparc: define __linux__ to fix defconfig build
      sparc: use asm-generic version of types.h

But I do not see these as critical - and thus not as stable candidates.
But they could be considered sparc (not sparc-next) material.

The last patch is question-able.
I prefer the select lines sorted and so I did. But others do not care.

	Sam


Sam Ravnborg (5):
      sparc: use generic headers
      sparc: define __linux__ to fix defconfig build
      bbc_i2c: fix section mismatch warning
      sparc: use asm-generic version of types.h
      sparc: sort select lines in Kconfig

 
 arch/sparc/Kconfig                         |   78 ++++++++++++++--------------
 arch/sparc/Makefile                        |    2 +
 arch/sparc/include/asm/Kbuild              |    5 ++
 arch/sparc/include/asm/cputime.h           |    6 --
 arch/sparc/include/asm/emergency-restart.h |    6 --
 arch/sparc/include/asm/mutex.h             |    9 ---
 arch/sparc/include/asm/serial.h            |    6 --
 arch/sparc/include/uapi/asm/Kbuild         |    1 -
 arch/sparc/include/uapi/asm/types.h        |   17 ------
 drivers/sbus/char/bbc_i2c.c                |    4 +-
 10 files changed, 48 insertions(+), 86 deletions(-)
