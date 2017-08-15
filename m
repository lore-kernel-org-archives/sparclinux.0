From: Jag Raman <jag.raman@oracle.com>
Date: Tue, 15 Aug 2017 21:02:56 +0000
Subject: [PATCH v2 00/13] Enable Virtual Console Concentrator (VCC)
Message-Id: <cover.1502829972.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Patchset to enable Virtual Console Concentrator (VCC). VCC provides
access to the serial console of a guest domain. It creates a RAW
VIO/LDC link between the guest domain & primary through which serial
console data is shared.

This set addresses feedback provided by Dave Miller. Cleanup of
driver state is also addressed in this set. Patches updated
are 4, 5, 6 & 7.

version3:
 - PATCH 04/13: delete VIO timer during removal
 - PATCH 05/13: remove sysfs attr group during cleanup
 - PATCH 06/13: Timer access macros replaced with direct
                access. Timer routines check if VCC is
                removed. Delete timer during cleanup
 - PATCH 07/13: avoid explicit typecast of void pointer

Jag Raman (13):
  sparc64: vcc: Enable VCC module in linux
  sparc64: vcc: Add VCC debug message macros
  sparc64: vcc: TTY driver initialization and cleanup
  sparc64: vcc: Enable VCC port probe and removal
  sparc64: vcc: Create sysfs attribute group
  sparc64: vcc: Add RX & TX timer for delayed LDC operation
  sparc64: vcc: Enable LDC event processing engine
  sparc64: vcc: Add open & close TTY operations
  sparc64: vcc: Add hangup TTY operation
  sparc64: vcc: Add write & write_room TTY operations
  sparc64: vcc: Add chars_in_buffer TTY operation
  sparc64: vcc: Add break_ctl TTY operation
  sparc64: vcc: Add install & cleanup TTY operations

 MAINTAINERS                          |    1 +
 arch/sparc/configs/sparc64_defconfig |    1 +
 arch/sparc/include/asm/vio.h         |    9 +
 arch/sparc/kernel/ldc.c              |    2 +
 arch/sparc/kernel/vio.c              |    1 +
 arch/sparc/kernel/viohs.c            |   12 +-
 drivers/tty/Kconfig                  |    5 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/vcc.c                    | 1155 ++++++++++++++++++++++++++++++++++
 9 files changed, 1184 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/vcc.c

