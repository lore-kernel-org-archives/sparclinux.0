From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 21:13:05 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTim7mDgy3tPmofYb8sdWb00_JHdVk+ZLVeb7Gc7D@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

As expected, esp_debug gives a lot of ouput.
Is there anything in particular to look out for ?

Btw:
At this point:
> Give root password for maintenance
> (or type Control-D to continue):

I can logon, and reads from disk seem to go fine.

# mount -n -o remount,rw /
Then also writes to disk seem to go fine.


So, is this an ESP or EXT2 bug at all ?

Marcel

On Tue, Mar 8, 2011 at 9:22 PM, Marcel van Nies <morcles@gmail.com> wrote:
> Hi,
>
> The good news:
> sparc-next-2.6 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b rever=
ted
> does NOT segfault. I did not apply the genirq patch yet.
>
> The bad news:
> Segfault gone, say hello to EXT2 read failure =A0 :o(
>
> I'll rebuild this kernel with the esp_debug.patch Sam sent a couple of da=
ys ago.
>
>
> [ =A0 =A00.233333] esp: esp0, regs[fd00a000:fd009000] irq[36]
> [ =A0 =A00.236666] esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
> [ =A0 =A03.243333] scsi0 : esp
> [ =A0 =A03.483332] scsi 0:0:1:0: Direct-Access =A0 =A0 FUJITSU =A0MAP3735N
> SUN72G =A00401 PQ: 0 ANSI: 4
> [ =A0 =A03.486666] scsi target0:0:1: Beginning Domain Validation
> [ =A0 =A03.493332] scsi target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, o=
ffset 15)
> [ =A0 =A03.499999] scsi target0:0:1: Domain Validation skipping write tes=
ts
> [ =A0 =A03.503332] scsi target0:0:1: Ending Domain Validation
> [ =A0 =A03.743332] scsi 0:0:3:0: Direct-Access =A0 =A0 FUJITSU =A0MAP3735N
> SUN72G =A00401 PQ: 0 ANSI: 4
> [ =A0 =A03.746666] scsi target0:0:3: Beginning Domain Validation
> [ =A0 =A03.753332] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, o=
ffset 15)
> [ =A0 =A03.756666] scsi target0:0:3: Domain Validation skipping write tes=
ts
> [ =A0 =A03.759999] scsi target0:0:3: Ending Domain Validation
> [ =A0 =A04.469999] esp: esp1, regs[fd00c000:fd00b000] irq[53]
> [ =A0 =A04.473332] esp: esp1 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7
> [ =A0 =A07.479999] scsi1 : esp
> ...
> [ =A0 11.029998] sd 0:0:1:0: [sda] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
> [ =A0 11.033332] sd 0:0:3:0: [sdb] 143374738 512-byte logical blocks:
> (73.4 GB/68.3 GiB)
> [ =A0 11.036665] sd 0:0:1:0: [sda] Write Protect is off
> [ =A0 11.043332] sd 0:0:1:0: [sda] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [ =A0 11.046665] sd 0:0:3:0: [sdb] Write Protect is off
> [ =A0 11.053332] sd 0:0:3:0: [sdb] Write cache: disabled, read cache:
> enabled, doesn't support DPO or FUA
> [ =A0 11.066665] =A0sda: sda1 sda2 sda3
> [ =A0 11.073332] =A0sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
> [ =A0 11.089998] sd 0:0:1:0: [sda] Attached SCSI disk
> [ =A0 11.093332] sd 0:0:3:0: [sdb] Attached SCSI disk
> [ =A0 11.106665] EXT3-fs: barriers not enabled
> [ =A0 11.113332] kjournald starting. =A0Commit interval 5 seconds
> [ =A0 11.116665] EXT3-fs (sdb4): mounted filesystem with ordered data mode
> [ =A0 11.119998] VFS: Mounted root (ext3 filesystem) readonly on device 8=
:20.
> [ =A0 11.123332] Freeing unused kernel memory: 108k freed
> INIT: version 2.86 booting
> [ =A0 12.673332] NET: Registered protocol family 1
>
> Gentoo Linux; http://www.gentoo.org/
> =A0Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2
>
> =A0* Mounting proc at /proc ... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ ok ]
> =A0* Mounting sysfs at /sys ... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ ok ]
> =A0* Mounting /dev for udev ... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ ok ]
> ...
> blahblah
> ...
> =A0* Checking root filesystem ...fsck.ext3: No such file or directory
> while trying to open /dev/sdb4
> /dev/sdb4:
> The superblock could not be read or does not describe a correct ext2
> filesystem. =A0If the device is valid and it really contains an ext2
> filesystem (and not swap or ufs or something else), then the superblock
> is corrupt, and you might try running e2fsck with an alternate superblock:
> =A0 =A0e2fsck -b 8193 <device>
>
> =A0* Filesystem couldn't be fixed :(
> =A0 =A0 =A0 =A0 [ !! ]
> Give root password for maintenance
> (or type Control-D to continue):
>
>
> Marcel
>
>
> On Tue, Mar 8, 2011 at 12:17 PM, Marcel van Nies <morcles@gmail.com> wrot=
e:
>> Hi,
>>
>> 2.6.33.7 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reverted
>> does not segfault.
>> I also tried sparc-next-2.6, but I messed up my tree somehow. I will
>> try again later.
>>
>> M
>>
>> On Tue, Mar 8, 2011 at 8:45 AM, Marcel van Nies <morcles@gmail.com> wrot=
e:
>>> Hi,
>>>
>>>> But first step is to get confirmation that reverting this commit
>>>> indeed fixes the bug
>>>
>>> I'll try that.
>>> M
>>>
>>> On Tue, Mar 8, 2011 at 8:37 AM, Marcel van Nies <morcles@gmail.com> wro=
te:
>>>> Hi,
>>>>
>>>> It appears that two consecutive commits are causing problems on
>>>> hyperSPARC, I noticed that too late.
>>>>
>>>> Commit 4d14a459857bd151ecbd14bcd37b4628da00792b (the one I reported
>>>> earlier) only causes the system to hang, not panic:
>>>> [ =A0 11.266665] sd 0:0:1:0: [sda] Attached SCSI disk
>>>> [ =A0 11.279998] sd 0:0:3:0: [sdb] Attached SCSI disk
>>>> [ =A0 11.299998] kjournald starting. =A0Commit interval 5 seconds
>>>> [ =A0 11.303332] EXT3-fs: mounted filesystem with writeback data mode.
>>>> [ =A0 11.306665] VFS: Mounted root (ext3 filesystem) readonly on devic=
e 8:20.
>>>> [ =A0 11.309998] Freeing unused kernel memory: 100k freed
>>>> <system hangs here - stop-A does go back to prom>
>>>>
>>>> and
>>>> commit c658ad1b4e1520511da8323aa5e60d444cc303ed
>>>> Author: David S. Miller <davem@davemloft.net>
>>>> Date: =A0 Fri Dec 11 00:44:47 2009 -0800
>>>>
>>>> =A0 =A0sparc64: Add syscall tracepoint support.
>>>>
>>>> =A0 =A0Signed-off-by: David S. Miller <davem@davemloft.net>
>>>>
>>>> actually makes the kernel panic:
>>>> [ =A0 11.336665] Freeing unused kernel memory: 100k freed
>>>> [ =A0 11.419998] Kernel panic - not syncing: Attempted to kill init!
>>>> [ =A0 11.423332] [f002f5b8 : do_group_exit+0x84/0xb4 ]
>>>> =A0[f0039490 : get_signal_to_deliver+0x338/0x35c ]
>>>> =A0[f00124cc : do_signal+0x30/0x8f0 ]
>>>> =A0[f0012da0 : do_notify_resume+0x14/0x38 ]
>>>> =A0[f000fca4 : signal_p+0x14/0x24 ]
>>>> =A0[f000edfc : srmmu_fault+0x58/0x68 ]
>>>> [ =A0 11.466665] Press Stop-A (L1-A) to return to the boot prom
>>>>
>>>>
>>>> Marcel
>>>>
>>>>
>>>> On Tue, Mar 8, 2011 at 8:08 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>>>> On Mon, Mar 07, 2011 at 11:01:20PM -0800, David Miller wrote:
>>>>>> From: Sam Ravnborg <sam@ravnborg.org>
>>>>>> Date: Tue, 8 Mar 2011 07:00:39 +0100
>>>>>>
>>>>>> > Added davem...
>>>>>> > We see strange SEGV faults in userspace and fail to read from ext2=
..
>>>>>> > All on some (but not all) sparc32 boxes.
>>>>>>
>>>>>> I saw the original report.
>>>>>>
>>>>>> But reverting this commit is the wrong thing to do from what I can
>>>>>> tell.
>>>>>>
>>>>>> Either we have:
>>>>>>
>>>>>> 1) A compiler code gen bug.
>>>>>>
>>>>>> 2) Some piece of code which is sparc32 specific is invoking memset
>>>>>> =A0 =A0or memcpy in a way which makes assumptions which are in fact =
not
>>>>>> =A0 =A0valid
>>>>>>
>>>>>> 3) The code change is merely making cache offsets change, masking the
>>>>>> =A0 =A0true problem
>>>>>>
>>>>>> Especially in cases #2 and #3 we're just hiding a heisen-bug and
>>>>>> not fixing the real problem.
>>>>> Agree on this.
>>>>> But first step is to get confirmation that reverting this commit
>>>>> indeed fixes the bug. Then we can go hunting for 2), 3) or 1).
>>>>> I hope we will find that 2) is the culprint.
>>>>>
>>>>> =A0 =A0 =A0 =A0Sam
>>>>>
>>>>
>>>
>>
>
