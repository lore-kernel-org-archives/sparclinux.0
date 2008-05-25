From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 25 May 2008 18:58:21 +0000
Subject: CONFIG_SPARC64_PAGE_SIZE_4MB build error
Message-Id: <20080525185821.GJ1791@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

During a compile test I ran into the following build error caused with 
CONFIG_SPARC64_PAGE_SIZE_4MB:

<--  snip  -->

...
  CC      init/main.o
In file included from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/gfp.h:4,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/slab.h:12,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/percpu.h:5,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/rcupdate.h:39,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/pid.h:4,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/sched.h:74,
                 from include2/asm/uaccess.h:10,
                 from include2/asm/elf.h:10,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/elf.h:7,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/module.h:14,
                 from /home/bunk/linux/kernel-2.6/git/linux-2.6/init/main.c:13:
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/mmzone.h:853:2: 
error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
make[2]: *** [init/main.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

