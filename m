From: David Miller <davem@davemloft.net>
Date: Fri, 16 May 2008 22:27:58 +0000
Subject: [GIT]: Sparc
Message-Id: <20080516.152758.224883399.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This fixes the regression reported by Mikael Pettersson,
which is in the 2.6.26-rcX regression list.

Please pull, thanks a lot!

The following changes since commit f26a3988917913b3d11b2bd741601a2c64ab9204:
  Linus Torvalds (1):
        Merge branch 'merge' of git://git.kernel.org/.../paulus/powerpc

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Fix lmb_reserve() args in find_ramdisk().
      sparc64: Update defconfig.

 arch/sparc64/defconfig |   40 +++++++++++++++++++++++++++++++---------
 arch/sparc64/mm/init.c |    2 +-
 2 files changed, 32 insertions(+), 10 deletions(-)
