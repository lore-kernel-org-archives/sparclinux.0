From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:32:01 +0000
Subject: [RFC] Add VCC driver to Linux
Message-Id: <cover.1497024581.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds VCC (Virtual Console Concentrator) support to Linux.  VCC 
enables the virtualization of serial console on SPARC processors. VCC 
provides access to the guest domain's serial console.

This patch would be broken down into multiple smaller patches. It will
also be cleaned up for style related errors. It hopefully provides a 
sense of how the APIs added previously are used.

Jag Raman (1):
  sparc64: Add virtual console server support

 arch/sparc/configs/sparc64_defconfig |    1 +
 arch/sparc/include/asm/vio.h         |    9 +
 arch/sparc/kernel/ldc.c              |    2 +
 arch/sparc/kernel/vio.c              |    1 +
 arch/sparc/kernel/viohs.c            |   12 +-
 drivers/tty/Kconfig                  |    5 +
 drivers/tty/Makefile                 |    1 +
 drivers/tty/vcc.c                    | 1193 ++++++++++++++++++++++++++++++++++
 8 files changed, 1221 insertions(+), 3 deletions(-)
 create mode 100644 drivers/tty/vcc.c

