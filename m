From: Patrick Morris <trick@adonis.net>
Date: Mon, 17 May 2004 14:50:44 +0000
Subject: Re: initrd testing
Message-Id: <40A8D144.80502@adonis.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

boot:
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.4.26
Loading initial ramdisk (1477459 bytes at 0x10C00000 phys, 0x40C00000 
virt)...
Remapping the kernel... Done
Booting Linux

Ben Collins wrote:

>On Sun, May 16, 2004 at 11:21:01PM -0700, Patrick Morris wrote:
>  
>
>>For what it's worth, I get the same thing reported earlier when trying 
>>this image on my Ultra 5:
>>
>>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>>RAMDISK: Couldn't find valid RAM disk image starting at 0.
>>Freeing initrd memory: 1442 freed
>>cramfs: wrong magic
>>sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
>>Kernel panic: VFS: Unable to mount root fs on 00:00
>>Press L1-A to return to the boot prom
>>    
>>
>
>I need the line that silo prints out about where it is locating the
>initrd in memory.
>
>  
>


