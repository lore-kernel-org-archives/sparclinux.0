From: David Miller <davem@davemloft.net>
Date: Mon, 30 Sep 2013 16:31:30 +0000
Subject: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20130930.123130.354302574443157859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This is a respin of the original page_offset and 64-bit page
table changes with some minor changes and a bug fix:

1) Bob's ACKs for the first 6 patches added.

2) Don't use "UL" postfix for shift counts, there is code that
   wants those to be "int", particularly printfs in mm/mm_init.c
   that use the "%d" format specifier for SECTIONS_SHIFT.

3) Adjust VA_HOLE defines to match what the new 3-level page
   tables can actually provide.

Signed-off-by: David S. Miller <davem@davemloft.net>
