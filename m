From: Will Deacon <will@kernel.org>
Date: Tue, 26 May 2020 17:32:59 +0000
Subject: [PATCH 0/3] sparc32 SRMMU fixes for SMP
Message-Id: <20200526173302.377-1-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "David S . Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>, kernel-team@android.com

Hi folks,

Enabling SMP for sparc32 uncovered some issues in the SRMMU page-table
allocation code. One of these was introduced by me, but the other two
seem to have been there a while and are probably just exposed more
easily by my recent changes.

Tested on QEMU. I'm assuming these will go via David's tree.

Cheers,

Will

--->8

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: kernel-team@android.com

Will Deacon (3):
  sparc32: mm: Don't try to free page-table pages if ctor() fails
  sparc32: mm: Disable SPLIT_PTLOCK_CPUS
  sparc32: mm: Only call ctor()/dtor() functions for first and last user

 arch/sparc/mm/srmmu.c | 15 +++++++++++----
 mm/Kconfig            |  4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652-goog
