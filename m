From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 02:17:54 +0000
Subject: [GIT]: Sparc
Message-Id: <20100313.181754.107699673.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


A framebuffer driver for XVR-1000 cards and a fixup for the string
used in a request_irq() call in a sparc qlogicpti scsi driver (it
contained a "/" character so procfs rightly complains).

Please pull, thanks a lot!

The following changes since commit d89b218b801fd93ea95880f1c7fde348cbcc51c5:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Add very basic XVR-1000 framebuffer driver.

Meelis Roos (1):
      qlogicpti: Remove slash in QlogicPTI irq name

 drivers/scsi/qlogicpti.c   |    2 +-
 drivers/video/Kconfig      |   12 +++
 drivers/video/Makefile     |    1 +
 drivers/video/sunxvr1000.c |  228 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+), 1 deletions(-)
 create mode 100644 drivers/video/sunxvr1000.c
