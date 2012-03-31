From: David Miller <davem@davemloft.net>
Date: Sat, 31 Mar 2012 01:37:48 +0000
Subject: [GIT] Sparc
Message-Id: <20120330.213748.222624235259680298.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Like last night's 64-bit fixes, this fixes the build regressions
on the 32-bit side too, thanks to Sam Ravnborg.

Please pull, thanks a lot.

The following changes since commit 623ff7739e7c00fa3d55dbfd42a492a68298fd7a:

  Merge tag 'for-linus-3.4' of git://git.infradead.org/mtd-2.6 (2012-03-30 17:31:56 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to bde4d8b205bc3ccdf7f5a841bfbfa9896b44b1ce:

  sparc32: fix fallout from system.h removal (2012-03-30 18:16:58 -0700)

----------------------------------------------------------------
Sam Ravnborg (1):
      sparc32: fix fallout from system.h removal

 arch/sparc/include/asm/ptrace.h |    1 +
 arch/sparc/kernel/sun4d_smp.c   |    1 +
 arch/sparc/kernel/sun4m_smp.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)
