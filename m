From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2008 23:18:01 +0000
Subject: [GIT]: Sparc
Message-Id: <20080922.161801.193342191.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This fixes another missing PCI device bug on sparc64 which
was reported (and successfully tested) by Meelis Roos.

Please pull, thanks a lot!

The following changes since commit 7ee766d8fba9dfd93bf3eca7a8d84a25404a68dc:
  David S. Miller (1):
        sparc64: Fix disappearing PCI devices on e3500.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix missing devices due to PCI bridge test in of_create_pci_dev().

 arch/sparc64/kernel/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
