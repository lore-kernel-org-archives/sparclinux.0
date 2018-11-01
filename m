From: David Miller <davem@davemloft.net>
Date: Thu, 01 Nov 2018 01:44:18 +0000
Subject: [GIT] Sparc
Message-Id: <20181031.184418.1509890447175181068.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two small fixes, please pull.

Thanks!

The following changes since commit 4b42745211af552f170f38a1b97f4a112b5da6b2:

  Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-29 15:37:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 1f2b5b8e2df4591fbca430aff9c5a072dcc0f408:

  sparc64: Wire up compat getpeername and getsockname. (2018-10-31 18:30:21 -0700)

----------------------------------------------------------------
David S. Miller (2):
      sparc64: Remvoe set_fs() from perf_callchain_user().
      sparc64: Wire up compat getpeername and getsockname.

 arch/sparc/kernel/perf_event.c | 5 -----
 arch/sparc/kernel/systbls_64.S | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)
