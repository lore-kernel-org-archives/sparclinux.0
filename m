From: David Miller <davem@davemloft.net>
Date: Sat, 21 Apr 2012 20:58:37 +0000
Subject: [GIT] Sparc
Message-Id: <20120421.165837.76978862714579140.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc32 LEON smp bootup bug fix.

Thanks!

The following changes since commit 8f4f9d4d3cb84686a75f6195b8f8705376763fc7:

  Merge tag 'fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-04-21 12:45:52 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to e9a5ea1852cd8d7e155d2e3a45e4a6ea25110f7d:

  sparc32,leon: add notify_cpu_starting() (2012-04-21 16:35:06 -0400)

----------------------------------------------------------------
Yong Zhang (1):
      sparc32,leon: add notify_cpu_starting()

 arch/sparc/kernel/leon_smp.c |    3 +++
 1 file changed, 3 insertions(+)
