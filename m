From: Andreas Larsson <andreas@gaisler.com>
Date: Tue, 14 Nov 2017 14:03:41 +0000
Subject: [PATCH 0/2] sparc32,leon: Allow and use CAS for atomic operations for LEON
Message-Id: <1510668223-18484-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, software@gaisler.com

The first patch makes sure that CAS can be assembled and the second
patch adds the configurable possibility to use the CASA instruction
rather than spinlock based emulation for atomic operations.

Andreas Larsson (2):
  sparc32,leon: Build with -mcpu=leon3 for SPARC_LEON
  sparc32,leon: Add support for atomic operations with CAS

 arch/sparc/Kconfig                  |  17 ++++-
 arch/sparc/Makefile                 |  10 ++-
 arch/sparc/include/asm/atomic_32.h  |  55 ++++++++++++++-
 arch/sparc/include/asm/bitops_32.h  |  13 ++++
 arch/sparc/include/asm/cmpxchg_32.h |  37 ++++++++++
 arch/sparc/lib/Makefile             |   4 +-
 arch/sparc/lib/atomic_cas_32.S      |  69 +++++++++++++++++++
 arch/sparc/lib/bitops_cas_32.S      | 130 ++++++++++++++++++++++++++++++++++++
 8 files changed, 326 insertions(+), 9 deletions(-)
 create mode 100644 arch/sparc/lib/atomic_cas_32.S
 create mode 100644 arch/sparc/lib/bitops_cas_32.S

-- 
2.8.0

