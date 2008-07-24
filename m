From: David Miller <davem@davemloft.net>
Date: Thu, 24 Jul 2008 06:27:17 +0000
Subject: [GIT]: Sparc
Message-Id: <20080723.232717.70515243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get these two sparc bug fixes.

Thanks!

The following changes since commit 4a0a088970a553e9f89d23eec688932f689d57f9:
  Stephen Rothwell (1):
        sparc32: pass -m32 when building vmlinux.lds

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (2):
      sparc64: Fix lockdep issues in LDC protocol layer.
      sparc64: Fix cpufreq notifier registry.

 arch/sparc64/kernel/irq.c  |   10 +++++++++-
 arch/sparc64/kernel/ldc.c  |   38 +++++++++++++++++++-------------------
 arch/sparc64/kernel/time.c |   15 ++++++++++-----
 3 files changed, 38 insertions(+), 25 deletions(-)
