From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 03 Aug 2020 09:18:23 +0000
Subject: [sparc64] unable to build v5.8 / master on sparc64 , bisect attached
Message-Id: <CADxRZqzyxzN9yC79kjhtdpL9QT6ybgTsSCb3G1U8zJHZy-W_9w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sparc kernel list <sparclinux@vger.kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>

Hello!

I'm unable to build kernel (master git) with the following messages:

linux-2.6$ make
...
  CC      crypto/drbg.o
In file included from ./arch/sparc/include/asm/percpu_64.h:11,
                 from ./arch/sparc/include/asm/percpu.h:5,
                 from ./include/linux/random.h:14,
                 from ./include/crypto/drbg.h:43,
                 from crypto/drbg.c:100:
./arch/sparc/include/asm/trap_block.h:54:39: error: ‘NR_CPUS’
undeclared here (not in a function)
   54 | extern struct trap_per_cpu trap_block[NR_CPUS];
      |                                       ^~~~~~~
make[1]: *** [scripts/Makefile.build:281: crypto/drbg.o] Error 1
make: *** [Makefile:1756: crypto] Error 2

can someone help me please? Thanks.

git bisect log:

git bisect start
# bad: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect bad bcf876870b95592b52519ed4aafcf9d95999bc9c
# good: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
git bisect good 92ed301919932f777713b9172e525674157e983d
# bad: [0ae3495b6502cf93634cbd027cb2f6f9f83a406f] Merge tag
'for-linus-2020-08-01' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect bad 0ae3495b6502cf93634cbd027cb2f6f9f83a406f
# bad: [aa54ea903abb02303bf55855fb51e3fcee135d70] ARM: percpu.h: fix build error
git bisect bad aa54ea903abb02303bf55855fb51e3fcee135d70
# good: [c2f3850df7f95537e79c561f7be49df2e4ad8060] Merge tag
'drm-fixes-2020-07-29' of git://anongit.freedesktop.org/drm/drm into
master
git bisect good c2f3850df7f95537e79c561f7be49df2e4ad8060
# bad: [0513b9d75c07cbcdfda3778b636d3d131d679eb1] Merge tag
'io_uring-5.8-2020-07-30' of git://git.kernel.dk/linux-block
git bisect bad 0513b9d75c07cbcdfda3778b636d3d131d679eb1
# good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag
'audit-pr-20200729' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect good d3590ebf6f91350192737dd1d1b219c05277f067
# good: [4ae6dbd683860b9edc254ea8acf5e04b5ae242e5] io_uring: fix
lockup in io_fail_links()
git bisect good 4ae6dbd683860b9edc254ea8acf5e04b5ae242e5
# bad: [1c9df907da83812e4f33b59d3d142c864d9da57f] random: fix circular
include dependency on arm64 after addition of percpu.h
git bisect bad 1c9df907da83812e4f33b59d3d142c864d9da57f
