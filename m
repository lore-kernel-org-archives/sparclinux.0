From: Peter Hurley <peter@hurleysoftware.com>
Date: Sat, 30 Nov 2013 23:07:41 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <529A6FBD.7030908@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 11/29/2013 02:31 AM, Meelis Roos wrote:
>>>>> First I compared the configurations of working and nonworking machines
>>>>> (there were 2 different machines from the same era with problem), then
>>>>> did some conf bisecting and found that CONFIG_SUN_OPENPROMFS causes the
>>>>> RED problem in 3.12-rc5 when compiled modular and module loaded. It did
>>>>> not happen when it was compiled statically, or modular but module was
>>>>> not loaded. Reduced minimalistic configuration that causes this on Ultra
>>>>> 5 is attached to this mail.
>>
>> Is the problem unique to these 2 machines given this configuration, or is
>> the problem reproduceable on other machines using this configuration?
>
> Tried it on Sun E3500 with the same minimal config modified to boot
> there (scsi + console differences), did not trigger. I did get some
> other warning with all the lockdep config enabled, will investigate them
> separately.

Is the warning you received this one from your other email?

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2826 at kernel/lockdep.c:3535 check_flags+0x7c/0x240()
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
Modules linked in: openpromfs
CPU: 0 PID: 2826 Comm: reboot Tainted: G        W    3.12.0 #133
Call Trace:
  [0000000000454b6c] warn_slowpath_common+0x4c/0x80
  [0000000000454c4c] warn_slowpath_fmt+0x2c/0x40
  [0000000000499e3c] check_flags+0x7c/0x240
  [000000000049d000] lock_acquire+0x20/0x80
  [000000000077afe8] _raw_spin_lock+0x28/0x40
  [00000000005f8ef4] p1275_cmd_direct+0x14/0x60
  [00000000005f8980] prom_reboot+0x20/0x40
  [0000000000434c88] machine_restart+0x48/0x60
  [000000000047d9cc] kernel_restart+0x4c/0x60
  [000000000047db34] SyS_reboot+0x134/0x200
  [00000000004060b4] linux_sparc_syscall32+0x34/0x40
---[ end trace 4759822ebc3658d5 ]---
possible reason: unannotated irqs-off.
irq event stamp: 3799
hardirqs last  enabled at (3799): [<0000000000404b1c>] rtrap_xcall+0x18/0x20
hardirqs last disabled at (3797): [<0000000000459380>] __do_softirq+0x100/0x180
softirqs last  enabled at (3798): [<00000000004593dc>] __do_softirq+0x15c/0x180
softirqs last disabled at (3791): [<000000000042b89c>] do_softirq+0x5c/0xa0


Regards,
Peter Hurley
