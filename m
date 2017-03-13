From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 13 Mar 2017 16:44:35 +0000
Subject: [PATCH v2 0/4] Improved logging
Message-Id: <1489423479-654395-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Changes from v1 - v2:
Two small nits:
- "Reviewed-by" is fixed in two patches,
- Fixed comment before __weak plat_unregister_bootcon(): of -> if.

This patch set does the following improvements:
1. Get time stamps available early in boot
2. Removes duplicated output on console during boot
3. Removes a dead zone, where after tty0 nothing is printed until
   ttyHV is regested; and even if we panic no messages are printed.

Here is example base output:
https://hastebin.com/obofesaqek.vbs

Fixed output:
https://hastebin.com/ipoxodobaq.vbs

Pavel Tatashin (4):
  sparc64: initialize time early
  sparc64: allow platforms to say when to unload boot console
  sparc64: remove trailing white spaces
  sparc64: stop duplicating boot messages

 arch/sparc/include/asm/setup.h |    3 +-
 arch/sparc/kernel/kernel.h     |    3 ++
 arch/sparc/kernel/setup_64.c   |   69 ++++++++++++++++++++++++++++++++++++++--
 arch/sparc/kernel/time_64.c    |   60 ++++++++++++++++++++++-------------
 drivers/tty/serial/sunhv.c     |    2 +-
 kernel/printk/printk.c         |   17 ++++++++--
 6 files changed, 124 insertions(+), 30 deletions(-)

