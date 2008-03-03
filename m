From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 03 Mar 2008 19:26:51 +0000
Subject: sparc vs. gcc 4.3
Message-Id: <20080303192651.GL26072@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wli@holomorphy.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Trying to build a sparc kernel with a gcc 4.3 release candidate fails 
with the following error:

<--  snip  -->

...
  LD      arch/sparc/boot/image
arch/sparc/kernel/built-in.o:(__ex_table+0x394): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x39c): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x3a4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x3ac): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x3b4): undefined reference to `kernel_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x3bc): more undefined references to `kernel_unaligned_trap_fault' follow
arch/sparc/kernel/built-in.o:(__ex_table+0x46c): undefined reference to `user_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x474): undefined reference to `user_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x47c): undefined reference to `user_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x484): undefined reference to `user_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x48c): undefined reference to `user_unaligned_trap_fault'
arch/sparc/kernel/built-in.o:(__ex_table+0x494): more undefined references to `user_unaligned_trap_fault' follow
make[2]: *** [arch/sparc/boot/image] Error 1

<--  snip  -->

Does anyone have a clue what's going wrong here?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

