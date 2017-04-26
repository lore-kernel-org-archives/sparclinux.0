From: David Miller <davem@davemloft.net>
Date: Wed, 26 Apr 2017 19:22:15 +0000
Subject: [GIT] Sparc
Message-Id: <20170426.152215.1066522348346001732.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


I didn't want the release to go out without the statx system call properly
hooked up.

Please pull, thanks!

The following changes since commit 5a7ad1146caa895ad718a534399e38bd2ba721b7:

  Linux 4.11-rc8 (2017-04-23 16:53:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to f6ebf0bb1a983a7b60a26acf282975b5da5b3202:

  sparc: Update syscall tables. (2017-04-23 18:28:55 -0700)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: Fill in rest of HAVE_REGS_AND_STACK_ACCESS_API
      sparc: Update syscall tables.

 arch/sparc/Kconfig                   |  1 +
 arch/sparc/include/asm/ptrace.h      |  3 ++-
 arch/sparc/include/uapi/asm/unistd.h |  8 +++++++-
 arch/sparc/kernel/ptrace_64.c        | 36 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/systbls_32.S       |  1 +
 arch/sparc/kernel/systbls_64.S       |  2 ++
 6 files changed, 49 insertions(+), 2 deletions(-)
