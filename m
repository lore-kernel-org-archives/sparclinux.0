From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 04:08:02 +0000
Subject: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140506.000802.1283819541274253321.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is the final series I am submitting to Linus and intend to
submit to -stable, thanks for all of the feedback and reviews.  I
was a bit delayed because I kept triggering crashes caused by a
bug recently introduced in SLAB in 3.15-rc1 which just got fixed
fully tonight.

At a high level:

1) Calculate the executable bit in PMD vs. PTE properly in the PMD
   setting TLB flush code.

2) Use PAGE_VALID bit to encode valid vs. invalid transparent huge
   PMDs, check this bit in the TLB miss handler.

3) get_user_pages_fast() doesn't traverse THP mappins properly,
   neither does get_user_insn().

4) Trim high bits of addresses computed by compute_effective_address()
   when process is 32-bit.

5) Make pmd_bad() and pud_bad() actually do something.

Signed-off-by: David S. Miller <davem@davemloft.net>
