From: David Miller <davem@davemloft.net>
Date: Mon, 26 May 2008 06:18:27 +0000
Subject: [GIT]: Sparc
Message-Id: <20080525.231827.50332094.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this fix from Adrian Bunk.

Thanks!

The following changes since commit ada44a0430fdd00b3f38aad0aa518e97cb760bd0:
  David S. Miller (1):
        sparc64: Prevent stack backtrace false positives on trap frames.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Adrian Bunk (1):
      sparc64: global_reg_snapshot is not for userspace

 include/asm-sparc64/ptrace.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)
