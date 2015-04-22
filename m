From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 02:58:32 +0000
Subject: [GIT] Sparc
Message-Id: <20150421.225832.867072729864629607.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


1) ldc_alloc_exp_dring() can be called from softints, so use GFP_ATOMIC.
   From Sowmini Varadhan.

2) Some minor warning/build fixups for the new iommu-common code on
   certain archs and with certain debug options enabled.  Also from
   Sowmini Varadhan.

Please pull, thanks!

The following changes since commit 64fb1d0e975e92e012802d371e417266d6531676:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc (2015-04-18 18:01:29 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 0edfad5959df7379c9e554fbe8ba264ae232d321:

  sparc: Use GFP_ATOMIC in ldc_alloc_exp_dring() as it can be called in softirq context (2015-04-21 13:17:06 -0700)

----------------------------------------------------------------
David S. Miller (2):
      Merge branch 'iommu-common-fixes'
      sparc64: Use M7 PMC write on all chips T4 and onward.

Sowmini Varadhan (3):
      iommu-common: fix x86_64 compiler warnings
      iommu-common: rename iommu_pool_hash to iommu_hash_common
      sparc: Use GFP_ATOMIC in ldc_alloc_exp_dring() as it can be called in softirq context

 arch/sparc/kernel/ldc.c        |  2 +-
 arch/sparc/kernel/perf_event.c | 35 +++--------------------------------
 lib/iommu-common.c             | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 43 deletions(-)
