From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Wed, 02 Dec 2009 14:30:19 +0000
Subject: [PATCH 0/3] sparc,leon: SPARC/LEON cleanup patches
Message-Id: <1259764222-1802-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

These patches remove warnings and do some minor cleanup.

I dropped the idprom patch. We fake one in the boot loader.

Kristoffer Glembo (3):
  sparc,leon: Added Aeroflex Gaisler in manufacturer_info structure
  sparc32: Remove early interrupt enable.
  sparc,leon: init_leon srmmu cleanup

 arch/sparc/kernel/cpu.c     |   11 +++++++++++
 arch/sparc/kernel/time_32.c |    3 ---
 arch/sparc/mm/srmmu.c       |    4 +---
 3 files changed, 12 insertions(+), 6 deletions(-)

