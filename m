From: David Miller <davem@davemloft.net>
Date: Thu, 04 Dec 2008 19:58:49 +0000
Subject: [GIT]: Sparc
Message-Id: <20081204.115849.82772519.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these sparc bug fixes, thanks!

The following changes since commit f6f7b52e2f6149d2ee365717afff315b05720162:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../wim/linux-2.6-watchdog

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Chris Torek (1):
      sparc64: Fix bug in PTRACE_SETFPREGS64 handling.

Hong H. Pham (1):
      sparc64: Sync FPU state in VIS emulation handler.

Joseph Myers (1):
      sparc64: Fix VIS emulation bugs

Rusty Russell (1):
      sparc: asm/bitops.h should define __fls

 arch/sparc/include/asm/bitops_32.h |    1 +
 arch/sparc64/kernel/ptrace.c       |    2 +-
 arch/sparc64/kernel/visemul.c      |    6 ++++--
 3 files changed, 6 insertions(+), 3 deletions(-)
