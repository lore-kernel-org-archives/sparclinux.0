From: David Miller <davem@davemloft.net>
Date: Wed, 04 Apr 2012 08:03:23 +0000
Subject: [GIT] Sparc
Message-Id: <20120404.040323.342187037087621691.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get one build regressiona done serial probe
regression fix on sparc.

Thanks!

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc master

for you to fetch changes up to ca6f327dfdc6b3b90aa0c5247182ae023dce6450:

  serial/sunzilog: fix keyboard on SUN SPARCstation (2012-04-04 00:37:10 -0700)

----------------------------------------------------------------
Aaro Koskinen (1):
      sparc: pgtable_64: change include order

Sam Ravnborg (1):
      serial/sunzilog: fix keyboard on SUN SPARCstation

 arch/sparc/include/asm/pgtable_64.h |    4 ++--
 drivers/tty/serial/sunzilog.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
