From: David Miller <davem@redhat.com>
Date: Thu, 26 Sep 2013 20:52:42 +0000
Subject: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <20130926.165242.1048533011152185981.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Ok, this patch set builds on top of the variable PAGE_OFFSET
patches.

First we move to 8MB huge pages.  The chips don't really have
8MB page support, but we fabricate such a thing using 4MB
PTEs.

Next we move to 64-bit pmd_t and pgd_t entries, which is the
most trivial of the changes here.

Finally, we encode huge PMDs using the plain PTE encoding of
huge pages.   All of the ugly huge PMD --> PTE translation
code disappears, and the TLB miss path is smaller and faster.

I just got this stuff fully working so caveat emptor :-)

Signed-off-by: David S. Miller <davem@davemloft.net>
