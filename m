From: David Miller <davem@davemloft.net>
Date: Tue, 10 Apr 2012 14:28:38 +0000
Subject: [GIT] Sparc
Message-Id: <20120410.102838.1970905616814782796.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


1) Build fix for LEON, from Sam Ravnborg.

2) Make the sparc side changes that go along with the infrastructure
   to retry faults when blocking on a disk transfer.  From Kautuk
   Consul.

Please pull, thanks a lot!

The following changes since commit 64ebe987311853ea857a244439de5b947a4b1b07:

  Merge tag 'pm-for-3.4-part-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2012-04-04 14:26:40 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to d657784b70ef653350d7aa49da90a8484c29da7d:

  sparc32,leon: fix leon build (2012-04-04 15:44:39 -0700)

----------------------------------------------------------------
Kautuk Consul (2):
      sparc/mm/fault_64.c: Port OOM changes to do_sparc64_fault
      sparc/mm/fault_32.c: Port OOM changes to do_sparc_fault

Sam Ravnborg (1):
      sparc32,leon: fix leon build

 arch/sparc/kernel/leon_pci.c |   13 -------------
 arch/sparc/mm/fault_32.c     |   37 ++++++++++++++++++++++++++++++-------
 arch/sparc/mm/fault_64.c     |   37 ++++++++++++++++++++++++++++++-------
 3 files changed, 60 insertions(+), 27 deletions(-)
