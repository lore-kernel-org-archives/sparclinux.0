From: bertrand <joel.bertrand@systella.fr>
Date: Tue, 22 Mar 2011 11:42:49 +0000
Subject: Re: Issuing Reset from =?UTF-8?Q?mpt=5Fconfig!!?=
Message-Id: <6ce274895f6085a7705ab2afd08c830b@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 On Sat, 19 Mar 2011 23:27:23 +0100, BERTRAND Joel wrote:
> Hello,

 Some news.

 I have checked last night this Fire T1000 doesn't have hardware issue. 
 Both Fire T1000 have same installed hardware and firmware level (1.00 
 for LSI adapter and 6.7.6 for LDOM). The first one runs fine with 2.6.38 
 and the second refuses to boot. With 2.6.30.9 kernel, it boots without 
 any trouble. SunVTS doesn't return failure.

 I have checked if this T1000 boots with only one disk, with only the 
 other one and I always see 'Issuing Reset' message. I have swapped disks 
 between both T1000 and I see the same message on the same T1000. Thus 
 this message comes from adapter, not from disks.

> I have upgraded this saturday two Fire T1000 from 2.6.30.9 to 2.6.38
> linux kernel to have better performances with ietd. I don't see any
> hardware differences between both servers (same firmware) but one of
> them doesn't boot 2.6.38 kernel:
>
> ...
> Fusion MPT base driver 3.04.18
> Copyright (c) 1999-2008 LSI Corporation
> Fusion MPT SAS Host driver 3.04.18
> mptbase: ioc0: Initiating bringup
> ioc0: LSISAS1064 A3: Capabilities={Initiator}
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x1, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x1, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Attempting Retry Config request type 0x0, page 0x2, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: Attempting Retry Config request type 0x0, page 0x2, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Attempting Retry Config request type 0x9, page 0x0, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: Attempting Retry Config request type 0x9, page 0x0, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> scsi0 : ioc0: LSISAS1064 A3, FwRev0a0000h, Ports=1, MaxQQ1, 
> IRQ'
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Attempting Retry Config request type 0x10, page 0x0, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x2c000000
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> mptbase: ioc0: Attempting Retry Config request type 0x10, page 0x0, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x2c000000
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x24000000
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x2c000001
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> mptbase: ioc0: Attempting Retry Config request type 0x11, page 0x0, 
> action 0
> ...
> mptbase: ioc0: Initiating recovery
> mptbase: ioc0: WARNING - Issuing Reset from mpt_config!!, 
> doorbell=0x2c000000
> mptbase: ioc0: Attempting Retry Config request type 0x1, page 0x2, 
> action 0
> Fusion MPT misc device (ioctl) driver 3.04.18
> mptctl: Registered with Fusion MPT base driver
> mptctl: /dev/mptctl @ (major,minor,220)
> mousedev: PS/2 mouse device common for all mice
> rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
> md: raid1 personality registered for level 1
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> NET: Registered protocol family 17
> Registering the dns_resolver key type
> rtc-sun4v rtc-sun4v: setting system clock to 2011-03-19 22:17:18 UTC
> (1300573038)
> md: Skipping autodetection of RAID arrays. (raid=autodetect will 
> force)
> md: Unknown device name: sda4
> VFS: Cannot open root device "md0" or unknown-block(0,0)
> Please append a correct "root=" boot option; here are the available
> partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
> Call Trace:
>  [00000000008aae24] mount_block_root+0x29c/0x2b8
>  [00000000008ab02c] prepare_namespace+0x184/0x1c8
>  [00000000008aa390] kernel_init+0x204/0x21c
>  [000000000042b00c] kernel_thread+0x30/0x48
>  [000000000074d35c] rest_init+0x18/0x7c
> Press Stop-A (L1-A) to return to the boot prom
>
> If I try to reboot with 2.6.30.9 kernel, the same server boots fine
> (but hangs later due to another soft raid trouble) wihtout any 
> trouble
> during MPT initialization. I have built kernel in the first T1000 and
> copied this kernel on the second one.
>
> Both servers boot Solaris without trouble.
>
> I have found some informations about this trouble but no one is sparc
> specific and I have no idea to fix it. Any idea ?

 Best regards,

 JKB
