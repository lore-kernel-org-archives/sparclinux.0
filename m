From: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 21 Oct 2016 16:35:47 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <0EEFCE1F-74FB-486E-BAD1-DD0CB25821B5@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 21 Oct 2016, at 16:49, Rob Gardner <rob.gardner@oracle.com> wrote:
> 
> On 10/21/2016 06:57 AM, Anatoly Pugachev wrote:
>> On Fri, Oct 21, 2016 at 12:12 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>>> On Wed, Sep 7, 2016 at 1:01 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>>>> On Wed, Sep 7, 2016 at 12:22 PM, John Paul Adrian Glaubitz
>>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>>> Hello!
>>>>> 
>>>>> After kernel 4.7.2 entered Debian unstable, I decided to upgrade the buildds and ran into an
>>>>> apparent regression with the 4.7.x kernels on sun4u machines:
>>>> It's not only with sun4u, we're getting kernel OOPS on sun4v as well:
>>> debian packaged 4.7.6 kernel, machine is a LDOM on T5-2 server, OOPS
>>> after kernel boot within a few minutes:
>> 
>> reproduced with latest git 4.9.0-rc1+ (v4.9-rc1-148-g6f33d645) kernel.
>> Machine boots ok, i can login as unprivileged user (via ssh), compile
>> and install kernel, run sudo, install packages (apt upgrade),
>> apache/mysql and other startup daemons works, but if I try to login as
>> root via ssh, it throws kernel oops / illegal instruction.
>> 
>> Any idea how to debug this?
>> 
>> otherhost$ ssh ttip -l root -v
>> ...
>> debug1: channel 0: new [client-session]
>> debug1: Requesting no-more-sessions@openssh.com
>> debug1: Entering interactive session.
>> Write failed: Broken pipe
>> $
>> 
>> I can strace -f -p $pid_of_sshd , but not sure it would help.
>> 
>> URL version => http://paste.debian.net/plain/884751
>> kernel config => http://paste.debian.net/plain/884806
>> 
>> NOTICE: Entering OpenBoot.
>> NOTICE: Fetching Guest MD from HV.
>> NOTICE: Starting additional cpus.
>> NOTICE: Initializing LDC services.
>> NOTICE: Probing PCI devices.
>> NOTICE: Finished PCI probing.
>> 
>> SPARC T5-2, No Keyboard
>> Copyright (c) 1998, 2016, Oracle and/or its affiliates. All rights reserved.
>> OpenBoot 4.38.5, 32.0000 GB memory available, Serial #83494642.
>> Ethernet address 0:14:4f:fa:6:f2, Host ID: 84fa06f2.
>> 
>> 
>> 
>> Boot device: vdisk1  File and args:
>> SILO Version 1.4.14
>> boot:
>> Allocated 64 Megs of memory at 0x40000000 for kernel
>> Uncompressing image...
>> Loaded kernel version 4.9.0
>> Loading initial ramdisk (13616359 bytes at 0x74000000 phys, 0x40C00000 virt)...
>> 
>> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.5 2016/06/22 19:36'
>> [    0.000000] PROMLIB: Root node compatible: sun4v
>> [    0.000000] Linux version 4.9.0-rc1+ (mator@ttip) (gcc version
>> 6.2.0 20161010 (Debian 6.2.0-6+sparc64) ) #19 SMP Fri Oct 21 14:47:01
>> MSK 2016
>> [    0.000000] bootconsole [earlyprom0] enabled
>> [    0.000000] ARCH: SUN4V
>> ... snip ...
>> [5446612.115339] dbus-daemon(521): Kernel illegal instruction [#3]
>> [5446612.115342] CPU: 15 PID: 521 Comm: dbus-daemon Tainted: G      D
>>        4.9.0-rc1+ #19
>> [5446612.115347] task: fff800080b331bc0 task.stack: fff80007f937c000
>> [5446612.115349] TSTATE: 0000004411001606 TPC: 00000000005ccfec TNPC:
>> 00000000005ccff0 Y: 00000000    Tainted: G      D
>> [5446612.115353] TPC: <__kmalloc_track_caller+0x14c/0x240>
>> [5446612.115355] g0: fff800080fb28b00 g1: 0000000000400000 g2:
>> 0000000000000000 g3: 00000000c0000000
>> [5446612.115357] g4: fff800080b331bc0 g5: fff800082c5b0000 g6:
>> fff80007f937c000 g7: 0000000000003c06
>> [5446612.115358] o0: 0000000000000000 o1: 00000000025106c0 o2:
>> 000000005a5a5a5a o3: fff800080fb28b00
>> [5446612.115360] o4: 5a5a5a5a5a5a5a5a o5: 0000000000000028 sp:
>> fff80007f937eda1 ret_pc: 00000000005ccfe4
>> [5446612.115362] RPC: <__kmalloc_track_caller+0x144/0x240>
>> [5446612.115365] l0: fff8000030402800 l1: 000007feffe44e40 l2:
>> 000007feffe452b0 l3: 0000000000000000
>> [5446612.115367] l4: 0000000000000000 l5: 0000000000000020 l6:
>> fff8000100b875c8 l7: fff800010026bf30
>> [5446612.115368] i0: 0000000000000240 i1: 00000000025106c0 i2:
>> 0000000000864e00 i3: 00000000025106c0
>> [5446612.115371] i4: 0000000000000000 i5: 00000000025106c0 i6:
>> fff80007f937ee51 i7: 0000000000864d40
>> [5446612.115376] I7: <__kmalloc_reserve.isra.5+0x20/0x80>
>> [5446612.115376] Call Trace:
>> [5446612.115378]  [0000000000864d40] __kmalloc_reserve.isra.5+0x20/0x80
>> [5446612.115381]  [0000000000864e00] __alloc_skb+0x60/0x180
>> [5446612.115383]  [0000000000864f68] alloc_skb_with_frags+0x48/0x1c0
>> [5446612.115390]  [000000000085f54c] sock_alloc_send_pskb+0x1ec/0x220
>> [5446612.115400]  [00000000009367a8] unix_stream_sendmsg+0x228/0x380
>> [5446612.115404]  [0000000000859ddc] sock_sendmsg+0x3c/0x80
>> [5446612.115406]  [000000000085a810] ___sys_sendmsg+0x250/0x260
>> [5446612.115409]  [000000000085b794] __sys_sendmsg+0x34/0x80
>> [5446612.115411]  [000000000085b800] SyS_sendmsg+0x20/0x40
>> [5446612.115415]  [00000000004061f4] linux_sparc_syscall+0x34/0x44
>> [5446612.115417] Caller[0000000000864d40]: __kmalloc_reserve.isra.5+0x20/0x80
>> [5446612.115419] Caller[0000000000864e00]: __alloc_skb+0x60/0x180
>> [5446612.115423] Caller[0000000000864f68]: alloc_skb_with_frags+0x48/0x1c0
>> [5446612.115425] Caller[000000000085f54c]: sock_alloc_send_pskb+0x1ec/0x220
>> [5446612.115428] Caller[00000000009367a8]: unix_stream_sendmsg+0x228/0x380
>> [5446612.115430] Caller[0000000000859ddc]: sock_sendmsg+0x3c/0x80
>> [5446612.115433] Caller[000000000085a810]: ___sys_sendmsg+0x250/0x260
>> [5446612.115435] Caller[000000000085b794]: __sys_sendmsg+0x34/0x80
>> [5446612.115437] Caller[000000000085b800]: SyS_sendmsg+0x20/0x40
>> [5446612.115439] Caller[00000000004061f4]: linux_sparc_syscall+0x34/0x44
>> [5446612.115442] Caller[fff800010081770c]: 0xfff800010081770c
>> [5446612.115444] Instruction DUMP:
>> [5446612.115445]  ba100008
>> [5446612.115446]  400f1d4f
>> [5446612.115447]  01000000
>> [5446612.115447] <3ffffff2>
>> [5446612.115448]  01000000
>> [5446612.115450]  106fffbe
>> [5446612.115451]  01000000
>> [5446612.115452]  c611a036
>> [5446612.115452]  05002c16
>> [5446612.115452]
>> [5446612.115778] Caller[00000000005f9ed4]: SyS_mkdir+0x14/0x40
>> [5446612.115791] Caller[00000000004061f4]: linux_sparc_syscall+0x34/0x44
>> [5446612.115802] Caller[fff80001001ef870]: 0xfff80001001ef870
>> [5446612.115818] Instruction DUMP:[5446612.115823]  ba100008
>>  400f1baf [5446612.115839]  01000000
>> <3ffffff2>[5446612.115852]  01000000
>>  106fffbe [5446612.115866]  01000000
>>  c611a036 [5446612.115879]  05002c16
>> [5446612.115892]
>> [5446612.115902] Fixing recursive fault but reboot is needed!
> 
> 
> In the instruction dump, the offending instruction is always 3ffffff2, and according the the opcode map, this is some kind of Fujitsu Athena instruction which probably ought to never be generated by gcc. Can you check to see if this instruction is in your vmlinux file? Do 'objdump -d vmlinux' and go to the addresses shown in TPC in the dump (ie, 00000000005ccfe) and see what's there. If you see 3ffffff2, then somehow some bogus instruction made it into the vmlinux executable. If you see something else, then it means that the instruction got changed in memory after the system was booted. That could be either a stray memory write or a boot time patch gone wrong. Either way, it may help narrow down the problem.

Hi Rob,
They are definitely NOPs in vmlinux being clobbered at load/runtime. According
to "gdb vmlinux", the call to _cond_resched is coming from mm/slab.h
slab_pre_alloc_hook (the call to might_sleep_if). What's the best way to get a
backtrace for writes to this address?

Regards,
James