From: David Miller <davem@davemloft.net>
Date: Tue, 18 Apr 2017 20:20:25 +0000
Subject: [GIT] Sparc
Message-Id: <20170418.162025.1958583978696749137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two Sparc bug fixes from Daniel Jordan
and Nitin Gupta.

Thanks a lot!

The following changes since commit fb5e2154b764812705dce84881319471d27606fb:

  Merge tag 'trace-v4.11-rc5-4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2017-04-18 10:19:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 544f8f935863c5a9ca3e34306ea3316095e7b7bf:

  sparc64: Fix hugepage page table free (2017-04-18 13:11:07 -0700)

----------------------------------------------------------------
Daniel Jordan (1):
      sparc64: Use LOCKDEP_SMALL, not PROVE_LOCKING_SMALL

Nitin Gupta (1):
      sparc64: Fix hugepage page table free

 arch/sparc/Kconfig                 |  2 +-
 arch/sparc/mm/hugetlbpage.c        | 16 ++++++++++++++++
 kernel/locking/lockdep_internals.h |  6 +++---
 lib/Kconfig.debug                  |  6 +++---
 4 files changed, 23 insertions(+), 7 deletions(-)
