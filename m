From: David Miller <davem@davemloft.net>
Date: Mon, 03 Dec 2012 20:33:56 +0000
Subject: [GIT] Sparc
Message-Id: <20121203.153356.1912477920174640312.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two small fixes for Sparc, nobody uses sparc, so these are
low risk :-)

1) Piggyback is too picky about the symbol types that _start
   and _end have in the final kernel image, and it thus breaks
   with newer binutils.  Future proof by getting rid of the
   symbol type checks.

2) exit_group() should kill register windows on sparc64 the same
   way we do for plain exit().  Thanks to Al Viro for spotting
   this.

Please pull, thanks a lot!

The following changes since commit 7e5530af11be68f3109672aed59243f82e1272f0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2012-12-02 16:39:00 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 0032c857454581510de1ca12615de5e38e543c92:

  sparc: Fix piggyback with newer binutils. (2012-12-03 11:24:25 -0800)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: exit_group should kill register windows just like plain exit.
      sparc: Fix piggyback with newer binutils.

 arch/sparc/boot/piggyback.c    | 12 ++++++------
 arch/sparc/kernel/sys32.S      |  2 +-
 arch/sparc/kernel/syscalls.S   | 14 ++++++++++++--
 arch/sparc/kernel/systbls_64.S |  2 +-
 4 files changed, 20 insertions(+), 10 deletions(-)

