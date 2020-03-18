From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 18 Mar 2020 22:06:30 +0000
Subject: [PATCH 0/4] Clean up hugetlb boot command line processing
Message-Id: <20200318220634.32100-1-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, "David S . Miller" <davem@davemloft.net>, Mike Kravetz <mike.kravetz@oracle.com>

Longpeng(Mike) reported a weird message from hugetlb command line processing
and proposed a solution [1].  While the proposed patch does address the
specific issue, there are other related issues in command line processing.
As hugetlbfs evolved, updates to command line processing have been made to
meet immediate needs and not necessarily in a coordinated manner.  The result
is that some processing is done in arch specific code, some is done in arch
independent code and coordination is problematic.  Semantics can vary between
architectures.

The following patch series does the following:
- Define arch specific arch_hugetlb_valid_size routine used to validate
  passed huge page sizes.
- Move hugepagesz= command line parsing out of arch specific code and into
  an arch independent routine.
- Clean up command line processing to follow desired semantics and
  document those semantics.

[1] https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.com

Mike Kravetz (4):
  hugetlbfs: add arch_hugetlb_valid_size
  hugetlbfs: move hugepagesz= parsing to arch independent code
  hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
  hugetlbfs: clean up command line processing

 Documentation/admin-guide/mm/hugetlbpage.rst |  26 ++++
 arch/arm64/include/asm/hugetlb.h             |   2 +
 arch/arm64/mm/hugetlbpage.c                  |  30 ++---
 arch/powerpc/include/asm/hugetlb.h           |   3 +
 arch/powerpc/mm/hugetlbpage.c                |  30 ++---
 arch/riscv/include/asm/hugetlb.h             |   3 +
 arch/riscv/mm/hugetlbpage.c                  |  24 ++--
 arch/s390/include/asm/hugetlb.h              |   3 +
 arch/s390/mm/hugetlbpage.c                   |  24 ++--
 arch/sparc/include/asm/hugetlb.h             |   3 +
 arch/sparc/mm/init_64.c                      |  42 ++-----
 arch/x86/include/asm/hugetlb.h               |   3 +
 arch/x86/mm/hugetlbpage.c                    |  23 ++--
 include/linux/hugetlb.h                      |   8 +-
 mm/hugetlb.c                                 | 126 ++++++++++++++-----
 15 files changed, 198 insertions(+), 152 deletions(-)

-- 
2.24.1
