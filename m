From: Peter Karbaliotis <peter.karbaliotis@ualberta.ca>
Date: Fri, 14 May 2004 21:03:03 +0000
Subject: Re: initrd testing
Message-Id: <40A53407.40101@ualberta.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Joshua Kwan wrote:
> On Fri, May 14, 2004 at 01:56:25PM -0600, Peter Karbaliotis wrote:
> 
>>I also saw this on a Sun Ultra 2.
>>
>>Sun Ultra 2 UPA/Sbus (2 x UltraSPARC 200 MHz)
>>...
>>loaded kernel version 2.4.26
>>Loading initial ramdisk ( 1477684 bytes at 0x01x phys, 0x60800000 virt)
>>...
>>RAMDISK: Couldn't find valid RAM disk image starting at 0
>>Freeing initrd memory: 1443k freed
>>cramfs: wrong magic
>>sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
>>kernel panic: VFS: Unable to mount root fs on 00:00
>>  Press L1-A to return to the boot prom
>>
>>
>>The 20040511 daily image boots up fine on this system.
> 
> 
> Erk. That's a _regression_! Not good... Ben, did your patch interfere
> with anything that would have made this not work? Also, this is CDROM,
> right? Also, did you use a netinst/businesscard image, the
> cdrom-mini.iso, or what?
> 
> I tried a boot floppy on my sparc32 box. It seemed to boot OK, but
> possibly because SILO is not responible for the initrd for floppy
> installs.
> 

cdrom-mini.iso from your daily build.

-- 
Peter.Karbaliotis@ualberta.ca	780-492-7660
Computing and Network Services	University of Alberta
