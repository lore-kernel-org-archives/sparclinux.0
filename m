From: David Miller <davem@davemloft.net>
Date: Thu, 25 Apr 2013 00:08:47 +0000
Subject: [GIT] Sparc
Message-Id: <20130424.200847.935084813305667292.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100329.131141.80866523.davem@davemloft.net>
In-Reply-To: <20100329.131141.80866523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Please pull to get this brown paper bag fix for sparc64.

Thanks!

The following changes since commit 60d509fa6a9c4653a86ad830e4c4b30360b23f0e:

  Linux 3.9-rc8 (2013-04-21 14:38:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git master

for you to fetch changes up to f0af97070acbad5d6a361f485828223a4faaa0ee:

  sparc64: Fix missing put_cpu_var() in tlb_batch_add_one() when not batching. (2013-04-24 16:52:18 -0700)

----------------------------------------------------------------
David S. Miller (1):
      sparc64: Fix missing put_cpu_var() in tlb_batch_add_one() when not batching.

 arch/sparc/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
