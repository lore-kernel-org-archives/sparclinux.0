From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:49 +0000
Subject: [PATCH v1 00/12] Add MDESC & VIO support for VCC
Message-Id: <cover.1497024216.git.jag.raman@oracle.com>
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

This series of patches adds MDESC & VIO support to enable VCC on Linux. It
is the second batch of changes to enable VCC.

Jag Raman (12):
  sparc64: ensure VIO operations are defined while being used
  sparc64: specify the device class in VIO version info. packet
  sparc64: skip handshake for LDC channels in RAW mode
  sparc64: expand MDESC interface
  sparc64: mdesc: use __GFP_REPEAT action modifier for VM allocation
  sparc64: add MDESC node name property to VIO device metadata
  sparc64: refactor code to obtain cfg_handle property from MDESC
  sparc64: remove restriction on VIO device name size
  sparc64: check if a client is allowed to register for MDESC
    notifications
  sparc64: enhance VIO device probing
  sparc64: Enhance search for VIO device in MDESC
  sparc64: add port_id to VIO device metadata

 arch/sparc/include/asm/mdesc.h |   24 +++-
 arch/sparc/include/asm/vio.h   |   13 ++-
 arch/sparc/kernel/ldc.c        |   10 ++
 arch/sparc/kernel/mdesc.c      |  283 +++++++++++++++++++++++++++++++++-------
 arch/sparc/kernel/vio.c        |  245 +++++++++++++++++++----------------
 arch/sparc/kernel/viohs.c      |   24 +++-
 6 files changed, 431 insertions(+), 168 deletions(-)

