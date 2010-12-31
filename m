From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 31 Dec 2010 09:36:29 +0000
Subject: [PATCH 0/5] sparc: piggyback update
Message-Id: <20101231093628.GA19496@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In an attempt to understand how tftp booting works
I looked at unifying piggyback_32 and piggyback_64.

Due to subtle differences I did not succeed in the
unification - at least not this time around.

But I anyway created a few patches that removes
a few differences between sparc and sparc64.
And piggyback_32 gained a lot in readability
as I have documented my findings using a few comments.

In the process I also removed ELF support from piggyback_32,
as it was not used.

The set of patches has been boot tested on sparc.
And build tested on sparc64.

Note: I have not updated piggyback_64.c because the plan was/is
that piggyback_32 shall support both sparc and sparc64.

	Sam

Sam Ravnborg (5):
      sparc: refactor piggy_32.c
      sparc: use trapbase in setup_arch
      sparc: use _start for the start entry (like 64 bit does)
      sparc: additional comments to piggyback_32.c
      sparc: remove obsolete ELF support in piggyback_32.c

 arch/sparc/boot/piggyback_32.c |  174 +++++++++++++++++++++++++++-------------
 arch/sparc/kernel/head_32.S    |    3 +-
 arch/sparc/kernel/setup_32.c   |    3 +-
 arch/sparc/mm/sun4c.c          |    8 +-
 4 files changed, 124 insertions(+), 64 deletions(-)
