From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 22:50:07 +0000
Subject: [PATCH 0/4] sparc: remove unused prom stuff
Message-Id: <20110101225007.GA17611@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

There was a few patches recently that touched arch/sparc/prom/*
This triggered me to look up why sparc and sparc64 differed
so much in their low-level prom functions.

And it was obvious that the older sparcs implementes the
ROMVEC interface (I never found a spec for this).
Where newer sparcs implements IEEE 1275.

While looking through the code I noticed that
several functions/files was unused.
I used "git grep" in the kernel tree to check - and
I have sucessfully build a sparc kernel with
the patches applied.

Note: focus on sparc (not sparc64) as this is what I
have running now.

Patches are on top of sparc-next-2.6.git

	Sam

Sam Ravnborg (4):
      sparc: drop prom/devmap.c
      sparc: drop prom/palloc.c
      sparc: remove unused prom cpu functions
      sparc: remove unused prom tree functions

 arch/sparc/include/asm/oplib_32.h |   42 --------------------
 arch/sparc/prom/Makefile          |    2 -
 arch/sparc/prom/devmap.c          |   53 -------------------------
 arch/sparc/prom/mp.c              |   78 -------------------------------------
 arch/sparc/prom/palloc.c          |   43 --------------------
 arch/sparc/prom/tree_32.c         |   44 +-------------------
 6 files changed, 3 insertions(+), 259 deletions(-)
