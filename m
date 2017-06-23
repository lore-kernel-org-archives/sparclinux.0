From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:28 +0000
Subject: [PATCH v2 00/12] Add MDESC & VIO support for VCC
Message-Id: <cover.1498238657.git.jag.raman@oracle.com>
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

This version of the series addresses the following changes
suggested by Dave Miller
Patch 4/5:
 - "name" field in vdev_port md_node_info is declared as "const char *"
 - Code has been modified to dynamically allocate & free "name" in
   vdev_port md_node_info
 - Parameters to mdesc_get_node(), mdesc_get_node_info() &
   mdesc_get_node_ops() have been updated to use "const char *"

Patch 6/5:
 - "node_name" parameter in vio_create_one() has been
   changed to "const char *" type from "char *"
 - Typecasts in vio_create_one() invocations to convert
   "const char *" to "char *" have been removed

Patch 11/5:
 - Invocations of mdesc_node_get() & mdesc_get_node_info()
   have been updated to use the prototypes defined in patch 4/5

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
 arch/sparc/kernel/mdesc.c      |  331 ++++++++++++++++++++++++++++++++++------
 arch/sparc/kernel/vio.c        |  244 ++++++++++++++++--------------
 arch/sparc/kernel/viohs.c      |   24 +++-
 6 files changed, 479 insertions(+), 167 deletions(-)

