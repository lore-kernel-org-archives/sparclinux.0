From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2009 08:40:54 +0000
Subject: [GIT]: Sparc
Message-Id: <20090323.014054.210962886.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes.

Thanks!

The following changes since commit 65c24491b4fef017c64e39ec64384fde5e05e0a0:
  Jeff Moyer (1):
        aio: lookup_ioctx can return the wrong value when looking up a bogus context

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Reschedule KGDB capture to a software interrupt.
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/

Mikulas Patocka (1):
      sparc64: Fix crash with /proc/iomem

Scott James Remnant (1):
      sbus: Auto-load openprom module when device opened.

 arch/sparc/include/asm/pil.h   |    1 +
 arch/sparc/kernel/kgdb_64.c    |    2 +-
 arch/sparc/kernel/pci_common.c |    2 +-
 arch/sparc/kernel/ttable.S     |    7 ++++++-
 arch/sparc/mm/ultra.S          |   24 ++----------------------
 drivers/sbus/char/openprom.c   |    1 +
 6 files changed, 12 insertions(+), 25 deletions(-)
