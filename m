From: Meelis Roos <mroos@linux.ee>
Date: Thu, 12 Aug 2004 13:09:47 +0000
Subject: 2.6.8 BK compile failure (arch/sparc64/mm/tlb.c)
Message-Id: <Pine.GSO.4.44.0408121609130.12542-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

  CC      arch/sparc64/mm/tlb.o
In file included from arch/sparc64/mm/tlb.c:17:
include/asm/tlb.h: In function `tlb_finish_mmu':
include/asm/tlb.h:95: error: invalid operands to binary &
make[1]: *** [arch/sparc64/mm/tlb.o] Error 1

-- 
Meelis Roos (mroos@linux.ee)

