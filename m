From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jan 2010 07:28:35 +0000
Subject: [GIT]: Sparc
Message-Id: <20100104.232835.124284338.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Fix some fundamental perf issues that were undiscovered until perf top
started using rate based profiling by default.

Fix a crash in bbc_envctrl on unload if kthread_run() fails during
load.  Still need to figure out why kthread_run() is erroring out
though...

Please pull, thanks a lot!

The following changes since commit c5974b835a909ff15c3b7e6cf6789b5eb919f419:
  Linus Torvalds (1):
        Merge branch 'limits_cleanup' of git://decibel.fi.muni.cz/~xslaby/linux

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      bbc_envctrl: Clean up properly if kthread_run() fails.
      Merge branch 'master' of /home/davem/src/GIT/linux-2.6/
      sparc64: Fix NMI programming when perf events are active.
      sparc64: Fix Niagara2 perf event handling.

 arch/sparc/kernel/nmi.c         |    3 +-
 arch/sparc/kernel/perf_event.c  |   11 +++++++
 drivers/sbus/char/bbc_envctrl.c |   64 +++++++++++++++++++++++----------------
 3 files changed, 51 insertions(+), 27 deletions(-)
