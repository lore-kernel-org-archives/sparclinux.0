From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:00:09 +0000
Subject: [PATCH 0/8] diverse sparc32 patches (mostly leon related)
Message-Id: <20120520060009.GA18477@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I have looked a bit more into proper integration of leon.
Following is a few random patches as spin-off by this.

I actually considered creating mm/mmu_viking.c, mm/mmu_turbosparc.c etc.
But for now I left it all in srmmu.c.

As I introduced a dedicated traptable file for sparc32, I renamed
the sparc64 variant.
This change is not build tested (lacks sparc64 gcc on this box).

	Sam

Sam Ravnborg (8):
      sparc64: renamed ttable.S to ttable_64.S
      sparc32: move trap table to a separate file
      sparc32,leon: move leon ASI definitions to asi.h
      sparc32,leon: remove duplicate UART register definitions
      sparc32,leon: remove duplicate definitions in leon.h
      sparc32,leon: move leon mmu functions to leon_mm.c
      sparc32: drop unused functions in pgtsrmmu.h
      sparc32: drop unused inline functions in srmmu.c

 arch/sparc/include/asm/asi.h                |   14 +
 arch/sparc/include/asm/leon.h               |   55 +----
 arch/sparc/include/asm/pgtsrmmu.h           |   50 ----
 arch/sparc/kernel/head_32.S                 |  326 +---------------------
 arch/sparc/kernel/head_64.S                 |    2 +-
 arch/sparc/kernel/ttable_32.S               |  418 +++++++++++++++++++++++++++
 arch/sparc/kernel/{ttable.S => ttable_64.S} |    0
 arch/sparc/mm/leon_mm.c                     |   96 ++++++-
 arch/sparc/mm/srmmu.c                       |  109 +-------
 arch/sparc/mm/srmmu.h                       |    4 +
 10 files changed, 537 insertions(+), 537 deletions(-)

