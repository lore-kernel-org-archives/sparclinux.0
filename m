From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 05 Mar 2011 16:29:03 +0000
Subject: Re: Sun4d scsi<->fs issues [Was: Status update on sparc32 genirq
Message-Id: <20110305162903.GB14644@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1103051535390.27582@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1103051535390.27582@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> The exact problem manifest with a successful mount of the filesystem. 
> But it is not possible to read or list any files on the ext2 parition.
> 
> # mount /dev/sda2 /mnt
> EXT2-fs (sda2): warning: mounting ext3 filesystem as ext2
> # cd /mnt
> # ls
> EXT2-fs (sda2): error: ext2_check_page: bad entry in directory #2: : 
> rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
> #
> 
> I have dumped out the memory area ext2_check_page is reading and it 
> contains only zero-data. Hence, the error message. 

I have not yet used disk access during my sparc32 testing.
My userland is all on a RAMDISK as I have so far concentrated
on the kernel side. And here booting is success criteria #1.

So I just want to say that you may have hit something more generalm
and not necessarily sun4d specific.

I have Solaris on the disk on my sun4m box - which I hesitate
to format.
And I do not yet have a spare disk to play with. So I cannot
do testing with ext2 right away.

	Sam
