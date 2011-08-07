From: David Miller <davem@davemloft.net>
Date: Sun, 07 Aug 2011 22:48:02 +0000
Subject: [GIT] Sparc
Message-Id: <20110807.154802.834385239075023278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this build fix, thanks!

The following changes since commit 4d4487140d34c1b9b321889d2d209321b0da6643:

  arm: remove "optimized" SHA1 routines (2011-08-07 14:07:03 -0700)

are available in the git repository at:
  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc: Fix build with DEBUG_PAGEALLOC enabled.

 arch/sparc/mm/init_64.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
