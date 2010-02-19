From: David Miller <davem@davemloft.net>
Date: Fri, 19 Feb 2010 07:29:28 +0000
Subject: [GIT]: Sparc
Message-Id: <20100218.232928.193699814.davem@davemloft.net>
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

The following changes since commit b0483e78e5c4c9871fc5541875b3bc006846d46b:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../gregkh/tty-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Tighten checks in kstack_valid().
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: Sync of_create_pci_dev() with drivers/pci/probe.c changes.

Kristoffer Glembo (1):
      sparc: Fix incorrect comparison in of_bus_ambapp_match()

 arch/sparc/kernel/kstack.h       |    4 ++++
 arch/sparc/kernel/of_device_32.c |    2 +-
 arch/sparc/kernel/pci.c          |    7 +++++++
 3 files changed, 12 insertions(+), 1 deletions(-)
