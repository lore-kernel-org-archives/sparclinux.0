From: David Miller <davem@davemloft.net>
Date: Fri, 25 Mar 2011 21:05:13 +0000
Subject: [GIT] Sparc
Message-Id: <20110325.140513.90785615.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this RTC probing bug fix.

Thanks!

The following changes since commit 40471856f2e38e9bfa8d605295e8234421110dd6:

  Merge branch 'nfs-for-2.6.39' of git://git.linux-nfs.org/projects/trondmy/nfs-2.6 (2011-03-25 10:03:28 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Kjetil Oftedal (1):
      sparc32: Fix multiple RTC detections on SUN4D

 arch/sparc/kernel/time_32.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)
