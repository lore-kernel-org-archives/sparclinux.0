From: Meelis Roos <mroos@linux.ee>
Date: Fri, 24 May 2019 08:20:30 +0000
Subject: Re: More logging (was: vmalloc: Fix issues with flush flag)
Message-Id: <23e053dc-47ff-d113-22f0-5497c7fa8227@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(CC:ing list again)

24.05.19 00:36 Rick Edgecombe kirjutas:
> Hi Meelis,
> 
> I am worried this may be a lot of work to do in case the issue is still somehow with my patch. If you want to rule that out before you do a whole bisect, commit "0a203df5cf0eb709be4f190314e262b72d7e5b76" is the first one one before any of my changes. If that still hangs with:
> CONFIG_DEBUG_PAGEALLOC=y
> CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y

Tried that and 0a203df5cf0eb709be4f190314e262b72d7e5b76 with these DEBUG_PAGEALLOC
flags on hangs. It hangs before reaching itnit, during scsi disk detection, and
the exact moment of hangs varies by a line or too in dmesg.:

This is a typical hang, from the middle of line:

[   24.035174] printk: console [ttyS0] enabled
[   24.095507] f0097810: ttyS1 at MMIO 0x7fff3fffff8 (irq = 21, base_baud = 115387) is a ST16650
[   24.218682] Fusion MPT base driver 3.04.20
[   24.277381] Copyright (c) 1999-2008 LSI Corporation
[   24.347381] Fusion MPT SAS Host driver 3.04.20
[   24.411427] mptbase: ioc0: Initiating bringup
[   25.312352] ioc0: LSISAS1068 B0: Capabilities={Initiator}
[   40.090391] scsi host0: ioc0: LSISAS1068 B0, FwRev080400h, Ports=1, MaxQQ1, IRQ
[   40.219016] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x5000c5000cbc7cf5
[   40.358062] scsi 0:0:0:0: Direct-Access     SEAGATE  ST914602SSUN146G 0703 PQ: 0 ANSI: 5
[   40.478173] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id 4, phy 4, sas_addr 0x500000e0118969b2
[   40.617183] scsi 0:0:1:0: Direct-Access     FUJITSU  MAV2073RCSUN72G  0301 PQ: 0 ANSI: 4
[   40.733521] sd 0:0:0:0: [sda] 286739329 512-byte logical blocks: (147 GB/137 GiB)
[   40.736867] Fusion MPT misc device (ioctl) driver 3.04.20
[   40.842180] sd 0:0:0:0: [sda] Write Protect is off
[   40.918551] m

> Then I think it would be conclusive that the the problem is earlier and another bisect would probably be needed. I probably should have asked you to just go ahead and do that last time, but thought it would be easier to communicate properly and since you were already testing the patch that fixed it. Hopefully this is not putting you out too much.

I do not remember trying DEBUG_PAGEALLOC before on any sparcs (though I have had a
problem with thet on some strange old machine that might or might not have been a sparc).

To actually bisect it requires a known good kernel DEBUG_PAGEALLOC it worked.
Will try to find one - hopefully it is not in too distant past.

So the conclusion is that your patch just triggers a bug that is there even before
and DEBUG_PAGEALLOC hits the same bug? Myabe just DEBUG_PAGEALLOC is broken before, so
thet would make two independent bugs - how do we know it's the same bug?

-- 
Meelis Roos <mroos@linux.ee>
