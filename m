From: David Miller <davem@davemloft.net>
Date: Mon, 13 Oct 2008 07:00:17 +0000
Subject: [GIT]: Sparc
Message-Id: <20081013.000017.171095053.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Bug fixes:

1) The change adding notify_cpu_starting() broke the sparc32 build
   (fix from Robert Reif), and missed adding the hook to sparc64.

2) chmc driver module init can crash on sun4v systems, because reading
   the %ver register is illegal on those chips, but since we didn't
   mark the %ver register asm with __volatile__ gcc could move it
   before the platform type guard test

Please pull, thanks a lot!

The following changes since commit 4480f15b3306f43bbb0310d461142b4e897ca45b:
  Randy Dunlap (1):
        MAINTAINERS: remove colon from headings

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Add missing notify_cpu_starting() call.
      chmc: Mark %ver register inline asm with __volatile__

Robert Reif (1):
      sparc32: fix build errors

 arch/sparc/kernel/sun4d_smp.c |    1 +
 arch/sparc/kernel/sun4m_smp.c |    1 +
 arch/sparc64/kernel/chmc.c    |    2 +-
 arch/sparc64/kernel/smp.c     |    4 ++++
 4 files changed, 7 insertions(+), 1 deletions(-)
