From: David Miller <davem@davemloft.net>
Date: Tue, 30 Aug 2011 18:13:07 +0000
Subject: [GIT] Sparc
Message-Id: <20110830.141307.444194149590113106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this popc support detection bug fix, thanks!

The following changes since commit 0f43dd546d991ca260d8a72d07f617907c508de8:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2011-08-29 13:38:29 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc64: Only Panther cheetah+ chips have POPC.

 arch/sparc/kernel/setup_64.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)
