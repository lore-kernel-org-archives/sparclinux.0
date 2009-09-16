From: David Miller <davem@davemloft.net>
Date: Wed, 16 Sep 2009 08:43:04 +0000
Subject: [GIT]: Sparc
Message-Id: <20090916.014304.54377480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This kills off the long unnecessary sparc PROM console driver, and
updates the default configs.

Please pull, thanks a lot!

The following changes since commit 0cb583fd2862f19ea88b02eb307d11c09e51e2f8:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/ide-next-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc: Kill PROM console driver.
      sparc: Update defconfigs.

 Documentation/dontdiff               |    1 -
 arch/sparc/configs/sparc32_defconfig |   44 ++-
 arch/sparc/configs/sparc64_defconfig |   51 ++--
 arch/sparc/kernel/setup_32.c         |    2 -
 arch/sparc/kernel/setup_64.c         |    2 -
 drivers/char/vt.c                    |    3 -
 drivers/video/console/.gitignore     |    2 -
 drivers/video/console/Kconfig        |    9 +-
 drivers/video/console/Makefile       |   12 -
 drivers/video/console/prom.uni       |   11 -
 drivers/video/console/promcon.c      |  598 ----------------------------------
 scripts/Makefile                     |    1 -
 12 files changed, 56 insertions(+), 680 deletions(-)
 delete mode 100644 drivers/video/console/.gitignore
 delete mode 100644 drivers/video/console/prom.uni
 delete mode 100644 drivers/video/console/promcon.c
