From: Adrian Bunk <bunk@stusta.de>
Date: Sun, 22 Jan 2006 17:53:56 +0000
Subject: Kernel Bugzilla #2682: arch/sparc/kernel/sun4m_smp.c: [OPERA] potential error detected by an analysi
Message-Id: <20060122175356.GF10003@stusta.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Kernel Bugzilla #2682 [1] contains the following report by
Zhenmin <lzmhome@yahoo.com>:

<--  snip  -->

The potential error is detected by a static analysis tool in
/arch/sparc/kernel/sun4m_smp.c:227-228

225  if(cpu_callin_map[i]) {
226    /* Another "Red Snapper". */
227    __cpu_number_map[i] = i;
228    __cpu_logical_map[i] = i;
229  } else {

Lines 227-228 may be changed to:

227    __cpu_number_map[i] = cpucount;
228    __cpu_logical_map[cpucount] = i;

Can anyone confirm whether it is a bug or not?

<--  snip  -->

(the line numbers are wrong by a few lines in recent kernels, but
 "Red Snapper" is easy to find in the file.

AFAIR SMP is not working on sparc32 in kernel 2.6, but could you anyways 
comment on this issue?

TIA
Adrian

[1] http://bugzilla.kernel.org/show_bug.cgi?id&82

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

