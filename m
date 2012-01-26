From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jan 2012 21:55:21 +0000
Subject: [GIT] Sparc
Message-Id: <20120126.165521.1045119684853288263.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc 32-bit timer fix.

Thanks!

The following changes since commit 87f71ae2dd7471c1b4c94100be1f218e91dc64c3:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2012-01-25 19:28:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

Tkhai Kirill (1):
      sparc32: forced setting of mode of sun4m per-cpu timers

 arch/sparc/kernel/sun4m_irq.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
