From: Chris Ricker <kaboom@gatech.edu>
Date: Thu, 12 Feb 2004 16:50:46 +0000
Subject: Another 2.6.2-rc1 SMP crash
Message-Id: <Pine.GSO.4.58.0402121150040.17723@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

My dual Ultra 2 crashed again. Here's what was on the screen. It was partially
garbled, so I've put an * in front of the lines I'm reasonably confident of....

* spin_lock(fffff80000e4cd00) CPU#1 stuck at 0044a1e4, owner PC(00000000):CPU(ff)
* spin_lock(fffff80000e4cd00) CPU#1 stuck at 0044a1e4, owner PC(00000000):CPU(ff)
* spin_lock(fffff80000e4cd00) CPU#1 stuck at 0044a1e4, owner PC(00000000):CPU(ff)
* esp0: Aborting command
* esp0: dumping state
* esp0: dma -- cond_reg<b2bf8811> addr<00000000>
esp0: SW [sreg<17> sslcp<01> ircy<18>]
esp0: HW reread [sreg<17> sslcp<8c> ircy<08>]
esp0: current command [lyl<01> lun<00> pphdsc<MSGINDONE> cphdsc<MSGINDONE>]
* esp0: disconnected
* esp0: Aborting command
* esp0: dumping state
* esp0: dma -- cond-reg<b2bf8810> addr<00000000>
esp0: SW [sreg<17> sslcp<01> ircy<18>]
esp0: HW reread [sreg<17> sslcp<8c> ircy<00>]
esp0: current command [lyl<01> lun<00> pphdsc<UNISSUED> cphdsc<UNISSUED>]
* esp0: disconnected
* esp0: Resetting scsi bus
* spin_lock(fffff80000e4cd00) CPU#0 stuck at 0044a1e4, owner PC(00000000):CPU(ff)
* spin_lock(fffff80000e4cd00) CPU#0 stuck at 0044a1e4, owner PC(00000000):CPU(ff)
* spin_lock(fffff80000e4cd00) CPU#0 stuck at 0044a1e4, owner PC(00000000):CPU(ff)

This was with 2.6.2-rc1 + the zilog patch from Ben Collins.

Looking at my System.map, 0044a1e4 is near:

000000000044a000 T wait_task_inactive
000000000044a120 T kick_process
000000000044a1a0 t try_to_wake_up
000000000044a4e0 T wake_up_process
000000000044a500 T wake_up_state
000000000044a520 T sched_fork

Let me know if there's any other information I can provide.

thanks,
chris
