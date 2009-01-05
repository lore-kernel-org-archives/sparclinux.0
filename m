From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 19:44:31 +0000
Subject: kill most of sparc_ksyms*
Message-Id: <20090105194431.GA4976@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I gave Julian the receipe but he has focus on the prom_ stuff,
so I decided to give it a spin.

I ended up with three largish patches. I could have made them
smaller but this is trivial stuff so I could not see
any real benefit doing so.
Agreed that review would be easier but I hope this is OK.

I left the prom* stuff in the files to avoid to much
conflict with Julian's ongoing work.
When Julian has done the prom* stuff we should merge
the two sparc_ksyms_*.c files to a single ksyms.c file.

Note the I decided to create a new file in
arch/sparc/lib to hold the exported symbols in that directory.
This is not common practice today but IMO better to
have the EXPORT in same dir as the definition of the symbol.

	Sam

Sam Ravnborg (3):
      sparc: move EXPORT_SYMBOL from kernel/ to lib/
      sparc: move EXPORT_SYMBOL to the symbols definition
      sparc64: move EXPORT_SYMBOL to the symbols definition

 arch/sparc/kernel/auxio_32.c       |    3 +-
 arch/sparc/kernel/auxio_64.c       |    2 +
 arch/sparc/kernel/cpu.c            |    2 +
 arch/sparc/kernel/ioport.c         |   15 +++
 arch/sparc/kernel/irq_32.c         |    1 +
 arch/sparc/kernel/pci.c            |    1 +
 arch/sparc/kernel/pcic.c           |    6 +
 arch/sparc/kernel/process_32.c     |    2 +
 arch/sparc/kernel/process_64.c     |    2 +
 arch/sparc/kernel/sbus.c           |    1 +
 arch/sparc/kernel/setup_32.c       |    3 +
 arch/sparc/kernel/setup_64.c       |    3 +
 arch/sparc/kernel/sparc_ksyms_32.c |  193 +---------------------------------
 arch/sparc/kernel/sparc_ksyms_64.c |  203 +-----------------------------------
 arch/sparc/kernel/sys_sparc_64.c   |    1 +
 arch/sparc/kernel/time_32.c        |    2 +
 arch/sparc/kernel/time_64.c        |    2 +
 arch/sparc/kernel/traps_32.c       |    1 +
 arch/sparc/kernel/traps_64.c       |    2 +
 arch/sparc/lib/Makefile            |    1 +
 arch/sparc/lib/PeeCeeI.c           |    7 +-
 arch/sparc/lib/ksyms.c             |  180 ++++++++++++++++++++++++++++++++
 arch/sparc/lib/user_fixup.c        |    3 +
 arch/sparc/mm/generic_32.c         |    1 +
 arch/sparc/mm/generic_64.c         |    1 +
 arch/sparc/mm/highmem.c            |    2 +
 arch/sparc/mm/init_32.c            |    6 +
 arch/sparc/mm/init_64.c            |    4 +
 28 files changed, 261 insertions(+), 389 deletions(-)


