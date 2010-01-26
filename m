From: David Miller <davem@davemloft.net>
Date: Tue, 26 Jan 2010 12:18:12 +0000
Subject: [GIT]: Sparc build fix
Message-Id: <20100126.041812.00806455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 UP build fix.

Thanks!

The following changes since commit 9a3cbe3265c7714e8ee423feb6e27a080af79608:
  Linus Torvalds (1):
        Merge branch 'for_linus' of git://git.kernel.org/.../tytso/ext4

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (1):
      sparc64: Fix UP build.

 arch/sparc/kernel/irq_64.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
