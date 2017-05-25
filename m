From: Jag Raman <jag.raman@oracle.com>
Date: Thu, 25 May 2017 14:25:53 +0000
Subject: [PATCH v3 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <cover.1495721691.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This series of patches is part of an effort to add VCC (Virtual Channel
Concentrator) and VDS (Virtual Disk Server) support to Linux.

VCC & VDS enable the virtualization of serial console and storage
respectively, on SPARC processors. VCC provides access to the guest
domain's serial console. VDS provides the ability to allocate storage to
the guest domain.

Both VCC & VDS depend on some core functionalities in the linux kernel for
SPARC. The functionalities include LDC (Logical Domain Channels),
MDESC (Machine Descriptor) and VIO (Virtual IO protocol). In order for
VCC & VDS to be enabled, it requires that these core functionalities
support them.

This version 3 of the series addresses the following changes
suggested by Dave Miller
Patch 1/5: Removes ldc_enable_hv_intr & ldc_disable_hv_intr APIs

Jag Raman (5):
  sparc64: expand LDC interface
  sparc64: enhance ldc_abort to print message
  sparc64: ensure LDC channel is ready before communication
  sparc64: ldc abort during vds iso boot
  sparc64: print debug messages when reading from LDC channel

 arch/sparc/include/asm/ldc.h |    6 ++
 arch/sparc/kernel/ldc.c      |  145 +++++++++++++++++++++++++++++------------
 2 files changed, 108 insertions(+), 43 deletions(-)

