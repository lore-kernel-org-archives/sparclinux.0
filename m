From: Chris Ricker <kaboom@gatech.edu>
Date: Wed, 18 Feb 2004 21:29:30 +0000
Subject: another Ultra2 SMP crash
Message-Id: <Pine.GSO.4.58.0402181628060.21617@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is with 2.6.3-rc2, compiled SMP

All I had on the serial console was

spin_lock(fffff8003fef5eb0) CPU#1 stuck at 0045c0fc, owner PC(0045c0fc):CPU(1)
spin_lock(fffff8003fef5eb0) CPU#1 stuck at 0045c0fc, owner PC(0045c0fc):CPU(1)
spin_lock(fffff80000011140) CPU#0 stuck at 0044a3a4, owner PC(0044a3a4):CPU(1)
spin_lock(fffff80000011140) CPU#0 stuck at 0044a3a4, owner PC(0044a3a4):CPU(1)
spin_lock(fffff8003fef5eb0) CPU#1 stuck at 0045c0fc, owner PC(0045c0fc):CPU(1)
spin_lock(fffff80000011140) CPU#0 stuck at 0044a3a4, owner PC(0044a3a4):CPU(1)

0045c0fc has nearby:

000000000045bde0 t send_signal
000000000045bf60 t specific_send_sig_info
000000000045c0e0 T force_sig_info
000000000045c200 T force_sig_specific
000000000045c300 T zap_other_threads
000000000045c3e0 T group_send_sig_info


0044a3a4 has nearby:

000000000044a080 t __set_cpus_allowed
000000000044a1c0 T wait_task_inactive
000000000044a2e0 T kick_process
000000000044a360 t try_to_wake_up
000000000044a6a0 T wake_up_process
000000000044a6c0 T wake_up_state
000000000044a6e0 T sched_fork

Please let me know if any other info would be useful

thanks,
chris
