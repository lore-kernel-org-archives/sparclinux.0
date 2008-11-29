From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:02:51 +0000
Subject: sparc unification - step 4
Message-Id: <20081129220251.GA11354@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi dave et all.

This is fourth set of patches unifying sparc/sparc64.
They are done on top of sparc-next.

With this patchset arch/sparc64/Makefile is gone
and what is left in sparc64 is only: lib/ kernel/ boot/

I have redone the previous "step-3" patchset as that took
a very inelegant approach to the merging of the Makefile
for sparc32 and sparc64. This time the set includes
a few cleanup patches before the Makefile is merged.

Included is also a unification of vmlinux.lds.S.
As the files was almost identical I took the time to do
a real unification.

I have build tested for each step to avoid bisect
issues. But I did not do a full rebuild so there is
a small risk I missed something.

When applying this set and trying to do a sparc64 build
kbuild will error out complaining about the asm symlink
as we no longer uses a asm-sparc64 symlink.
This is expected.

Patches generated using 'git format-patch -M -B' will
follow (-M and -B makes the patch git specific but
eases review).

	Sam


Sam Ravnborg (10):
      sparc,sparc64: prepare vmlinux.lds.S for unification
      sparc64: use vmlinux.lds.S from sparc
      sparc,sparc64: unify asm-offsets.c
      sparc: refactor Makefile
      sparc: drop kallsyms bits
      sparc: clean boot/
      sparc: gitignore a few files
      sparc,sparc64: unify Makefile
      sparc: prepare prom/ for unification
      sparc,sparc64: unify prom/

 Makefile                                           |    9 +-
 arch/sparc/Kconfig                                 |    7 +
 arch/sparc/Makefile                                |  103 ++++++++++----
 arch/sparc/boot/.gitignore                         |    5 +
 arch/sparc/boot/Makefile                           |    9 +-
 .../sparc/{defconfig => configs/sparc32_defconfig} |    0
 .../defconfig => sparc/configs/sparc64_defconfig}  |    0
 arch/sparc/kernel/.gitignore                       |    1 +
 arch/sparc/kernel/asm-offsets.c                    |   19 ++-
 arch/sparc/kernel/vmlinux.lds.S                    |   99 +++++++++++---
 arch/sparc/prom/Makefile                           |   27 +++-
 arch/sparc/prom/{bootstr.c => bootstr_32.c}        |    0
 .../prom/bootstr.c => sparc/prom/bootstr_64.c}     |    0
 arch/{sparc64 => sparc}/prom/cif.S                 |    0
 arch/sparc/prom/{console.c => console_32.c}        |    0
 .../prom/console.c => sparc/prom/console_64.c}     |    0
 arch/sparc/prom/{devops.c => devops_32.c}          |    0
 .../prom/devops.c => sparc/prom/devops_64.c}       |    0
 arch/sparc/prom/{init.c => init_32.c}              |    0
 arch/{sparc64/prom/init.c => sparc/prom/init_64.c} |    0
 arch/sparc/prom/{misc.c => misc_32.c}              |    0
 arch/{sparc64/prom/misc.c => sparc/prom/misc_64.c} |    0
 arch/{sparc64 => sparc}/prom/p1275.c               |    0
 arch/sparc/prom/{printf.c => printf_32.c}          |    0
 .../prom/printf.c => sparc/prom/printf_64.c}       |    0
 arch/sparc/prom/{tree.c => tree_32.c}              |    0
 arch/{sparc64/prom/tree.c => sparc/prom/tree_64.c} |    0
 arch/sparc64/Kconfig                               |    1 -
 arch/sparc64/Makefile                              |   48 -------
 arch/sparc64/kernel/Makefile                       |    2 +-
 arch/sparc64/kernel/asm-offsets.c                  |    2 +-
 arch/sparc64/kernel/vmlinux.lds.S                  |  148 +-------------------
 arch/sparc64/prom/Makefile                         |    9 --
 33 files changed, 213 insertions(+), 276 deletions(-)
