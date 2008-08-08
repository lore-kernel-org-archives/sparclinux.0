From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2008 06:20:08 +0000
Subject: [GIT]: Sparc
Message-Id: <20080807.232008.234054866.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc updates and bug fixes.

Thanks a lot!

The following changes since commit 0967d61ea0d8e8a7826bd8949cd93dd1e829ac55:
  Linus Torvalds (1):
        Linux 2.6.27-rc2

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Alexander Beregalov (1):
      sparc: i8042-sparcio.h: fix warning

David S. Miller (2):
      sparc64: Use kernel/uid16.c helpers instead of own copy.
      sparc64: Fix end-of-stack checking in save_stack_trace().

Stephen Rothwell (2):
      of/sparc: remove include of linux/of_platform.h from asm/of_platform.h
      sparc: don't use asm/of_device.h

 arch/sparc/include/asm/ebus_32.h     |    2 +-
 arch/sparc/include/asm/ebus_64.h     |    3 +-
 arch/sparc/include/asm/of_platform.h |    3 -
 arch/sparc/include/asm/parport.h     |    3 +-
 arch/sparc/include/asm/sbus_32.h     |    2 +-
 arch/sparc/include/asm/sbus_64.h     |    2 +-
 arch/sparc/kernel/ioport.c           |    2 +-
 arch/sparc/kernel/time.c             |    2 +-
 arch/sparc64/kernel/auxio.c          |    2 +-
 arch/sparc64/kernel/ebus.c           |    2 +-
 arch/sparc64/kernel/pci_common.c     |    2 +-
 arch/sparc64/kernel/pci_psycho.c     |    2 +-
 arch/sparc64/kernel/pci_sabre.c      |    2 +-
 arch/sparc64/kernel/pci_schizo.c     |    2 +-
 arch/sparc64/kernel/power.c          |    2 +-
 arch/sparc64/kernel/prom.c           |    2 +-
 arch/sparc64/kernel/stacktrace.c     |    6 +-
 arch/sparc64/kernel/sys_sparc32.c    |  176 ----------------------------------
 arch/sparc64/kernel/systbls.S        |   20 ++--
 arch/sparc64/kernel/time.c           |    2 +-
 drivers/input/serio/i8042-sparcio.h  |   19 +++-
 21 files changed, 45 insertions(+), 213 deletions(-)
