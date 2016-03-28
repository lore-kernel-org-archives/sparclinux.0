From: David Miller <davem@davemloft.net>
Date: Mon, 28 Mar 2016 19:45:32 +0000
Subject: [GIT] Sparc
Message-Id: <20160328.154532.329435587754741555.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Minor typing cleanup from Joe Perches, and some comment typo fixes
from Adam Buchbinder.

Please pull, thanks!

The following changes since commit 142b9e6c9de0fd7c0dff9a1d4a25390de46abf5e:

  x86/kallsyms: fix GOLD link failure with new relative kallsyms table format (2016-03-20 13:52:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 9ef595d83aea6b4d93c9a120df3c5db2e226929f:

  sparc: Convert naked unsigned uses to unsigned int (2016-03-20 21:28:58 -0700)

----------------------------------------------------------------
Adam Buchbinder (1):
      sparc: Fix misspellings in comments.

Joe Perches (1):
      sparc: Convert naked unsigned uses to unsigned int

 arch/sparc/include/asm/compat_signal.h |  8 ++++----
 arch/sparc/include/asm/obio.h          | 32 ++++++++++++++++----------------
 arch/sparc/include/asm/openprom.h      | 10 +++++-----
 arch/sparc/include/asm/pgtable_64.h    |  2 +-
 arch/sparc/include/asm/processor_64.h  |  2 +-
 arch/sparc/include/asm/sigcontext.h    |  2 +-
 arch/sparc/include/asm/tsb.h           |  2 +-
 arch/sparc/include/uapi/asm/stat.h     |  4 ++--
 arch/sparc/kernel/audit.c              | 12 ++++++------
 arch/sparc/kernel/compat_audit.c       | 12 ++++++------
 arch/sparc/kernel/entry.S              |  2 +-
 arch/sparc/kernel/ioport.c             |  6 +++---
 arch/sparc/kernel/kernel.h             | 12 ++++++------
 arch/sparc/kernel/leon_kernel.c        |  2 +-
 arch/sparc/kernel/process_64.c         |  2 +-
 arch/sparc/kernel/setup_32.c           |  2 +-
 arch/sparc/kernel/setup_64.c           |  2 +-
 arch/sparc/kernel/signal32.c           |  2 +-
 arch/sparc/kernel/sys_sparc_64.c       |  4 ++--
 arch/sparc/kernel/sysfs.c              |  2 +-
 arch/sparc/kernel/unaligned_64.c       |  4 ++--
 arch/sparc/mm/fault_32.c               |  8 ++++----
 arch/sparc/net/bpf_jit_comp.c          |  2 +-
 23 files changed, 68 insertions(+), 68 deletions(-)
