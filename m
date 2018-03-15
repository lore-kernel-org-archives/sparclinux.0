From: David Miller <davem@davemloft.net>
Date: Thu, 15 Mar 2018 21:20:49 +0000
Subject: [GIT] Sparc
Message-Id: <20180315.172049.277308110149944782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this sparc64 PMD handling regression fix.

Thank you!

The following changes since commit e2c15aff5f353ba80bd3bb49840837f65fa5cc43:

  Merge tag 'sound-4.16-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2018-03-15 11:07:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to cfb61b5e3e09f8b49bc4d685429df75f45127adc:

  sparc64: Fix regression in pmdp_invalidate(). (2018-03-15 14:18:00 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix regression in pmdp_invalidate().

 arch/sparc/mm/tlb.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
