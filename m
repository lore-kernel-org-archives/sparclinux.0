From: David Miller <davem@davemloft.net>
Date: Thu, 18 Dec 2008 03:57:31 +0000
Subject: [GIT]: Sparc
Message-Id: <20081217.195731.135166724.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this ptrace handling bug fix.

Thanks!

The following changes since commit 410d2c8187ed969238ba98008c1d57307a56cfd8:
  Hong H. Pham (1):
        sparc64: Sync FPU state in VIS emulation handler.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc: We need to implement arch_ptrace_stop().

 arch/sparc/include/asm/ptrace_32.h |   10 ++++++++++
 arch/sparc/include/asm/ptrace_64.h |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
