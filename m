From: David Miller <davem@davemloft.net>
Date: Mon, 22 Feb 2010 02:32:44 +0000
Subject: [GIT]: Sparc
Message-Id: <20100221.183244.189710062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this 32-bit sparc regression fix.

Thanks!

The following changes since commit aea187c46f7d03ce985e55eb1398d0776a15b928:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs-2.6

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc32: Fix struct stat uid/gid types.

 arch/sparc/include/asm/stat.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
