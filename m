From: Peter Karbaliotis <peter.karbaliotis@ualberta.ca>
Date: Fri, 14 May 2004 19:56:25 +0000
Subject: Re: initrd testing
Message-Id: <40A52469.10601@ualberta.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ben Collins wrote:
>>Ultra1:  On this one, I got (modulo any typos)
>>
>>    Loading initial ramdisk (1477684 bytes at 0x01x phys 022340800 virt) ...
>>    [spinning \/]
>>    Remapping the kernel ...  FP Disabled
>>    ok
>>
>>and I was back to the OpenBoot 'ok' prompt.
> 
> 
> This is strange.
> 
> 
>>Ultra10:  On this one, I got much further.  The kernel was loading,
>>but failed near the end.  The last messages were
>>
>>    RAMDISK: couldn't find valid ramdisk image starting at 0.
>>    Freeing initrd memory 1443k freed
>>    cramfs: wrong magic
>>    sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
>>    Kernel panic: VFS: Unable to mount root fs on 00:00
>>
>>I hope this means something to somebody.
> 
> 
> This means something. Atleast we are showing a ramdisk, but the start
> point is all wrong. Did the old cd images work for you?
> 

I also saw this on a Sun Ultra 2.

Sun Ultra 2 UPA/Sbus (2 x UltraSPARC 200 MHz)
...
loaded kernel version 2.4.26
Loading initial ramdisk ( 1477684 bytes at 0x01x phys, 0x60800000 virt)
...
RAMDISK: Couldn't find valid RAM disk image starting at 0
Freeing initrd memory: 1443k freed
cramfs: wrong magic
sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
kernel panic: VFS: Unable to mount root fs on 00:00
   Press L1-A to return to the boot prom


The 20040511 daily image boots up fine on this system.

-- 
Peter.Karbaliotis@ualberta.ca	780-492-7660
Computing and Network Services	University of Alberta
