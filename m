From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:29:27 +0000
Subject: [PATCH v4 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <cover.1497022394.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This series of patches is part of an effort to add VCC (Virtual Console
Concentrator) support to Linux.

VCC enables the virtualization of serial console on SPARC processors. VCC 
provides access to the guest domain's serial console.

VCC depends on some core functionalities in the linux kernel for SPARC. The 
functionalities include LDC (Logical Domain Channels), MDESC (Machine
Descriptor) and VIO (Virtual IO protocol). In order for VCC to be enabled,
it requires that these core functionalities support them.

This series of patches adds LDC support to enable VCC on Linux. It
is the first batch of changes to enable VCC.

This version 4 of the series addresses the following changes
suggested by Dave Miller
Patch 1/5: Modifies ldc_print/__ldc_print to print caller name. Fixes
           indentation of wrapped lines.

Jag Raman (5):
  sparc64: expand LDC interface
  sparc64: enhance ldc_abort to print message
  sparc64: ensure LDC channel is ready before communication
  sparc64: ldc abort during vds iso boot
  sparc64: print debug messages when reading from LDC channel

 arch/sparc/include/asm/ldc.h |    8 +++
 arch/sparc/kernel/ldc.c      |  141 +++++++++++++++++++++++++++++-------------
 2 files changed, 106 insertions(+), 43 deletions(-)

