From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 20:22:07 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTi=iuSrUGyCAbOgft9xebr2emC8Mg8DqB9r1rYCq@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

The good news:
sparc-next-2.6 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reverted
does NOT segfault. I did not apply the genirq patch yet.

The bad news:
Segfault gone, say hello to EXT2 read failure   :o(

I'll rebuild this kernel with the esp_debug.patch Sam sent a couple of days=
 ago.


[    0.233333] esp: esp0, regs[fd00a000:fd009000] irq[36]
[    0.236666] esp: esp0 is a FAS100A, 40 MHz (ccf=3D0), SCSI ID 7
[    3.243333] scsi0 : esp
[    3.483332] scsi 0:0:1:0: Direct-Access     FUJITSU  MAP3735N
SUN72G  0401 PQ: 0 ANSI: 4
[    3.486666] scsi target0:0:1: Beginning Domain Validation
[    3.493332] scsi target0:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
15)
[    3.499999] scsi target0:0:1: Domain Validation skipping write tests
[    3.503332] scsi target0:0:1: Ending Domain Validation
[    3.743332] scsi 0:0:3:0: Direct-Access     FUJITSU  MAP3735N
SUN72G  0401 PQ: 0 ANSI: 4
[    3.746666] scsi target0:0:3: Beginning Domain Validation
[    3.753332] scsi target0:0:3: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
15)
[    3.756666] scsi target0:0:3: Domain Validation skipping write tests
[    3.759999] scsi target0:0:3: Ending Domain Validation
[    4.469999] esp: esp1, regs[fd00c000:fd00b000] irq[53]
[    4.473332] esp: esp1 is a FASHME, 40 MHz (ccf=3D0), SCSI ID 7
[    7.479999] scsi1 : esp
...
[   11.029998] sd 0:0:1:0: [sda] 143374738 512-byte logical blocks:
(73.4 GB/68.3 GiB)
[   11.033332] sd 0:0:3:0: [sdb] 143374738 512-byte logical blocks:
(73.4 GB/68.3 GiB)
[   11.036665] sd 0:0:1:0: [sda] Write Protect is off
[   11.043332] sd 0:0:1:0: [sda] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[   11.046665] sd 0:0:3:0: [sdb] Write Protect is off
[   11.053332] sd 0:0:3:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[   11.066665]  sda: sda1 sda2 sda3
[   11.073332]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
[   11.089998] sd 0:0:1:0: [sda] Attached SCSI disk
[   11.093332] sd 0:0:3:0: [sdb] Attached SCSI disk
[   11.106665] EXT3-fs: barriers not enabled
[   11.113332] kjournald starting.  Commit interval 5 seconds
[   11.116665] EXT3-fs (sdb4): mounted filesystem with ordered data mode
[   11.119998] VFS: Mounted root (ext3 filesystem) readonly on device 8:20.
[   11.123332] Freeing unused kernel memory: 108k freed
INIT: version 2.86 booting
[   12.673332] NET: Registered protocol family 1

Gentoo Linux; http://www.gentoo.org/
 Copyright 1999-2007 Gentoo Foundation; Distributed under the GPLv2

 * Mounting proc at /proc ...                                             [=
 ok ]
 * Mounting sysfs at /sys ...                                             [=
 ok ]
 * Mounting /dev for udev ...                                             [=
 ok ]
...
blahblah
...
 * Checking root filesystem ...fsck.ext3: No such file or directory
while trying to open /dev/sdb4
/dev/sdb4:
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

 * Filesystem couldn't be fixed :(
         [ !! ]
Give root password for maintenance
(or type Control-D to continue):


Marcel


On Tue, Mar 8, 2011 at 12:17 PM, Marcel van Nies <morcles@gmail.com> wrote:
> Hi,
>
> 2.6.33.7 with commit 4d14a459857bd151ecbd14bcd37b4628da00792b reverted
> does not segfault.
> I also tried sparc-next-2.6, but I messed up my tree somehow. I will
> try again later.
>
> M
>
> On Tue, Mar 8, 2011 at 8:45 AM, Marcel van Nies <morcles@gmail.com> wrote:
>> Hi,
>>
>>> But first step is to get confirmation that reverting this commit
>>> indeed fixes the bug
>>
>> I'll try that.
>> M
>>
>> On Tue, Mar 8, 2011 at 8:37 AM, Marcel van Nies <morcles@gmail.com> wrot=
e:
>>> Hi,
>>>
>>> It appears that two consecutive commits are causing problems on
>>> hyperSPARC, I noticed that too late.
>>>
>>> Commit 4d14a459857bd151ecbd14bcd37b4628da00792b (the one I reported
>>> earlier) only causes the system to hang, not panic:
>>> [ =A0 11.266665] sd 0:0:1:0: [sda] Attached SCSI disk
>>> [ =A0 11.279998] sd 0:0:3:0: [sdb] Attached SCSI disk
>>> [ =A0 11.299998] kjournald starting. =A0Commit interval 5 seconds
>>> [ =A0 11.303332] EXT3-fs: mounted filesystem with writeback data mode.
>>> [ =A0 11.306665] VFS: Mounted root (ext3 filesystem) readonly on device=
 8:20.
>>> [ =A0 11.309998] Freeing unused kernel memory: 100k freed
>>> <system hangs here - stop-A does go back to prom>
>>>
>>> and
>>> commit c658ad1b4e1520511da8323aa5e60d444cc303ed
>>> Author: David S. Miller <davem@davemloft.net>
>>> Date: =A0 Fri Dec 11 00:44:47 2009 -0800
>>>
>>> =A0 =A0sparc64: Add syscall tracepoint support.
>>>
>>> =A0 =A0Signed-off-by: David S. Miller <davem@davemloft.net>
>>>
>>> actually makes the kernel panic:
>>> [ =A0 11.336665] Freeing unused kernel memory: 100k freed
>>> [ =A0 11.419998] Kernel panic - not syncing: Attempted to kill init!
>>> [ =A0 11.423332] [f002f5b8 : do_group_exit+0x84/0xb4 ]
>>> =A0[f0039490 : get_signal_to_deliver+0x338/0x35c ]
>>> =A0[f00124cc : do_signal+0x30/0x8f0 ]
>>> =A0[f0012da0 : do_notify_resume+0x14/0x38 ]
>>> =A0[f000fca4 : signal_p+0x14/0x24 ]
>>> =A0[f000edfc : srmmu_fault+0x58/0x68 ]
>>> [ =A0 11.466665] Press Stop-A (L1-A) to return to the boot prom
>>>
>>>
>>> Marcel
>>>
>>>
>>> On Tue, Mar 8, 2011 at 8:08 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>>> On Mon, Mar 07, 2011 at 11:01:20PM -0800, David Miller wrote:
>>>>> From: Sam Ravnborg <sam@ravnborg.org>
>>>>> Date: Tue, 8 Mar 2011 07:00:39 +0100
>>>>>
>>>>> > Added davem...
>>>>> > We see strange SEGV faults in userspace and fail to read from ext2..
>>>>> > All on some (but not all) sparc32 boxes.
>>>>>
>>>>> I saw the original report.
>>>>>
>>>>> But reverting this commit is the wrong thing to do from what I can
>>>>> tell.
>>>>>
>>>>> Either we have:
>>>>>
>>>>> 1) A compiler code gen bug.
>>>>>
>>>>> 2) Some piece of code which is sparc32 specific is invoking memset
>>>>> =A0 =A0or memcpy in a way which makes assumptions which are in fact n=
ot
>>>>> =A0 =A0valid
>>>>>
>>>>> 3) The code change is merely making cache offsets change, masking the
>>>>> =A0 =A0true problem
>>>>>
>>>>> Especially in cases #2 and #3 we're just hiding a heisen-bug and
>>>>> not fixing the real problem.
>>>> Agree on this.
>>>> But first step is to get confirmation that reverting this commit
>>>> indeed fixes the bug. Then we can go hunting for 2), 3) or 1).
>>>> I hope we will find that 2) is the culprint.
>>>>
>>>> =A0 =A0 =A0 =A0Sam
>>>>
>>>
>>
>
