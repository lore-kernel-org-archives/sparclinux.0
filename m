From: David Miller <davem@davemloft.net>
Date: Tue, 19 Nov 2013 22:18:58 +0000
Subject: [GIT] Sparc
Message-Id: <20131119.171858.625621283989173777.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two merge window fallout build fixes, please pull, thanks a lot!

The following changes since commit 2d3c627502f2a9b0a7de06a5a2df2365542a72c9:

  Revert "init/Kconfig: add option to disable kernel compression" (2013-11-17 11:17:36 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 6a328f3fe042396c6525d7bf84cfd941440cc045:

  sparc64: merge fix (2013-11-18 15:08:52 -0800)

----------------------------------------------------------------
Kirill A. Shutemov (1):
      sparc64: fix build regession

Stephen Rothwell (1):
      sparc64: merge fix

 arch/sparc/include/asm/tlbflush_64.h | 1 -
 arch/sparc/mm/init_64.c              | 2 --
 2 files changed, 3 deletions(-)
