From: David Miller <davem@davemloft.net>
Date: Mon, 02 May 2016 05:10:57 +0000
Subject: [GIT] Sparc
Message-Id: <20160502.011057.340689220340931750.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Fix panics with SR-IOV, from Babu Moger.

2) Wire up preadv2/pwritev2.

3) Allow proper auto-loading of VIO devices, from John Paul Adrian
   Glaubitz.

4) Recognize Sonoma cpus, from Khalid Aziz.

5) Fix bootup regressions caused by syscall trace fixes made recently.

Please pull, thanks a lot!

The following changes since commit 1993b176a8224e371e0732ffada7ab9eb3b0912b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ide (2016-03-28 15:17:02 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 49fa5230462f9f2c4e97c81356473a6bdf06c422:

  sparc64: Fix bootup regressions on some Kconfig combinations. (2016-04-27 17:27:37 -0400)

----------------------------------------------------------------
Adrian Glaubitz (2):
      sparc: Implement and wire up modalias_show for vio.
      sparc: Implement and wire up vio_hotplug for vio.

Babu Moger (1):
      sparc/PCI: Fix for panic while enabling SR-IOV

Borislav Petkov (1):
      sparc/defconfigs: Remove CONFIG_IPV6_PRIVACY

David S. Miller (2):
      sparc: Write up preadv2/pwritev2 syscalls.
      sparc64: Fix bootup regressions on some Kconfig combinations.

Khalid Aziz (1):
      sparc64: recognize and support Sonoma CPU type

Sowmini Varadhan (1):
      sparc/pci: Refactor dev_archdata initialization into pci_init_dev_archdata

 arch/sparc/configs/sparc32_defconfig |  1 -
 arch/sparc/configs/sparc64_defconfig |  1 -
 arch/sparc/include/asm/spitfire.h    |  1 +
 arch/sparc/include/uapi/asm/unistd.h |  4 +++-
 arch/sparc/kernel/cherrs.S           | 14 +++++---------
 arch/sparc/kernel/cpu.c              |  6 ++++++
 arch/sparc/kernel/cpumap.c           |  1 +
 arch/sparc/kernel/fpu_traps.S        | 11 +++++------
 arch/sparc/kernel/head_64.S          | 32 ++++++++++++++++----------------
 arch/sparc/kernel/misctrap.S         | 12 ++++--------
 arch/sparc/kernel/pci.c              | 42 ++++++++++++++++++++++++++++++++++++------
 arch/sparc/kernel/setup_64.c         |  7 ++++++-
 arch/sparc/kernel/spiterrs.S         | 18 ++++++------------
 arch/sparc/kernel/systbls_32.S       |  2 +-
 arch/sparc/kernel/systbls_64.S       |  4 ++--
 arch/sparc/kernel/utrap.S            |  3 +--
 arch/sparc/kernel/vio.c              | 18 ++++++++++++++++++
 arch/sparc/kernel/vmlinux.lds.S      |  4 ++++
 arch/sparc/kernel/winfixup.S         |  3 +--
 arch/sparc/mm/init_64.c              |  3 +++
 20 files changed, 119 insertions(+), 68 deletions(-)
