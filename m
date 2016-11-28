From: David Miller <davem@davemloft.net>
Date: Mon, 28 Nov 2016 21:03:52 +0000
Subject: [GIT] Sparc
Message-Id: <20161128.160352.1098909781687129456.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two ugly build warning fixes for sparc,
thanks!

The following changes since commit 9dd35d6882a10629b95f2bc41a541740ef24c226:

  sparc: drop duplicate header scatterlist.h (2016-11-19 10:43:07 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 16f46050e7094a95554555a505a984535d253cf6:

  dbri: Fix compiler warning (2016-11-28 15:51:31 -0500)

----------------------------------------------------------------
Tushar Dave (2):
      qlogicpti: Fix compiler warnings
      dbri: Fix compiler warning

 drivers/scsi/qlogicpti.h |  4 ++--
 sound/sparc/dbri.c       | 26 ++++++++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)
