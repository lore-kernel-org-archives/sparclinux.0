From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 18:13:00 +0000
Subject: [PATCH 0/3] sparc32 updates
Message-Id: <20120529181300.GA697@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David.

This small batch fixes:
- leon bootup problem as reported by Daniel
- sparc64 build breakage as reported by Stephen (please verify!)

I was confused by an unused variable - removed.


Boot tested on my ss5 box => OK.

I have powered up my ss20 SMP (which uses HyperSparc CPU's)
box now and will try to reproduce some of the errors
reported by Marcel & Magnus.
The ss20 kernel is still building so no preliminary results...

	Sam

Sam Ravnborg (3):
      sparc32,leon: fix leon bootup
      sparc32: remove unused variable in head_32.S
      sparc: fix sparc64 build due to leon.h inclusion

 arch/sparc/include/asm/leon.h   |    1 +
 arch/sparc/kernel/head_32.S     |   81 ++++++++++++++++++++-------------------
 arch/sparc/kernel/prom_common.c |    1 -
 3 files changed, 42 insertions(+), 41 deletions(-)
