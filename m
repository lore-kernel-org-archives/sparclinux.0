From: Ben Collins <bcollins@debian.org>
Date: Fri, 14 May 2004 16:34:29 +0000
Subject: Re: initrd testing
Message-Id: <20040514163429.GJ1098@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ultra1:  On this one, I got (modulo any typos)
> 
>     Loading initial ramdisk (1477684 bytes at 0x01x phys 022340800 virt) ...
>     [spinning \/]
>     Remapping the kernel ...  FP Disabled
>     ok
> 
> and I was back to the OpenBoot 'ok' prompt.

This is strange.

> Ultra10:  On this one, I got much further.  The kernel was loading,
> but failed near the end.  The last messages were
> 
>     RAMDISK: couldn't find valid ramdisk image starting at 0.
>     Freeing initrd memory 1443k freed
>     cramfs: wrong magic
>     sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
>     Kernel panic: VFS: Unable to mount root fs on 00:00
> 
> I hope this means something to somebody.

This means something. Atleast we are showing a ramdisk, but the start
point is all wrong. Did the old cd images work for you?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
