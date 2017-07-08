From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jul 2017 10:40:15 +0000
Subject: [GIT] Sparc
Message-Id: <20170708.114015.1063430720145028256.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) Queued spinlocks and rwlocks for sparc64, from Babu Moger.

2) Some const'ification from Arvind Yadav.

3) LDC/VIO driver infrastructure changes to facilitate future
   upcoming drivers, from Jag Raman.

4) Initialize sched_clock() et al. early so that the initial printk
   timestamps are all done while the implementation is available and
   functioning.  From Pavel Tatashin.

Please pull, thanks a lot!

The following changes since commit 5faab9e0f03c4eef97886b45436015e107f79f5f:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2017-06-10 11:09:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next.git 

for you to fetch changes up to 0cd52df8a782be2e6592d331094a313d8947683a:

  sparc: kernel: pmc: make of_device_ids const. (2017-07-03 02:53:07 -0700)

----------------------------------------------------------------
Arvind Yadav (3):
      sparc/time: make of_device_ids const
      sparc: kernel: apc: make of_device_ids const
      sparc: kernel: pmc: make of_device_ids const.

Babu Moger (7):
      arch/sparc: Remove the check #ifndef __LINUX_SPINLOCK_TYPES_H
      kernel/locking: Fix compile error with qrwlock.c
      arch/sparc: Define config parameter CPU_BIG_ENDIAN
      arch/sparc: Introduce cmpxchg_u8 SPARC
      arch/sparc: Enable queued rwlocks for SPARC
      arch/sparc: Introduce xchg16 for SPARC
      arch/sparc: Enable queued spinlock support for SPARC

David S. Miller (6):
      Merge branch 'sparc64-queued-locks'
      Merge git://git.kernel.org/.../davem/sparc
      Merge branch 'sparc64-LDC-changes-for-porting-VCC-driver-into-upstream-kernel'
      Merge branch 'sparc64-early-boot-timestamp'
      Merge branch 'sparc64-early-boot-timestamp-fixes'
      Merge branch 'sparc64-add-MDESC-and-VIO-support-for-VCC'

Jag Raman (17):
      sparc64: expand LDC interface
      sparc64: enhance ldc_abort to print message
      sparc64: ensure LDC channel is ready before communication
      sparc64: ldc abort during vds iso boot
      sparc64: print debug messages when reading from LDC channel
      sparc64: ensure VIO operations are defined while being used
      sparc64: specify the device class in VIO version info. packet
      sparc64: skip handshake for LDC channels in RAW mode
      sparc64: expand MDESC interface
      sparc64: mdesc: use __GFP_REPEAT action modifier for VM allocation
      sparc64: add MDESC node name property to VIO device metadata
      sparc64: refactor code to obtain cfg_handle property from MDESC
      sparc64: remove restriction on VIO device name size
      sparc64: check if a client is allowed to register for MDESC notifications
      sparc64: enhance VIO device probing
      sparc64: Enhance search for VIO device in MDESC
      sparc64: add port_id to VIO device metadata

Pavel Tatashin (11):
      sparc64: remove trailing white spaces
      sparc64: access tick function from variable
      sparc64: show time stamps from zero
      sparc64: optimize loads in clock_sched()
      sparc64: improve modularity tick options
      sparc64: initialize time early
      sparc64: add hot-patched and inlined get_tick()
      sparc64: optimize functions that access tick
      sparc64: use prom interface to get %stick frequency
      sparc64: broken %tick frequency on spitfire cpus
      sparc64: fix typo in property

 arch/sparc/Kconfig                      |   5 ++
 arch/sparc/include/asm/cmpxchg_64.h     |  76 +++++++++++++++--
 arch/sparc/include/asm/ldc.h            |   8 ++
 arch/sparc/include/asm/mdesc.h          |  24 +++++-
 arch/sparc/include/asm/qrwlock.h        |   7 ++
 arch/sparc/include/asm/qspinlock.h      |   7 ++
 arch/sparc/include/asm/setup.h          |   2 +-
 arch/sparc/include/asm/spinlock_64.h    | 208 +---------------------------------------------
 arch/sparc/include/asm/spinlock_types.h |  12 ++-
 arch/sparc/include/asm/timer_64.h       |  67 +++++++++++++++
 arch/sparc/include/asm/vio.h            |  13 ++-
 arch/sparc/kernel/apc.c                 |   2 +-
 arch/sparc/kernel/kernel.h              |   3 +
 arch/sparc/kernel/ldc.c                 | 151 +++++++++++++++++++++++----------
 arch/sparc/kernel/mdesc.c               | 331 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 arch/sparc/kernel/pmc.c                 |   2 +-
 arch/sparc/kernel/prom_64.c             |   2 +-
 arch/sparc/kernel/setup_64.c            |   7 +-
 arch/sparc/kernel/time_32.c             |   2 +-
 arch/sparc/kernel/time_64.c             | 179 +++++++++++++++++++++++++++------------
 arch/sparc/kernel/vio.c                 | 244 +++++++++++++++++++++++++++++-------------------------
 arch/sparc/kernel/viohs.c               |  24 ++++--
 arch/sparc/kernel/vmlinux.lds.S         |   5 ++
 kernel/locking/qrwlock.c                |   1 +
 24 files changed, 890 insertions(+), 492 deletions(-)
 create mode 100644 arch/sparc/include/asm/qrwlock.h
 create mode 100644 arch/sparc/include/asm/qspinlock.h
