From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 07 Feb 2008 23:12:30 +0000
Subject: sparc compile error
Message-Id: <20080207231230.GE7198@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Rientjes <rientjes@google.com>, wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Commit 3062fc67dad01b1d2a15d58c709eff946389eca4 broke sparc:

<--  snip  -->

...
  CC      init/do_mounts.o
In file included from include/linux/mm.h:39,
                 from include/linux/memcontrol.h:24,
                 from include/linux/swap.h:8,
                 from include/linux/suspend.h:7,
                 from init/do_mounts.c:6:
include/asm/pgtable.h:344: warning: parameter names (without types) in function declaration
include/asm/pgtable.h:345: warning: parameter names (without types) in function declaration
include/asm/pgtable.h:346: error: expected '=', ',', ';', 'asm' or '__attribute__' before '___f___swp_entry'
make[1]: *** [init/do_mounts.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

