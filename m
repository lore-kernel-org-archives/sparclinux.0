From: David Miller <davem@davemloft.net>
Date: Thu, 18 Dec 2014 21:39:02 +0000
Subject: [GIT] Sparc
Message-Id: <20141218.163902.82013891201636149.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc32 locking bug fix from Andreas Larsson.

Thanks!

The following changes since commit 44e8967d591686463e84a88b46b03beba3ab49fb:

  Ceph: remove left-over reject file (2014-12-17 18:47:01 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to 66d0f7ec9f1038452178b1993fc07fd96d30fd38:

  sparc32: destroy_context() and switch_mm() needs to disable interrupts. (2014-12-18 12:47:54 -0500)

----------------------------------------------------------------
Andreas Larsson (1):
      sparc32: destroy_context() and switch_mm() needs to disable interrupts.

 arch/sparc/mm/srmmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
