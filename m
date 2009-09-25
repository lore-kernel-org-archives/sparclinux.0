From: David Miller <davem@davemloft.net>
Date: Fri, 25 Sep 2009 21:31:09 +0000
Subject: [GIT]: Sparc
Message-Id: <20090925.143109.189133359.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc bug fix.

Thanks!

The following changes since commit df58bee21ed218cb7dfb561a590b1bd2a99531cf:
  Linus Torvalds (1):
        Merge branch 'x86-mce-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: vio: Kill BUILD_BUG_ON() in vio_dring_avail().

 arch/sparc/include/asm/vio.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)
