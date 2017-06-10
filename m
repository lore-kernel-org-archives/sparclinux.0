From: kbuild test robot <lkp@intel.com>
Date: Sat, 10 Jun 2017 14:06:20 +0000
Subject: Re: [PATCH 2/2] include: warn for inconsistent endian config definition
Message-Id: <201706102219.7auwXKYx%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <sparclinux.vger.kernel.org>
References: <1496960243-196898-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1496960243-196898-3-git-send-email-babu.moger@oracle.com>
To: sparclinux@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Babu,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc4 next-20170609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Babu-Moger/Define-CPU_BIG_ENDIAN-or-warn-for-inconsistencies/20170610-200424
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All warnings (new ones prefixed by >>):

   In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
                    from include/asm-generic/bitops/le.h:5,
                    from include/asm-generic/bitops.h:34,
                    from arch/microblaze/include/asm/bitops.h:1,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:15,
                    from arch/microblaze/include/asm/bug.h:1,
                    from include/linux/bug.h:4,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:9:
>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
    #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
     ^~~~~~~
--
   In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
                    from include/asm-generic/bitops/le.h:5,
                    from include/asm-generic/bitops.h:34,
                    from arch/microblaze/include/asm/bitops.h:1,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:15,
                    from arch/microblaze/include/asm/bug.h:1,
                    from include/linux/bug.h:4,
                    from include/linux/page-flags.h:9,
                    from kernel/bounds.c:9:
>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
    #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
     ^~~~~~~
   In file included from arch/microblaze/include/uapi/asm/byteorder.h:7:0,
                    from include/asm-generic/bitops/le.h:5,
                    from include/asm-generic/bitops.h:34,
                    from arch/microblaze/include/asm/bitops.h:1,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/rculist.h:9,
                    from include/linux/pid.h:4,
                    from include/linux/sched.h:13,
                    from arch/microblaze/kernel/asm-offsets.c:13:
>> include/linux/byteorder/big_endian.h:7:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
    #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
     ^~~~~~~
   <stdin>:1326:2: warning: #warning syscall statx not implemented [-Wcpp]

vim +7 include/linux/byteorder/big_endian.h

     1	#ifndef _LINUX_BYTEORDER_BIG_ENDIAN_H
     2	#define _LINUX_BYTEORDER_BIG_ENDIAN_H
     3	
     4	#include <uapi/linux/byteorder/big_endian.h>
     5	
     6	#ifndef CONFIG_CPU_BIG_ENDIAN
   > 7	#warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
     8	#endif
     9	
    10	#include <linux/byteorder/generic.h>
    11	#endif /* _LINUX_BYTEORDER_BIG_ENDIAN_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--45Z9DzgjV8m4Oswq--
