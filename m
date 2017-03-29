From: Jag Raman <jag.raman@oracle.com>
Date: Wed, 29 Mar 2017 21:51:41 +0000
Subject: [PATCH 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <cover.1490823535.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This set of patches is part of an effort to port VCC (Virtual Channel
Concentrator) and VDS (Virtual Disk Server) kernel modules from UEK4
(Unbreakable Enterprise Kernel 4) to the upstream kernel. UEK4 is
one of the kernels used to develop Oracle's virtualization solutions.

The virtualization solutions typically involve the formation of domains,
with one of them (primary domain) managing the other ones (guest
domains). Each domain typically runs an OS.

VCC & VDS enable the virtualization of serial console and storage
respectively, on SPARC processors. VCC provides access to the guest
domain's serial console. VDS provides the ability to allocate storage to
the guest domain.

Both VCC & VDS depend on some core functionalities in the linux kernel for
SPARC. The functionalities include LDC (Logical Domain Channels),
MDESC (Machine Descriptor) and VIO (Virtual IO protocol).

In order for VCC & VDS to be ported over to the kernel upstream, it
requires that gaps in these core functionalities, between UEK4 &
upstream, be bridged.

This set of patches focusses on bridging gaps in LDC functionality.
Changes to MDESC, VIO and ultimately VCC & VDS would follow.

Jag Raman (5):
  sparc64: expand LDC interface
  sparc64: enhance ldc_abort to print message
  sparc64: ensure LDC channel is ready before communication
  sparc64: skip control packet while processing LDC RX queue
  sparc64: print debug messages when reading from LDC channel

 arch/sparc/include/asm/ldc.h |   13 +++
 arch/sparc/kernel/ldc.c      |  178 ++++++++++++++++++++++++++++++++----------
 2 files changed, 148 insertions(+), 43 deletions(-)

