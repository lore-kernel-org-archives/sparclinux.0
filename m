From: David Miller <davem@davemloft.net>
Date: Wed, 08 Apr 2009 23:08:11 +0000
Subject: [GIT]: Sparc
Message-Id: <20090408.160811.93427992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Section mismatch fixes, plus hook up the new preadv/pwritev
system calls.

Please pull, thanks a lot!

The following changes since commit 577c9c456f0e1371cbade38eaf91ae8e8a308555:
  Linus Torvalds (1):
        Linux 2.6.30-rc1

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (7):
      sparc64: get_cells() can't be marked __init
      sparc64: Fix section mismatch warnings in power driver.
      sparc64: Fix section mismatch warnings in PCI controller drivers.
      sparc: Fix section mismatch warnings in cs4231 sound driver.
      serial: sunsu: sunsu_kbd_ms_init needs to be __devinit
      sparc64: add_node_ranges() must be __init
      sparc: Hook up sys_preadv and sys_pwritev

 arch/sparc/include/asm/unistd.h  |    4 +++-
 arch/sparc/kernel/of_device_64.c |    3 +--
 arch/sparc/kernel/pci_fire.c     |    4 ++--
 arch/sparc/kernel/pci_psycho.c   |    8 ++++----
 arch/sparc/kernel/pci_sabre.c    |    8 ++++----
 arch/sparc/kernel/pci_sun4v.c    |   14 +++++++-------
 arch/sparc/kernel/power.c        |    2 +-
 arch/sparc/kernel/systbls_32.S   |    2 +-
 arch/sparc/kernel/systbls_64.S   |    4 ++--
 arch/sparc/mm/init_64.c          |    8 ++++----
 drivers/serial/sunsu.c           |    2 +-
 sound/sparc/cs4231.c             |   28 ++++++++++++++--------------
 12 files changed, 44 insertions(+), 43 deletions(-)
