From: Meelis Roos <mroos@linux.ee>
Date: Mon, 18 Nov 2013 06:21:51 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1311180819390.5183@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> This patch seems to switch ldata with its read_buf and echo_buf from 
> kmalloc/kfree to vmalloc/vfree (the bufs are now inlined in ldata, not 
> separately allocated).
> 
> More fields in ldata are now explicitly initialized to zero instead of 
> kzalloc doing it before. However, I do not see the initialization of 
> some of the fields - maybe they are done later in the code? I noticed 
> process_char_map, raw, real_raw, icanon, read_buf, echo_buf that were 
> zeroed before but I did not find explicit zeroing of them after the 
> patch. However, just adding a memset to zero ldata after vmalloc does 
> not change anything.
> 
> Openpromfs does not seem to be changed after 3.11 and it does not seem 
> to use any tty layer functions.
> 
> I still have no idea how it would interact.

I turned off most imaginable debug options - pagealloc, kobject, lockdep 
and kmemcheck among others. Lockdep got one on still working kernel, 
with the state just at the bad commit, on shutdown:

===========================
[ INFO: possible circular locking dependency detected ]
3.11.0-rc2-00058-g20bafb3-dirty #121 Tainted: G        W   
-------------------------------------------------------
bash/2383 is trying to acquire lock:
 (&tty->termios_rwsem){++++.+}, at: [<0000000000633648>] n_tty_read+0x368/0x620

but task is already holding lock:
 (&ldata->atomic_read_lock){+.+.+.}, at: [<000000000063343c>] n_tty_read+0x15c/0x620

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ldata->atomic_read_lock){+.+.+.}:
       [<0000000000495bd0>] validate_chain.isra.12+0x550/0x660
       [<000000000049898c>] __lock_acquire+0x96c/0xa40
       [<0000000000499058>] lock_acquire+0x58/0x80
       [<000000000076da6c>] mutex_lock_interruptible_nested+0x4c/0x400
       [<000000000063343c>] n_tty_read+0x15c/0x620
       [<000000000062e014>] tty_read+0x74/0xe0
       [<00000000004fad70>] vfs_read+0x70/0x140
       [<00000000004faf90>] SyS_read+0x30/0x80
       [<00000000004060b4>] linux_sparc_syscall32+0x34/0x40

-> #0 (&tty->termios_rwsem){++++.+}:
       [<000000000049559c>] check_prevs_add+0xbc/0x1a0
       [<0000000000495bd0>] validate_chain.isra.12+0x550/0x660
       [<000000000049898c>] __lock_acquire+0x96c/0xa40
       [<0000000000499058>] lock_acquire+0x58/0x80
       [<000000000076fd30>] down_read+0x30/0x60
       [<0000000000633648>] n_tty_read+0x368/0x620
       [<000000000062e014>] tty_read+0x74/0xe0
       [<00000000004fad70>] vfs_read+0x70/0x140
       [<00000000004faf90>] SyS_read+0x30/0x80
       [<00000000004060b4>] linux_sparc_syscall32+0x34/0x40

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ldata->atomic_read_lock);
                               lock(&tty->termios_rwsem);
                               lock(&ldata->atomic_read_lock);
  lock(&tty->termios_rwsem);

 *** DEADLOCK ***

2 locks held by bash/2383:
 #0:  (&tty->ldisc_sem){++++++}, at: [<0000000000635f90>] tty_ldisc_ref_wait+0x10/0x40
 #1:  (&ldata->atomic_read_lock){+.+.+.}, at: [<000000000063343c>] n_tty_read+0x15c/0x620

stack backtrace:
CPU: 0 PID: 2383 Comm: bash Tainted: G        W    3.11.0-rc2-00058-g20bafb3-dirty #121
Call Trace:
 [00000000007637c4] print_circular_bug+0xc4/0xd4
 [0000000000494d50] check_prev_add+0x170/0x900
 [000000000049559c] check_prevs_add+0xbc/0x1a0
 [0000000000495bd0] validate_chain.isra.12+0x550/0x660
 [000000000049898c] __lock_acquire+0x96c/0xa40
 [0000000000499058] lock_acquire+0x58/0x80
 [000000000076fd30] down_read+0x30/0x60
 [0000000000633648] n_tty_read+0x368/0x620
 [000000000062e014] tty_read+0x74/0xe0
 [00000000004fad70] vfs_read+0x70/0x140
 [00000000004faf90] SyS_read+0x30/0x80
 [00000000004060b4] linux_sparc_syscall32+0x34/0x40

This is UP machine so the race probably did not happen?

-- 
Meelis Roos (mroos@linux.ee)
