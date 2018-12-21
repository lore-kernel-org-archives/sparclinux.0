From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2018 20:42:43 +0000
Subject: [GIT] Sparc
Message-Id: <20181221.124243.1852216989215465396.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just some small fixes here and there, and a refcount leak in a serial
driver, nothing serious.

Please pull, thanks!

The following changes since commit cf76c364a1e1e5224af80edf70a1e3023e1fcf8c:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-12-05 17:06:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to d430aff8cd0c57502d873909c184e3b5753f8b88:

  serial/sunsu: fix refcount leak (2018-12-21 11:24:38 -0800)

----------------------------------------------------------------
Corentin Labbe (1):
      sparc: Set "ARCH: sunxx" information on the same line

Yangtao Li (1):
      serial/sunsu: fix refcount leak

ndesaulniers@google.com (1):
      sparc: vdso: Drop implicit common-page-size linker flag

 arch/sparc/kernel/setup_32.c | 13 ++++++-------
 arch/sparc/kernel/setup_64.c |  4 ++--
 arch/sparc/vdso/Makefile     |  2 +-
 drivers/tty/serial/sunsu.c   | 31 ++++++++++++++++++++++++++-----
 4 files changed, 35 insertions(+), 15 deletions(-)
