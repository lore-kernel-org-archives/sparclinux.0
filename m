From: David Miller <davem@davemloft.net>
Date: Fri, 12 Dec 2014 20:58:27 +0000
Subject: [GIT] Sparc
Message-Id: <20141212.155827.1079101782826703191.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Not a lot of stuff this time around, mostly bug fixing:

1) Fix alignment of 32-bit crosscall datastructure on Leon, from
   Andreas Larsson.

2) Several fixes to the virtual disk driver on sparc64 by Dwight
   Engen, including handling resets of the service domain properly.

Please pull, thanks a lot!

The following changes since commit 70e71ca0af244f48a5dcf56dc435243792e3a495:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next (2014-12-11 14:27:06 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 76e74bbe0a38c6720217425ed64dbb448c643b9d:

  sunvdc: reconnect ldc after vds service domain restarts (2014-12-11 18:52:45 -0800)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32, leon: Align ccall_info to prevent unaligned traps on crosscall

Dwight Engen (4):
      sunvdc: fix module unload/reload
      vio: create routines for inc,dec vio dring indexes
      sparc/ldc: create separate ldc_unbind from ldc_free
      sunvdc: reconnect ldc after vds service domain restarts

 arch/sparc/include/asm/ldc.h       |   1 +
 arch/sparc/include/asm/vio.h       |  15 +++++
 arch/sparc/kernel/ldc.c            |  12 +++-
 arch/sparc/kernel/leon_smp.c       |   2 +-
 drivers/block/sunvdc.c             | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/ethernet/sun/sunvnet.c |  30 +++-------
 6 files changed, 230 insertions(+), 52 deletions(-)
