From: David Miller <davem@davemloft.net>
Date: Thu, 31 Dec 2015 20:30:07 +0000
Subject: [GIT] Sparc
Message-Id: <20151231.153007.364069531098368708.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just some missing syscall wire ups, please pull, thanks!

The following changes since commit 8db7b3c54401d83a4dc370a59b8692854000ea03:

  Merge branch 'parisc-4.4-4' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2015-12-25 13:19:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 42d85c52f88dd0d2159f531eb33cc66d6e3e60c0:

  sparc: Wire up mlock2 system call. (2015-12-31 15:38:56 -0500)

----------------------------------------------------------------
David S. Miller (2):
      sparc: Add all necessary direct socket system calls.
      sparc: Wire up mlock2 system call.

 arch/sparc/include/uapi/asm/unistd.h |  6 +++++-
 arch/sparc/kernel/systbls_32.S       | 19 ++++++++++---------
 arch/sparc/kernel/systbls_64.S       | 18 ++++++++++--------
 3 files changed, 25 insertions(+), 18 deletions(-)
