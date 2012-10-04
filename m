From: David Miller <davem@davemloft.net>
Date: Thu, 04 Oct 2012 19:46:24 +0000
Subject: [PATCH v2 0/8] THP support for Sparc64
Message-Id: <20121004.154624.923241475790311926.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, aarcange@redhat.com, hannes@cmpxchg.org


Changes since V1:

1) Respun against mmotm

2) Bug fix for pgtable allocation, need real locking instead of
   just preemption disabling.

Andrew, you can probably take patch #5 in this series and combine
it into:

mm-thp-fix-the-update_mmu_cache-last-argument-passing-in-mm-huge_memoryc.patch

in your batch.  And finally add a NOP implementation for S390
and any other huge page supporting architectures.

Signed-off-by: David S. Miller <davem@davemloft.net>
