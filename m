From: Peter Karbaliotis <peter.karbaliotis@ualberta.ca>
Date: Mon, 17 May 2004 16:35:37 +0000
Subject: Re: initrd testing
Message-Id: <40A8E9D9.5030008@ualberta.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sun Ultra 1 (uniprocessor UltraSPARC):
Loading initital ramdisk (1477740 bytes at 0x20800000 phys 0x40c00000 virt)

Sun Ultra Enterprise 2 (dual processor UltraSPARC):
Loading initital ramdisk (1477740 bytes at 0x60800000 phys 0x40c00000 virt)

Panics with the same message as before:

> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> Freeing initrd memory: 1442 freed
> cramfs: wrong magic
> sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
> Kernel panic: VFS: Unable to mount root fs on 00:00
> Press L1-A to return to the boot prom

-- 
Peter.Karbaliotis@ualberta.ca	780-492-7660
Computing and Network Services	University of Alberta
