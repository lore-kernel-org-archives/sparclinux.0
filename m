From: David Miller <davem@davemloft.net>
Date: Tue, 08 Nov 2011 20:07:31 +0000
Subject: [GIT] Sparc
Message-Id: <20111108.150731.152390752080053131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This just hooks up the new system calls.

Please pull, thanks!

The following changes since commit 1ea6b8f48918282bdca0b32a34095504ee65bab5:

  Linux 3.2-rc1 (2011-11-07 16:16:02 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

David S. Miller (1):
      sparc: Hook up process_vm_{readv,writev} syscalls.

 arch/sparc/include/asm/unistd.h |    4 +++-
 arch/sparc/kernel/systbls_32.S  |    2 +-
 arch/sparc/kernel/systbls_64.S  |    4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)
