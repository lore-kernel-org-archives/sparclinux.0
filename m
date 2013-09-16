From: Bob Picco <bpicco@meloft.net>
Date: Mon, 16 Sep 2013 13:46:35 +0000
Subject: [PATCH 0/4] sparc64 page table
Message-Id: <1379339199-9388-1-git-send-email-bpicco@meloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: bob picco <bpicco@meloft.net>

We encountered an issue with the current sparc64 page table implementation.
The T5 memory controller is different than T4. Its coarse grain interleave
factor causes the unsigned types of pgd_t and pmd_t to be insufficient.
We managed to partially resolve the issue by taking the physical address
and storing exactly the physical page frame within the pgd_t and pmd_t. This
would be deficient for a large memory configuration with all sockets
populated. This memblock=DEbug snippet of T5-2 is for a 256Gb configured
machine:
MEMBLOCK configuration:
 memory size =3D 0x3fcf214000
 memory.cnt  =3D 0x5
 memory[0x0]    [0x00000024400000-0x00001ff36e1fff], 0x1fcf2e2000 bytes
 memory[0x1]    [0x00001ff36e8000-0x00001ff36e9fff], 0x2000 bytes
 memory[0x2]    [0x00001ff36ee000-0x00001ff36effff], 0x2000 bytes
 memory[0x3]    [0x00080000000000-0x00081ffff23fff], 0x1ffff24000 bytes
 memory[0x4]    [0x00081ffff34000-0x00081ffff3dfff], 0xa000 bytes
 reserved.cnt  =3D 0x1
 reserved[0x0]  [0x00080000000000-0x00080000cd6980], 0xcd6981 bytes
. This is only a two socket machine and minimally memory configured.

The second platform to encounter this issue is Fujitsu's Athena. Athena
physical memory is mapped at the most significant bits.  You can observe
this from this snippet of boot up with memblock=DEbug
MEMBLOCK configuration:
 memory size =3D 0xff8f1fe000
 memory.cnt  =3D 0xb
 memory[0x0]    [0x00780070400000-0x0078007f69dfff], 0xf29e000 bytes
 memory[0x1]    [0x0078007fffe000-0x00781fffffffff], 0x1f80002000 bytes
 memory[0x2]    [0x00790000000000-0x00791fffffffff], 0x2000000000 bytes
 memory[0x3]    [0x007a0000000000-0x007a1fffffffff], 0x2000000000 bytes
 memory[0x4]    [0x007b0000000000-0x007b1fffffffff], 0x2000000000 bytes
 memory[0x5]    [0x007c0000000000-0x007c1fffffffff], 0x2000000000 bytes
 memory[0x6]    [0x007d0000000000-0x007d1fffffffff], 0x2000000000 bytes
 memory[0x7]    [0x007e0000000000-0x007e1fffffffff], 0x2000000000 bytes
 memory[0x8]    [0x007f0000000000-0x007f1ffff41fff], 0x1ffff42000 bytes
 memory[0x9]    [0x007f1ffff5a000-0x007f1ffff69fff], 0x10000 bytes
 memory[0xa]    [0x007f1ffffd6000-0x007f1ffffe1fff], 0xc000 bytes
 reserved.cnt  =3D 0x2
 reserved[0x0]  [0x007f0000000000-0x007f00010ca900], 0x10ca901 bytes
 reserved[0x1]  [0x007f0004000000-0x007f0008d4e462], 0x4d4e463 bytes
.

There are several ways to approach a solution for this. We chose to introdu=
ce
a four level page table scheme. This scheme promotes pgd_t and pmd_t to
unsigned long. The pud folding isn't used and the pud_t is also unsigned lo=
ng.

There are penalties for a four level scheme. A small memory increase because
of the addition of a pud. TSB misses will cost another memory load because
of the new level. We've yet to observe a negative ramification from the fou=
rth
level.

There is a configuration choice between the four level page table scheme
and the current three level page table scheme. It is our hope that the
exisiting three level scheme has been left unchanged functionally. This
can be viewed like sparc64 THP which impacted the existing three level page
table scheme and is configuration selectable.

There could potentially be further code consolidation by keying off of
pud folding or not. I feel it is better to leave the two levels as
independent as possible for now.

My skill level for naming leaves much to be desired at times. I'm certainly
not strongly attached to PGTABLE_LEVEL4.

thanx,

bob

bob picco (4):
  sparc64 expand linear mapping region
  sparc64 move three level page table scheme
  sparc64 four level page table support
  sparc64 kconfig four level page table

 arch/sparc/Kconfig                       |    9 ++
 arch/sparc/include/asm/page_64.h         |   20 +++-
 arch/sparc/include/asm/page_64_lvl3.h    |   15 +++
 arch/sparc/include/asm/page_64_lvl4.h    |   21 ++++
 arch/sparc/include/asm/pgalloc_64.h      |   16 +++
 arch/sparc/include/asm/pgtable_64.h      |  135 +++------------------
 arch/sparc/include/asm/pgtable_64_lvl3.h |  118 ++++++++++++++++++
 arch/sparc/include/asm/pgtable_64_lvl4.h |  191 ++++++++++++++++++++++++++=
++++
 arch/sparc/include/asm/sparsemem.h       |    5 +
 arch/sparc/include/asm/tsb.h             |   55 +++++++++
 arch/sparc/kernel/ktlb.S                 |   12 +-
 arch/sparc/kernel/smp_64.c               |    7 ++
 arch/sparc/mm/init_64.c                  |   36 ++++--
 arch/sparc/mm/init_64.h                  |    4 +
 14 files changed, 508 insertions(+), 136 deletions(-)
 create mode 100644 arch/sparc/include/asm/page_64_lvl3.h
 create mode 100644 arch/sparc/include/asm/page_64_lvl4.h
 create mode 100644 arch/sparc/include/asm/pgtable_64_lvl3.h
 create mode 100644 arch/sparc/include/asm/pgtable_64_lvl4.h

--=20
1.7.10.4

