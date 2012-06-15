From: David Miller <davem@davemloft.net>
Date: Fri, 15 Jun 2012 22:41:58 +0000
Subject: [GIT] Sparc
Message-Id: <20120615.154158.1041407437357556690.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This just removes some sparc headers that were never, ever, used.

Please pull, thanks a lot!

The following changes since commit 4e3c8a1b1c63482403e9d5e3148dee1a711e4b91:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2012-06-11 16:31:52 +0300)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 8a51178ed64dca418478996697611ef087fa22df:

  sparc: remove two unused headers (2012-06-11 17:05:54 -0700)

----------------------------------------------------------------
Paul Bolle (1):
      sparc: remove two unused headers

 arch/sparc/include/asm/cmt.h    |   59 ----------------------------------------------------
 arch/sparc/include/asm/mpmbox.h |   67 -----------------------------------------------------------
 2 files changed, 126 deletions(-)
 delete mode 100644 arch/sparc/include/asm/cmt.h
 delete mode 100644 arch/sparc/include/asm/mpmbox.h
