From: Patrick Morris <trick@adonis.net>
Date: Mon, 17 May 2004 06:21:01 +0000
Subject: Re: initrd testing
Message-Id: <40A859CD.8030401@adonis.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For what it's worth, I get the same thing reported earlier when trying 
this image on my Ultra 5:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 1442 freed
cramfs: wrong magic
sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
Kernel panic: VFS: Unable to mount root fs on 00:00
 Press L1-A to return to the boot prom

Joshua Kwan wrote:

>Updated images with this second.b are at
>
>http://june.voxel.net/~joshk/d-i/images/2004-05-15
>
>Remember, the images from gluck.debian.org don't contain a patched
>kernel or second.b.
>
>  
>


