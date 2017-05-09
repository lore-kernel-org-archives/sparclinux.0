From: David Miller <davem@davemloft.net>
Date: Tue, 09 May 2017 20:04:14 +0000
Subject: [GIT] Sparc
Message-Id: <20170509.160414.1587011096608664845.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull in these sparc changes, including a bug fix
for handling exceptions during bzero on some sparc64
cpus.

Thanks!

The following changes since commit 89c9fea3c8034cdb2fd745f551cde0b507fd6893:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial (2017-05-02 19:09:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 3c7f62212018b904ae17f5636ead18a4dca3a88f:

  sparc64: fix fault handling in NGbzero.S and GENbzero.S (2017-05-09 12:16:25 -0700)

----------------------------------------------------------------
Dave Aldridge (1):
      sparc64: fix fault handling in NGbzero.S and GENbzero.S

David S. Miller (1):
      sparc: Remove redundant tests in boot_flags_init().

Geliang Tang (1):
      sparc: use memdup_user_nul in sun4m LED driver

 arch/sparc/kernel/head_64.S  |  6 ++++++
 arch/sparc/kernel/led.c      | 13 +++----------
 arch/sparc/kernel/setup_32.c |  2 +-
 arch/sparc/kernel/setup_64.c |  2 +-
 arch/sparc/lib/GENbzero.S    |  2 +-
 arch/sparc/lib/NGbzero.S     |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)
