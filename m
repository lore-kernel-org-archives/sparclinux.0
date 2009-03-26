From: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2009 09:08:15 +0000
Subject: [GIT]: Sparc
Message-Id: <20090326.020815.59259688.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Just a bug fix for a TLB issue noticed by Ben H.

Please pull, thanks a lot!

The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
  Linus Torvalds (1):
        Linux 2.6.29

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Flush TLB before releasing pages.

 arch/sparc/include/asm/tlb_64.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
