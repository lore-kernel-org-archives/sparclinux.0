From: David Miller <davem@davemloft.net>
Date: Sat, 20 Feb 2010 00:23:21 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20100219.162321.120454944.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100218.232928.193699814.davem@davemloft.net>
In-Reply-To: <20100218.232928.193699814.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 18 Feb 2010 23:29:28 -0800 (PST)

> The following changes since commit b0483e78e5c4c9871fc5541875b3bc006846d46b:
>   Linus Torvalds (1):
>         Merge git://git.kernel.org/.../gregkh/tty-2.6
> 
> are available in the git repository at:
> 
>   master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Linus, I've added a critical ITLB PTE execute bit handling fix
so if you've pulled already, please pull again.

Thanks!

The following changes since commit f8b55f251012e104093e105483c45c5d85ad3040:
  Christine Caulfield (1):
        Orphan DECnet

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc64: Tighten checks in kstack_valid().
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: Sync of_create_pci_dev() with drivers/pci/probe.c changes.
      sparc64: Fix sun4u execute bit check in TSB I-TLB load.

Kristoffer Glembo (1):
      sparc: Fix incorrect comparison in of_bus_ambapp_match()

 arch/sparc/kernel/kstack.h       |    4 ++++
 arch/sparc/kernel/of_device_32.c |    2 +-
 arch/sparc/kernel/pci.c          |    7 +++++++
 arch/sparc/kernel/tsb.S          |    6 ++++--
 4 files changed, 16 insertions(+), 3 deletions(-)
