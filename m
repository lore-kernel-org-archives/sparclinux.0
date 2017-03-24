From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:11 +0000
Subject: [PATCH v3 0/7] Add memsetN functions
Message-Id: <20170324161318.18718-1-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Minchan Kim <minchan@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

zram was recently enhanced to support compressing pages with a repeating
pattern up to the size of an unsigned long.  As part of the discussion,
we noted it would be nice if architectures had optimised routines
to fill regions of memory with patterns larger than those contained
in a single byte.  Our suspicions were right; the x86 version offers
approximately a 7% performance improvement over the C implementation.

The generic memfill() function is part of Lars Wirzenius' publib,
but it doesn't offer the most convenient interface.  I chose to add
five more-specific functions as part of this patchset -- memset16(),
memset32(), memset64(), memset_l() (long) and memset_p() (pointer).

It would be nice to have some more architectures implement optimised
memsetN calls.  It would also be nice to find more places in the kernel
which could benefit from calling these functions.  Maybe a coccinelle
script could be written to find such places?  We're looking for loops
over an array where the value being stored into the array does not depend
on the iteration variable.

Since v1 of the patchset, I stumbled on Alpha's memsetw() which
caused me to add memset16() to complete the set.  I removed the
'__HAVE_ARCH_MEMSET_PLUS' preprocessor symbol in favour of separate
MEMSET16 MEMSET32 and MEMSET64 symbols.  I also reviewed the scr_mem*w()
usages across the different architectures and implemented some obvious
missing optimisations.  Alpha is still missing scr_memmovew() as it
would be non-trivial to write.

Russell's review on patch 2 only applies to the memset32/memset64
implementation.  The memset16 is unreviewed (and, indeed, untested)
to date.

Matthew Wilcox (7):
  Add multibyte memset functions
  ARM: Implement memset16, memset32 & memset64
  x86: Implement memset16, memset32 & memset64
  alpha: Add support for memset16
  zram: Convert to using memset_l
  sym53c8xx_2: Convert to use memset32
  vga: Optimise console scrolling

 arch/alpha/include/asm/string.h     | 15 ++++----
 arch/alpha/include/asm/vga.h        |  2 +-
 arch/alpha/lib/memset.S             | 10 +++---
 arch/arm/include/asm/string.h       | 21 ++++++++++++
 arch/arm/kernel/armksyms.c          |  3 ++
 arch/arm/lib/memset.S               | 44 +++++++++++++++++++-----
 arch/mips/include/asm/vga.h         |  6 ++++
 arch/powerpc/include/asm/vga.h      |  8 +++++
 arch/sparc/include/asm/vga.h        | 24 +++++++++++++
 arch/x86/include/asm/string_32.h    | 24 +++++++++++++
 arch/x86/include/asm/string_64.h    | 36 ++++++++++++++++++++
 drivers/block/zram/zram_drv.c       | 15 ++------
 drivers/scsi/sym53c8xx_2/sym_hipd.c | 11 ++----
 include/linux/string.h              | 30 ++++++++++++++++
 include/linux/vt_buffer.h           | 12 +++++++
 lib/string.c                        | 68 +++++++++++++++++++++++++++++++++++++
 16 files changed, 287 insertions(+), 42 deletions(-)

-- 
2.11.0
