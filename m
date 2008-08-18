From: David Miller <davem@davemloft.net>
Date: Mon, 18 Aug 2008 05:39:04 +0000
Subject: [GIT]: Sparc
Message-Id: <20080817.223904.186713151.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


The LMB bug fix was OK'd by the powerpc folks and they are the
only other port which uses that code, so... :-)

Please pull, thanks a lot!

The following changes since commit 6f63e781eaf6a741fc65f773017154b20ed4ce3b:
  David S. Miller (1):
        sparc64: Handle stack trace attempts before irqstacks are setup.

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (3):
      sparc64: Fix overshoot in nid_range().
      sparc64: Fix cmdline_memory_size handling bugs.
      lmb: Fix reserved region handling in lmb_enforce_memory_limit().

 arch/sparc64/mm/init.c |   30 ++++++++++++++++++++++--------
 lib/lmb.c              |    2 ++
 2 files changed, 24 insertions(+), 8 deletions(-)
