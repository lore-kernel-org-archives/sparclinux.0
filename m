From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 12 Jun 2017 20:30:08 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <002f7627-1ce5-eabb-967d-fe93a3660f03@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201706102219.7auwXKYx%fengguang.wu@intel.com>
In-Reply-To: <201706102219.7auwXKYx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, ysato@users.sourceforge.jp, geert@linux-m68k.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, viro@zeniv.linux.org.uk, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, monstr@monstr.eu

Hi All,

On 6/10/2017 9:06 AM, kbuild test robot wrote:
> Hi Babu,
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.12-rc4 next-20170609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Babu-Moger/Define-CPU_BIG_ENDIAN-or-warn-for-inconsistencies/20170610-200424
> config: microblaze-mmu_defconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 6.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          make.cross ARCH=microblaze
>
> All warnings (new ones prefixed by >>):
>
>     In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
>                      from include/asm-generic/bitops/le.h:5,
>                      from include/asm-generic/bitops.h:34,
>                      from arch/microblaze/include/asm/bitops.h:1,
>                      from include/linux/bitops.h:36,
>                      from include/linux/kernel.h:10,
>                      from include/asm-generic/bug.h:15,
>                      from arch/microblaze/include/asm/bug.h:1,
>                      from include/linux/bug.h:4,
>                      from include/linux/page-flags.h:9,
>                      from kernel/bounds.c:9:
>>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>      #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>       ^~~~~~~
> --
>     In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
>                      from include/asm-generic/bitops/le.h:5,
>                      from include/asm-generic/bitops.h:34,
>                      from arch/microblaze/include/asm/bitops.h:1,
>                      from include/linux/bitops.h:36,
>                      from include/linux/kernel.h:10,
>                      from include/asm-generic/bug.h:15,
>                      from arch/microblaze/include/asm/bug.h:1,
>                      from include/linux/bug.h:4,
>                      from include/linux/page-flags.h:9,
>                      from kernel/bounds.c:9:
>>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>      #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>       ^~~~~~~
>     In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
>                      from include/asm-generic/bitops/le.h:5,
>                      from include/asm-generic/bitops.h:34,
>                      from arch/microblaze/include/asm/bitops.h:1,
>                      from include/linux/bitops.h:36,
>                      from include/linux/kernel.h:10,
>                      from include/linux/list.h:8,
>                      from include/linux/rculist.h:9,
>                      from include/linux/pid.h:4,
>                      from include/linux/sched.h:13,
>                      from arch/microblaze/kernel/asm-offsets.c:13:
>>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>      #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>       ^~~~~~~
>     <stdin>:1326:2: warning: #warning syscall statx not implemented [-Wcpp]
>
> vim +7 include/linux/byteorder/big_endian.h
>
>       1	#ifndef _LINUX_BYTEORDER_BIG_ENDIAN_H
>       2	#define _LINUX_BYTEORDER_BIG_ENDIAN_H
>       3	
>       4	#include <uapi/linux/byteorder/big_endian.h>
>       5	
>       6	#ifndef CONFIG_CPU_BIG_ENDIAN
>     > 7	#warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>       8	#endif
>       9	
>      10	#include <linux/byteorder/generic.h>
>      11	#endif /* _LINUX_BYTEORDER_BIG_ENDIAN_H */
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Looks like microblaze can be configured to either little or big endian 
formats.  How about
adding a choice statement to address this.
Here is my proposed patch.
===================diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 85885a5..74aa5de 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -35,6 +35,22 @@ config MICROBLAZE
         select VIRT_TO_BUS
         select CPU_NO_EFFICIENT_FFS

+# Endianness selection
+choice
+       prompt "Endianness selection"
+       default CPU_BIG_ENDIAN
+       help
+         microblaze architectures can be configured for either little or
+         big endian formats. Be sure to select the appropriate mode.
+
+config CPU_BIG_ENDIAN
+       bool "Big endian"
+
+config CPU_LITTLE_ENDIAN
+       bool "Little endian"
+
+endchoice
+
  config SWAP
         def_bool n



