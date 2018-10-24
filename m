From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2018 03:31:48 +0000
Subject: [GIT] Sparc
Message-Id: <20181023.203148.123764172393516338.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Mostly VDSO cleanups and optimizations.

Please pull, thanks a lot!

The following changes since commit 91b15613ce7fb3e724ca0d433eef8e6bf15322af:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-19 09:16:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 8dbc450f76dc8f3b47fe117cd0cde166e1f21b64:

  Merge branch 'sparc-vdso' (2018-10-22 19:14:24 -0700)

----------------------------------------------------------------
David S. Miller (10):
      sparc: Fix parport build warnings.
      sparc: Improve VDSO instruction patching.
      sparc: Inline VDSO gettime code aggressively.
      sparc: Don't bother masking out TICK_PRIV_BIT in VDSO code.
      sparc: Set DISABLE_BRANCH_PROFILING in VDSO CFLAGS.
      sparc: Improve VDSO CFLAGS.
      sparc: Really use linker with LDFLAGS.
      sparc: Validate VDSO for undefined symbols.
      sparc: Several small VDSO vclock_gettime.c improvements.
      Merge branch 'sparc-vdso'

 arch/sparc/include/asm/parport.h        |   2 ++
 arch/sparc/include/asm/thread_info_64.h |   4 ++++
 arch/sparc/include/asm/vdso.h           |   6 +++---
 arch/sparc/kernel/time_64.c             |   3 ---
 arch/sparc/vdso/Makefile                |  33 +++++++++++++++++----------------
 arch/sparc/vdso/checkundef.sh           |  10 ++++++++++
 arch/sparc/vdso/vclock_gettime.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
 arch/sparc/vdso/vdso-layout.lds.S       |   7 ++-----
 arch/sparc/vdso/vdso2c.c                |   6 ------
 arch/sparc/vdso/vdso2c.h                |  18 ++++++++++++++++--
 arch/sparc/vdso/vma.c                   |  39 +++++++++++++++++++++++----------------
 11 files changed, 123 insertions(+), 107 deletions(-)
 create mode 100644 arch/sparc/vdso/checkundef.sh
