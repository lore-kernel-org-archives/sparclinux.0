From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 24 Feb 2021 22:59:46 +0000
Subject: [git pull] work.sparc32
Message-Id: <YDbaYnzBVf604ns3@zeniv-ca.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

	Switching sparc32 to generic extables.  A bunch of magic goes away,
along with ARCH_HAS_SEARCH_EXTABLE.  Sat in -next for a couple of cycles
by now...

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sparc32

for you to fetch changes up to 73686e787b495a85551e2e99c459adde6836eb31:

  Merge remote-tracking branch 'sparc/master' into work.sparc32 (2021-01-03 20:07:31 -0500)

----------------------------------------------------------------
Al Viro (7):
      sparc32: don't bother with lookup_fault() in __bzero()
      sparc32: kill lookup_fault()
      sparc32: switch __bzero() away from range exception table entries
      sparc32: get rid of range exception table entries in checksum_32.S
      sparc32: switch copy_user.S away from range exception table entries
      sparc32: switch to generic extables
      Merge remote-tracking branch 'sparc/master' into work.sparc32

 arch/sparc/Kconfig                                 |   2 +-
 arch/sparc/boot/piggyback.c                        |   4 +
 arch/sparc/include/asm/backoff.h                   |   2 +-
 arch/sparc/include/asm/elf_64.h                    |   1 -
 arch/sparc/include/asm/{extable_64.h => extable.h} |   4 +-
 arch/sparc/include/asm/pgtsrmmu.h                  |   2 +-
 arch/sparc/include/asm/uaccess.h                   |   3 +
 arch/sparc/include/asm/uaccess_32.h                |  38 ---
 arch/sparc/include/asm/uaccess_64.h                |   1 -
 arch/sparc/kernel/pci.c                            |   3 +-
 arch/sparc/kernel/unaligned_32.c                   |  10 +-
 arch/sparc/kernel/viohs.c                          |   6 +-
 arch/sparc/lib/checksum_32.S                       |  64 ++---
 arch/sparc/lib/copy_user.S                         | 315 ++++++++-------------
 arch/sparc/lib/memset.S                            |  86 +++---
 arch/sparc/mm/Makefile                             |   2 +-
 arch/sparc/mm/extable.c                            | 107 -------
 arch/sparc/mm/fault_32.c                           |  80 +-----
 arch/sparc/mm/mm_32.h                              |   2 -
 arch/sparc/mm/srmmu.c                              |  18 +-
 lib/extable.c                                      |   5 -
 21 files changed, 212 insertions(+), 543 deletions(-)
 rename arch/sparc/include/asm/{extable_64.h => extable.h} (92%)
 delete mode 100644 arch/sparc/mm/extable.c
