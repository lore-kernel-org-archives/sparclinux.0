From: David Miller <davem@davemloft.net>
Date: Fri, 23 Dec 2011 22:11:12 +0000
Subject: [GIT] Sparc
Message-Id: <20111223.171112.806046844903961542.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this PCI MSI initialization bug fix.

Thanks!

The following changes since commit b3b1b70e62a603f473619dbebc3b3d23f535e6f8:

  Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2011-12-22 12:59:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc64: Fix MSIQ HV call ordering in pci_sun4v_msiq_build_irq().

 arch/sparc/kernel/pci_sun4v.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
