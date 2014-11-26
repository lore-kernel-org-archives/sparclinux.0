From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2014 21:42:47 +0000
Subject: [GIT] Sparc
Message-Id: <20141126.164247.2147782917285716161.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc fix to add dma_cache_sync(), even if a
nop it should be provided if dma_{alloc,free}_noncoherent() is
provided too, thanks!

The following changes since commit b914c5b2130239fd378d1a719ab3c53f0c782be9:

  Merge branch 'for-3.18' of git://linux-nfs.org/~bfields/linux (2014-11-25 19:05:41 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 0d1d9092b536859a333ee96cff4df0ee24b55190:

  sparc: Add NOP dma_cache_sync() implementation. (2014-11-26 13:36:41 -0800)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Add NOP dma_cache_sync() implementation.

 arch/sparc/include/asm/dma-mapping.h | 8 ++++++++
 1 file changed, 8 insertions(+)
