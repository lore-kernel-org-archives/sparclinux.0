From: Marcel van Nies <morcles@gmail.com>
Date: Tue, 08 Mar 2011 07:37:36 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <AANLkTikYVcaBq6AM=s+Rt5aU0gkY1RY7eHipPTyNdUS+@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

It appears that two consecutive commits are causing problems on
hyperSPARC, I noticed that too late.

Commit 4d14a459857bd151ecbd14bcd37b4628da00792b (the one I reported
earlier) only causes the system to hang, not panic:
[   11.266665] sd 0:0:1:0: [sda] Attached SCSI disk
[   11.279998] sd 0:0:3:0: [sdb] Attached SCSI disk
[   11.299998] kjournald starting.  Commit interval 5 seconds
[   11.303332] EXT3-fs: mounted filesystem with writeback data mode.
[   11.306665] VFS: Mounted root (ext3 filesystem) readonly on device 8:20.
[   11.309998] Freeing unused kernel memory: 100k freed
<system hangs here - stop-A does go back to prom>

and
commit c658ad1b4e1520511da8323aa5e60d444cc303ed
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Dec 11 00:44:47 2009 -0800

    sparc64: Add syscall tracepoint support.

    Signed-off-by: David S. Miller <davem@davemloft.net>

actually makes the kernel panic:
[   11.336665] Freeing unused kernel memory: 100k freed
[   11.419998] Kernel panic - not syncing: Attempted to kill init!
[   11.423332] [f002f5b8 : do_group_exit+0x84/0xb4 ]
 [f0039490 : get_signal_to_deliver+0x338/0x35c ]
 [f00124cc : do_signal+0x30/0x8f0 ]
 [f0012da0 : do_notify_resume+0x14/0x38 ]
 [f000fca4 : signal_p+0x14/0x24 ]
 [f000edfc : srmmu_fault+0x58/0x68 ]
[   11.466665] Press Stop-A (L1-A) to return to the boot prom


Marcel


On Tue, Mar 8, 2011 at 8:08 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Mon, Mar 07, 2011 at 11:01:20PM -0800, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Tue, 8 Mar 2011 07:00:39 +0100
>>
>> > Added davem...
>> > We see strange SEGV faults in userspace and fail to read from ext2..
>> > All on some (but not all) sparc32 boxes.
>>
>> I saw the original report.
>>
>> But reverting this commit is the wrong thing to do from what I can
>> tell.
>>
>> Either we have:
>>
>> 1) A compiler code gen bug.
>>
>> 2) Some piece of code which is sparc32 specific is invoking memset
>> =A0 =A0or memcpy in a way which makes assumptions which are in fact not
>> =A0 =A0valid
>>
>> 3) The code change is merely making cache offsets change, masking the
>> =A0 =A0true problem
>>
>> Especially in cases #2 and #3 we're just hiding a heisen-bug and
>> not fixing the real problem.
> Agree on this.
> But first step is to get confirmation that reverting this commit
> indeed fixes the bug. Then we can go hunting for 2), 3) or 1).
> I hope we will find that 2) is the culprint.
>
> =A0 =A0 =A0 =A0Sam
>
