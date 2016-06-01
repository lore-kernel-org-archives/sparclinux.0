From: David Miller <davem@davemloft.net>
Date: Wed, 01 Jun 2016 04:17:12 +0000
Subject: [GIT] Sparc
Message-Id: <20160531.211712.1191371092683025310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc64 mmu context allocation and trap
return bug fixes, thanks.

The following changes since commit ecc5fbd5ef472a4c659dc56a5739b3f041c0530c:

  Merge tag 'pwm/for-4.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm (2016-05-25 10:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc 

for you to fetch changes up to 7cafc0b8bf130f038b0ec2dcdd6a9de6dc59b65a:

  sparc64: Fix return from trap window fill crashes. (2016-05-29 18:55:54 -0700)

----------------------------------------------------------------
David S. Miller (3):
      sparc64: Take ctx_alloc_lock properly in hugetlb_setup().
      sparc: Harden signal return frame checks.
      sparc64: Fix return from trap window fill crashes.

 arch/sparc/include/asm/head_64.h |  4 ++++
 arch/sparc/include/asm/ttable.h  |  8 ++++----
 arch/sparc/kernel/Makefile       |  1 +
 arch/sparc/kernel/rtrap_64.S     | 57 +++++++++----------------------------------------------
 arch/sparc/kernel/signal32.c     | 46 +++++++++++++++++++++++++++++----------------
 arch/sparc/kernel/signal_32.c    | 41 +++++++++++++++++++++++++---------------
 arch/sparc/kernel/signal_64.c    | 31 +++++++++++++++++++-----------
 arch/sparc/kernel/sigutil_32.c   |  9 ++++++++-
 arch/sparc/kernel/sigutil_64.c   | 10 ++++++++--
 arch/sparc/kernel/urtt_fill.S    | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/mm/init_64.c          | 10 +++++++---
 11 files changed, 215 insertions(+), 100 deletions(-)
 create mode 100644 arch/sparc/kernel/urtt_fill.S
