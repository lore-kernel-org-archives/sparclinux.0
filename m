From: David Miller <davem@davemloft.net>
Date: Fri, 24 Oct 2008 00:33:49 +0000
Subject: [GIT]: Sparc
Message-Id: <20081023.173349.193701851.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Several bug fixes and sparc support for checkstack:

1) Two math-emu fixes, one courtesy of Kumar Gala.

2) Section mismatch fixes for sparc32 from Frederic Weisbecker.

3) CPU startup locking fix from Andrea Shepard.

Please pull, thanks a lot!

The following changes since commit 2515ddc6db8eb49a79f0fe5e67ff09ac7c81eab4:
  Paul Mundt (1):
        binfmt_elf_fdpic: Update for cputime changes.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Andrea Shepard (1):
      sparc64: Fix race in arch/sparc64/kernel/trampoline.S

David S. Miller (1):
      math-emu: Fix thinko in _FP_DIV

Frederic Weisbecker (2):
      sparc: correct section of apc_no_idle
      sparc: correct section of current_pc()

Kumar Gala (1):
      math-emu: Fix signalling of underflow and inexact while packing result.

Martin Habets (1):
      sparc: Add checkstack support

 arch/sparc/kernel/apc.c          |    2 +-
 arch/sparc/kernel/head.S         |    1 +
 arch/sparc64/kernel/trampoline.S |   18 ++++++++++++++----
 include/math-emu/op-common.h     |   19 +++++++++++++++----
 scripts/checkstack.pl            |    4 ++++
 5 files changed, 35 insertions(+), 9 deletions(-)
