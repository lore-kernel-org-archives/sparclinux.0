From: David Miller <davem@davemloft.net>
Date: Thu, 01 Feb 2018 15:20:38 +0000
Subject: [GIT] Sparc
Message-Id: <20180201.102038.1412916523456522737.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get the following sparc changes for the merge window.

Of note is the addition of a driver for the Data Analytics
Accelerator, and some small cleanups.

Thanks!

The following changes since commit 0d665e7b109d512b7cae3ccef6e8654714887844:

  mm, page_vma_mapped: Drop faulty pointer arithmetics in check_pte() (2018-01-21 17:44:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git 

for you to fetch changes up to 2d85ec8acb01601a216b6c591cab63bfaacd2083:

  oradax: Fix return value check in dax_attach() (2018-01-29 14:28:48 -0500)

----------------------------------------------------------------
Dan Carpenter (1):
      sparc: vDSO: remove an extra tab

David S. Miller (1):
      Merge branch 'sparc64-dax-support'

Rob Gardner (2):
      sparc64: Oracle DAX infrastructure
      sparc64: Oracle DAX driver

Rolf Eike Beer (1):
      sparc64: drop unneeded compat include

Wei Yongjun (1):
      oradax: Fix return value check in dax_attach()

 Documentation/sparc/oradax/dax-hv-api.txt | 1433 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/sparc/oradax/oracle-dax.txt |  429 +++++++++++++++++++++++
 arch/sparc/include/asm/hypervisor.h       |  138 ++++++++
 arch/sparc/include/uapi/asm/oradax.h      |   91 +++++
 arch/sparc/kernel/hvapi.c                 |    1 +
 arch/sparc/kernel/hvcalls.S               |   57 ++++
 arch/sparc/kernel/signal_64.c             |    3 -
 arch/sparc/vdso/vma.c                     |    2 +-
 drivers/sbus/char/Kconfig                 |    8 +
 drivers/sbus/char/Makefile                |    1 +
 drivers/sbus/char/oradax.c                | 1005 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 11 files changed, 3164 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/sparc/oradax/dax-hv-api.txt
 create mode 100644 Documentation/sparc/oradax/oracle-dax.txt
 create mode 100644 arch/sparc/include/uapi/asm/oradax.h
 create mode 100644 drivers/sbus/char/oradax.c
