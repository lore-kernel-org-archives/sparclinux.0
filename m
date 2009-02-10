From: David Miller <davem@davemloft.net>
Date: Tue, 10 Feb 2009 04:21:31 +0000
Subject: [GIT]: Sparc
Message-Id: <20090209.202131.85160609.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


FWIW I'm waiting for the patch in:

	http://marc.info/?l=linux-kernel&m3391426917099&w=2

to settle and make it's way into the tree as that bug has been
crashing my machines for a while.  It's definitely something
needed for -stable as well.

1) Don't try to use the NMI watchdog on cpus where we know it won't work.
   These chips lack the performance counter overflow interrupt which is
   essential to this scheme.

2) We have a million exception fixup stubs generated which are all
   essentially the same, so have one stub for each case and point the
   exception table entries to them.

3) Fix probe_kernel_{read,write}() on sparc64, based upon reports and patches
   from Chris Torek.

Please pull, thanks a lot.

The following changes since commit 4c098bcd55fad34dcf224bf8343db6a9ac58fc68:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../mason/btrfs-unstable

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc64: Call dump_stack() in die_nmi().
      sparc64: Don't hook up pcr_ops on spitfire chips.
      sparc64: Kill .fixup section bloat.
      sparc64: Fix probe_kernel_{read,write}().

 arch/sparc/kernel/head_64.S        |   31 ++++++++++++++++--
 arch/sparc/kernel/nmi.c            |    1 +
 arch/sparc/kernel/pcr.c            |    7 +++-
 arch/sparc/lib/GENbzero.S          |    6 +---
 arch/sparc/lib/GENcopy_from_user.S |    8 +---
 arch/sparc/lib/GENcopy_to_user.S   |    8 +---
 arch/sparc/lib/NG2copy_from_user.S |    9 +----
 arch/sparc/lib/NG2copy_to_user.S   |    9 +----
 arch/sparc/lib/NGbzero.S           |    6 +---
 arch/sparc/lib/NGcopy_from_user.S  |    9 +----
 arch/sparc/lib/NGcopy_to_user.S    |    9 +----
 arch/sparc/lib/U1copy_from_user.S  |    8 +---
 arch/sparc/lib/U1copy_to_user.S    |    8 +---
 arch/sparc/lib/U3copy_from_user.S  |    6 +---
 arch/sparc/lib/U3copy_to_user.S    |    8 +---
 arch/sparc/lib/bzero.S             |    6 +---
 arch/sparc/lib/copy_in_user.S      |   61 ++++++++++--------------------------
 17 files changed, 74 insertions(+), 126 deletions(-)
