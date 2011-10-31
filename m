From: David Miller <davem@davemloft.net>
Date: Mon, 31 Oct 2011 08:32:05 +0000
Subject: [GIT] Sparc
Message-Id: <20111031.043205.1749829212092506403.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Not very exciting stuff, basically just bug fixes.

1) Make memcpy on sparc32 properly return original dst pointer.

2) Fix VIS vector comparison instruction emulation.

Please pull, thanks a lot!

The following changes since commit 839d8810747bbf39e0a5a7f223b67bffa7945f8d:

  Merge branch 'i2c-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging (2011-10-30 15:54:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (4):
      sparc32: Remove non-kernel code from memcpy implementation.
      sparc32: Remove uses of %g7 in memcpy implementation.
      sparc32: Correct the return value of memcpy.
      sparc64: Fix masking and shifting in VIS fpcmp emulation.

 arch/sparc/kernel/visemul.c |   32 +-
 arch/sparc/lib/memcpy.S     |  804 ++++++-------------------------------------
 2 files changed, 115 insertions(+), 721 deletions(-)
