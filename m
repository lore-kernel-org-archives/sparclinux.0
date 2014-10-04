From: David Miller <davem@davemloft.net>
Date: Sat, 04 Oct 2014 23:26:30 +0000
Subject: [PATCH v3 0/9] sparc64: MM/IRQ patch queue.
Message-Id: <20141004.192630.315529201590329439.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Third time is the charm, right? :-)  Let's hope so...

Changes since v2:

1) Get rid of verbose kernel log messages during vmemmap construction.

2) Add patch #9 to get rid of superfluous page table blocks in the
   kernel image which can be allocated dynamically, and at the same
   time increase MAX_BANKS to hopefully accomodate guests with very
   fragmented real memory layouts.

3) Fix bug in KERN_PGTABLE_WALK that would corrupt the huge page TTEs
   of vmemmap mappings.

4) Do some type checking of the page table pointer objects passed into
   pgd_populate() and pud_populate() by creating inline function
   helpers.  The reason we can't make pgd_populate() and
   pud_populate() inline is that "struct mm_struct" is sometimes not
   fully defined yet in contexts where this header is included.

   Anyways, this found a bug (albeit in the end harmless) in the new
   implementation of vmemmap_populate() in that we were passing a
   "pgd_t *" instead of a "pud_t *" into the third argument of
   pgd_populate.

As usual, let me know how it goes.

Signed-off-by: David S. Miller <davem@davemloft.net>

   
