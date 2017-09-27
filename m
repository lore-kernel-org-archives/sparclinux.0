From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 27 Sep 2017 19:25:24 +0000
Subject: [PATCH v2 0/2] sparc64: Optimize fls, fls64 and __fls
Message-Id: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

SPARC provides lzcnt instruction (with VIS3) which can be used to
optimize fls, fls64 and __fls functions. For the systems that supports 
lzcnt instruction, we now do boot time patching to use sparc
optimized fls, fls64 and __fls functions.

v1->v2: 
 - Fixed delay slot issue pointed by Rob Gardner in patch 2/2.

Vijay Kumar (2):
  sparc64: Define SPARC default fls and __fls
  sparc64: Use lzcnt instruction for fls and __fls

 arch/sparc/Makefile                |    1 +
 arch/sparc/include/asm/bitops_64.h |    7 +-
 arch/sparc/kernel/head_64.S        |    2 +
 arch/sparc/lib/Makefile            |    4 +
 arch/sparc/lib/NG4fls.S            |   31 +++++++++
 arch/sparc/lib/NG4patch.S          |    9 +++
 arch/sparc/lib/fls.S               |  126 ++++++++++++++++++++++++++++++++++++
 7 files changed, 177 insertions(+), 3 deletions(-)
 create mode 100644 arch/sparc/lib/NG4fls.S
 create mode 100644 arch/sparc/lib/fls.S

