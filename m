From: Ben Collins <bcollins@debian.org>
Date: Mon, 17 May 2004 12:39:16 +0000
Subject: Re: initrd testing
Message-Id: <20040517123916.GF1286@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, May 16, 2004 at 11:21:01PM -0700, Patrick Morris wrote:
> For what it's worth, I get the same thing reported earlier when trying 
> this image on my Ultra 5:
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> Freeing initrd memory: 1442 freed
> cramfs: wrong magic
> sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
> Kernel panic: VFS: Unable to mount root fs on 00:00
> Press L1-A to return to the boot prom

I need the line that silo prints out about where it is locating the
initrd in memory.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
