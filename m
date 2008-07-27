From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Jul 2008 21:29:06 +0000
Subject: Use arch/sparc/include/asm for sparc & sparc64
Message-Id: <20080727212906.GA23262@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

Please pull from:

   git://git.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git master

to receive the following two patches:

Sam Ravnborg (2):
      sparc, sparc64: use arch/sparc/include
      sparc: enable headers_export again

This is the initial full unification of header files for
sparc and sparc64 and the first architecture to use
arch/$ARCH/include/...

This patch-set will most likely break m68k as m68k include
a few sparc headers (Geert Uytterhoeven copied).

I suggest to introduce use of arch/m68k/include to make the fix trivial.


The fist patch basically moves all header files
from include/asm-sparc{,64} and the diffstat and diff is very big.

From the changelog of the patch:
 The majority of this patch was created by the following script:

    ***
    ASM=arch/sparc/include/asm
    mkdir -p $ASM
    git mv include/asm-sparc64/ftrace.h $ASM
    git rm include/asm-sparc64/*
    git mv include/asm-sparc/* $ASM
    sed -ie 's/asm-sparc64/asm/g' $ASM/*
    sed -ie 's/asm-sparc/asm/g' $ASM/*
    ***

    The rest was an update of the top-level Makefile to use sparc
    for header files when sparc64 is being build.
    And a small fixlet to pick up the correct unistd.h from
    sparc64 code.

The patch will not be posted as it is too big.

The second patch will be posted as a followup.

	Sam


