From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Apr 2004 19:17:59 +0000
Subject: Re: Can't boot linux on sun blade 2000
Message-Id: <20040407191759.GA1947@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200404071043.30060.snake@penza-gsm.ru>
In-Reply-To: <200404071043.30060.snake@penza-gsm.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 06, 2004 at 11:53:59PM -0700, Joshua Kwan wrote:
> On Wed, Apr 07, 2004 at 10:43:30AM +0400, Alexey Nezhdanov wrote:
> > <TFTP COUNTER (booting 
> > http://www.phunnypharm.org/pub/for/sparc-folks/disks-sparc/current/sparc64/tftpboot.img 
> > image)>
> 
> You should really be using the Sarge tftboot images.
> http://people.debian.org/~jbailey/d-i/sparc/daily/sparc64/netboot/boot.img

No, he shouldn't those images aren't tested very well. My woody images
are.

> > devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> > devfs: boot_options: 0x0
> 
> This is the cause of all your problems.
> 
> > VFS: Mounted root (ext2 filesystem).
> > Warning: unable to open an initial console.
> 
> Pass devfs=mount on the command line and it should Just Work.
> Note that this crude hack isn't required in the latest images.

That shouldn't matter with the image he is using.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
