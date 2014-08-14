From: David Miller <davem@davemloft.net>
Date: Thu, 14 Aug 2014 23:17:24 +0000
Subject: [GIT] Sparc
Message-Id: <20140814.161724.1511384545281030914.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Hook up the memfd syscall, and properly claim all PCI resources
discovered when building the PCI device tree.

Please pull, thanks a lot!

The following changes since commit f0094b28f3038936c1985be64dbe83f0e950b671:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2014-08-13 18:27:40 -0600)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 10cf15e1d1289aa0bf1d26e9f55176b4c7c5c512:

  sparc: Hook up memfd_create system call. (2014-08-13 22:00:09 -0700)

----------------------------------------------------------------
David S. Miller (4):
      sparc64: Expand PCI bridge probing debug logging.
      sparc64: Skip bogus PCI bridge ranges.
      sparc64: Properly claim resources as each PCI bus is probed.
      sparc: Hook up memfd_create system call.

 arch/sparc/include/uapi/asm/unistd.h |  3 ++-
 arch/sparc/kernel/pci.c              | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/sparc/kernel/systbls_32.S       |  2 +-
 arch/sparc/kernel/systbls_64.S       |  4 ++--
 4 files changed, 71 insertions(+), 5 deletions(-)
