From: David Miller <davem@davemloft.net>
Date: Wed, 22 Sep 2010 18:10:19 +0000
Subject: [GIT] Sparc
Message-Id: <20100922.111019.200357319.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Al Viro has been auditing signal handling in various architectures,
and he found some sparc bugs along the way.

Those he found are fixed here, as well as a short patch to add
raw perf event support.

Please pull, thanks a lot!

The following changes since commit 2422084a94fcd5038406261b331672a13c92c050:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha-2.6 (2010-09-19 11:09:23 -0700)

are available in the git repository at:

  master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6.git master

David S. Miller (4):
      sparc64: Support RAW perf events.
      sparc64: Fix race in signal instruction flushing.
      sparc: Don't mask signal when we can't setup signal frame.
      sparc: Prevent no-handler signal syscall restart recursion.

 arch/sparc/kernel/perf_event.c |   14 +++-
 arch/sparc/kernel/signal32.c   |  161 ++++++++++++++++++++++++----------------
 arch/sparc/kernel/signal_32.c  |   55 +++++++++-----
 arch/sparc/kernel/signal_64.c  |   45 +++++++----
 4 files changed, 171 insertions(+), 104 deletions(-)
