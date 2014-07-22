From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 05:38:16 +0000
Subject: [GIT] Sparc
Message-Id: <20140721.223816.1457327353814495306.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Need to hook up the new renameat2 system call.

Please pull, thanks!

The following changes since commit 9a3c4145af32125c5ee39c0272662b47307a8323:

  Linux 3.16-rc6 (2014-07-20 21:04:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 26053926feb1c16ade9c30bc7443bf28d829d08e:

  sparc: Hook up renameat2 syscall. (2014-07-21 22:27:56 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc: Hook up renameat2 syscall.

 arch/sparc/include/uapi/asm/unistd.h | 3 ++-
 arch/sparc/kernel/sys32.S            | 1 +
 arch/sparc/kernel/systbls_32.S       | 1 +
 arch/sparc/kernel/systbls_64.S       | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)
