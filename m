From: David Miller <davem@davemloft.net>
Date: Fri, 25 Jul 2008 22:21:00 +0000
Subject: [GIT]: Sparc
Message-Id: <20080725.152100.193704807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


This just wires up the new system calls.

Please pull, thanks a lot!

The following changes since commit fb2e405fc1fc8b20d9c78eaa1c7fd5a297efde43:
  Adrian Bunk (1):
        fix fs/nfs/nfsroot.c compilation

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc: Wire up new system calls.

 arch/sparc/kernel/systbls.S   |    3 ++-
 arch/sparc64/kernel/systbls.S |    6 ++++--
 include/asm-sparc/unistd_32.h |    8 +++++++-
 include/asm-sparc/unistd_64.h |    8 +++++++-
 4 files changed, 20 insertions(+), 5 deletions(-)
