From: David Miller <davem@davemloft.net>
Date: Tue, 02 Dec 2008 07:19:35 +0000
Subject: [GIT]: Sparc
Message-Id: <20081201.231935.211354491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Two bug sets of fixes:

1) Several starfire rtc driver bug fixes from Allesandro Zummo.

2) The calculation of the fault fixup offset on sparc64 is upside
   down.

Please pull, thanks a lot!

The following changes since commit cecf61bdee426a3e0a014f7e26990d09c71ed458:
  Alessandro Zummo (1):
        rtc: rtc-sun4v fixes, revised

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

Alessandro Zummo (1):
      rtc: rtc-starfire fixes

David S. Miller (1):
      sparc64: Fix offset calculation in compute_size()

 arch/sparc64/lib/user_fixup.c |    2 +-
 drivers/rtc/rtc-starfire.c    |   66 ++++++++---------------------------------
 2 files changed, 14 insertions(+), 54 deletions(-)
