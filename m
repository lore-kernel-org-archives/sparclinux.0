From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:49 +0000
Subject: [PATCH 0/4] section name cleanup for sparc
Message-Id: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>

This patch series cleans up the section names on the sparc
architecture.  It requires the architecture-independent macro
definitions from this patch series:

<http://www.spinics.net/lists/mips/msg33499.html>

The long-term goal here is to add support for building the kernel with
-ffunction-sections -fdata-sections.  This requires renaming all the
magic section names in the kernel of the form .text.foo, .data.foo,
.bss.foo, and .rodata.foo to not have collisions with sections
generated for code like:

static int nosave = 0; /* -fdata-sections places in .data.nosave */
static void head(); /* -ffunction-sections places in .text.head */

Note that these patches have not been boot-tested (aside from testing
the analogous changes on x86), since I don't have access to the
appropriate hardware.

	-Tim Abbott


Tim Abbott (4):
  sparc: use new macro for .data.cacheline_aligned section.
  sparc: use new macros for .data.init_task.
  sparc: use new macro for .data.read_mostly section.
  sparc: convert to new generic read_mostly support.

 arch/sparc/Kconfig              |    3 +++
 arch/sparc/include/asm/cache.h  |    2 --
 arch/sparc/kernel/init_task.c   |    5 ++---
 arch/sparc/kernel/vmlinux.lds.S |   16 +++-------------
 4 files changed, 8 insertions(+), 18 deletions(-)

