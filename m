From: David Miller <davem@davemloft.net>
Date: Thu, 18 May 2017 18:03:30 +0000
Subject: [GIT] Sparc
Message-Id: <20170518.140330.400029734994473855.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull in these three sparc bug fixes.

Thank you.

The following changes since commit b23afd384801711ab6dbccd259cc14cb09a1dcaf:

  Merge tag 'pstore-v4.12-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2017-05-16 13:29:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 48078d2dac0a26f84f5f3ec704f24f7c832cce14:

  sparc/ftrace: Fix ftrace graph time measurement (2017-05-17 12:07:47 -0700)

----------------------------------------------------------------
Liam R. Howlett (1):
      sparc/ftrace: Fix ftrace graph time measurement

Nitin Gupta (1):
      sparc64: Fix mapping of 64k pages with MAP_FIXED

Orlando Arias (1):
      sparc: Fix -Wstringop-overflow warning

 arch/sparc/include/asm/hugetlb.h    |  6 ++++--
 arch/sparc/include/asm/pgtable_32.h |  4 ++--
 arch/sparc/include/asm/setup.h      |  2 +-
 arch/sparc/kernel/ftrace.c          | 13 ++++++-------
 arch/sparc/mm/init_32.c             |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)
