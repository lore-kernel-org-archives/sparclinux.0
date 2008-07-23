From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 23 Jul 2008 09:41:54 +0000
Subject: sparc64 show_stack() prints garbage
Message-Id: <20080723094154.GD14846@cs181140183.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

http://bugzilla.kernel.org/show_bug.cgi?id139 contains a bug report 
with the following trace:

------------[ cut here ]------------                                            
WARNING: at drivers/cpufreq/cpufreq.c:1391
cpufreq_register_notifier+0x50/0x60()
Modules linked in:                                                              
Call Trace:                                                                     
 [0000000000605270] cpufreq_register_notifier+0x58/0x60                         
 [00000000007708e0] start_kernel+0x1f0/0x324                                    
 [0000000000680e08] auxio_probe+0x0/0xe8                                        
 [0000000000000000] 0x8                                                         
---[ end trace 139ce121c98e96c9 ]---

The first two lines of the trace are correct (and comment #3 contains a 
description what the bug is), but the latter two lines are obviously 
garbage.

The problem might be related to the fact that a WARN_ON was triggered 
during time_init(), which runs quite early after bootup.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

