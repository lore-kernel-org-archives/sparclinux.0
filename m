From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:06:51 +0000
Subject: [PATCH v2 00/10] sparc: OF name and device_type rework
Message-Id: <20181116210701.22968-1-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All other platforms have been converted to only store the local node name
in device_node.full_name except Sparc. Sparc was complicated by having a
path_component_name in addition to full_name and name. By switching
full_name to just the local node name, path_component_name becomes
redundant and can be removed.

The rest of the series converts the sparc code to use printf specifiers
and helper functions to access node name and device_type instead of
directly accessing device_node full_name, name and type pointers.

I've tested this series under qemu.

v2:
- Add patch using of_node_name_eq for openpromfs
- Add patch converting some resource names to full_name
- Also drop full path on !Sparc PDT node name construction
- Add a few missed %pOFn conversions

Rob

Rob Herring (10):
  fs/openpromfs: use full_name instead of path_component_name
  fs/openpromfs: Use of_node_name_eq for node name comparisons
  sparc: Convert to using %pOF instead of full_name
  of: Drop full path from full_name for PDT systems
  sparc: prom: use property "name" directly to construct node names
  sparc: Convert to using %pOFn instead of device_node.name
  sparc: Use of_node_name_eq for node name comparisons
  sparc: Use device_type helpers to access the node type
  sparc: Remove unused leon_trans_init
  sparc: Use DT node full_name instead of name for resources

 arch/sparc/include/asm/floppy_64.h   |  8 +--
 arch/sparc/include/asm/leon.h        |  1 -
 arch/sparc/include/asm/parport.h     |  2 +-
 arch/sparc/kernel/auxio_64.c         | 11 ++--
 arch/sparc/kernel/central.c          |  2 +-
 arch/sparc/kernel/chmc.c             |  8 +--
 arch/sparc/kernel/ioport.c           |  2 +-
 arch/sparc/kernel/irq_64.c           |  2 +-
 arch/sparc/kernel/leon_kernel.c      | 14 ------
 arch/sparc/kernel/of_device_32.c     | 21 ++++----
 arch/sparc/kernel/of_device_64.c     | 58 +++++++++++----------
 arch/sparc/kernel/of_device_common.c |  4 +-
 arch/sparc/kernel/pci.c              | 44 +++++++---------
 arch/sparc/kernel/pci_sabre.c        |  2 +-
 arch/sparc/kernel/power.c            |  4 +-
 arch/sparc/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/prom_32.c          | 44 ++++++++--------
 arch/sparc/kernel/prom_64.c          | 75 +++++++++++++++-------------
 arch/sparc/kernel/prom_irqtrans.c    | 20 ++++----
 arch/sparc/kernel/reboot.c           |  3 +-
 arch/sparc/kernel/sbus.c             |  4 +-
 arch/sparc/kernel/sun4d_irq.c        | 14 +++---
 arch/sparc/kernel/time_64.c          | 16 +++---
 arch/sparc/kernel/vio.c              |  9 ++--
 drivers/of/pdt.c                     | 50 ++++++-------------
 fs/openpromfs/inode.c                | 11 ++--
 include/linux/of.h                   |  1 -
 27 files changed, 194 insertions(+), 238 deletions(-)

-- 
2.19.1
