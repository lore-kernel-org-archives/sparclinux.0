From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2018 18:28:09 +0000
Subject: [GIT] Sparc
Message-Id: <20181025.112809.1174535381380570860.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this build regression fix.

Thank you.

The following changes since commit 44adbac8f7217040be97928cd19998259d9d4418:

  Merge branch 'work.tty-ioctl' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2018-10-24 14:43:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to caf539cd1087f7c36b9c4df271575e9aee49fde5:

  sparc: Fix VDSO build with older binutils. (2018-10-25 10:36:19 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Fix VDSO build with older binutils.

 arch/sparc/include/asm/vdso.h       |   2 --
 arch/sparc/vdso/vclock_gettime.c    | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 arch/sparc/vdso/vdso-layout.lds.S   |   3 --
 arch/sparc/vdso/vdso.lds.S          |   2 ++
 arch/sparc/vdso/vdso2c.h            |  17 +---------
 arch/sparc/vdso/vdso32/vdso32.lds.S |   2 ++
 arch/sparc/vdso/vma.c               | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 7 files changed, 335 insertions(+), 62 deletions(-)
