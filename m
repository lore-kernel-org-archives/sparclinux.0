From: "k e" <eiselekd@gmail.com>
Date: Tue, 18 Nov 2008 20:36:24 +0000
Subject: Extending Leon-Sparc page table size to 32k
Message-Id: <e8611b790811181236q5c36993dq1da2d43888c5c7b2@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
I'm trying to figure out how to patch srmmu.c the easiest way so that 32k size
pages can be used for Sparc-Leon. The Leon-Sparc processor supports
that page size.
Studying the code I see that 16 hardware PTE-tables are joined
together to form a
1024 entry software PTE-table exactly 4k big.
The source of pgtsrmmu.h states:

 /*
  40 * To support pagetables in highmem, Linux introduces APIs which
  41 * return struct page* and generally manipulate page tables when
  42 * they are not mapped into kernel space. Our hardware page tables
  43 * are smaller than pages. We lump hardware tabes into big, page sized
  44 * software tables.
  45 *
  46 * PMD_SHIFT determines the size of the area a second-level page table entry
  47 * can map, and our pmd_t is 16 times larger than normal.  The values which
  48 * were once defined here are now generic for 4c and srmmu, so they're
  49 * found in pgtable.h.
  50 */

The problem I face now is that when using 32k pages the hardware PTE-table has
only 8 entries (when using SRMMU-like index layout with bit
[[31-24][23 - 18][17-15]]).
So I could at max form a 8*64Q2 entry software PTE-table that would
only be 2k.
However the page size would be 32k anyway.

Could someone explain why there is a need to join hardware PTE-Tables together
to form chunks of 4k (PAGE_SIZE, but in my case 32k).
Is this only a performance consideration or would I run into trouble
if using only 2k
chunks of 512 enties?

If I only use pages tables in nocache mem at 0xfc000000 (and I think
this is the case
for the Sparc-Leon port using linux-2.6.21.1), can the pgtsrmmu.h
comment then be ignored?
If I understand it right that page tables are always  allocated through
__srmmu_get_nocache() and I can allocate chunks smaller than PAGE_SIZE.

Does someone see a easy path to implement 32k pages?

-- Greetings Konrad
