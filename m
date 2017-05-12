From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 12 May 2017 01:30:48 +0000
Subject: [PATCH v2 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <cover.1494551284.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Version 2 of patch-set to enable LDC to support VCC driver. Version 2 addresses
the following changes suggested by Dave Miller
Patch 1/5: enable_irq()/disable_irq() used to enable/disable HV interrupts
Patch 4/5: Commit message adds more detail to justify the change

Jag Raman (5):
  sparc64: expand LDC interface
  sparc64: enhance ldc_abort to print message
  sparc64: ensure LDC channel is ready before communication
  sparc64: ldc abort during vds iso boot
  sparc64: print debug messages when reading from LDC channel

 arch/sparc/include/asm/ldc.h |   10 +++
 arch/sparc/kernel/ldc.c      |  176 +++++++++++++++++++++++++++++++----------
 2 files changed, 143 insertions(+), 43 deletions(-)

