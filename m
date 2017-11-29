From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 20:17:22 +0000
Subject: [GIT] Sparc
Message-Id: <20171129.151722.840617144837142590.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this T4 and later cpu bootup regression
fix.

Thank you!

The following changes since commit 0c86a6bd85ff0629cd2c5141027fc1c8bb6cde9c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2017-11-21 05:56:12 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to e5372cd5ef12b05ae74d608f95dc53fe06558867:

  sparc64: Fix boot on T4 and later. (2017-11-29 15:09:29 -0500)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix boot on T4 and later.

 arch/sparc/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
