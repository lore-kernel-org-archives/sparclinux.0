From: David Miller <davem@davemloft.net>
Date: Mon, 29 Aug 2011 16:50:20 +0000
Subject: [GIT] Sparc
Message-Id: <20110829.125020.877556014112084807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 build fix and a sparc32 fix for
IRQ cross-calls.

Thanks!

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git master

Kjetil Oftedal (1):
      sparc32,sun4d: Change IPI IRQ level to prevent collision between IPI and timer interrupt

Stephen Rothwell (1):
      sparc: Remove another reference to nfsservctl

 arch/sparc/kernel/irq.h        |    2 +-
 arch/sparc/kernel/systbls_64.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
