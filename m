From: Patrick Finnegan <pat@computer-refuge.org>
Date: Wed, 09 Jun 2004 16:09:50 +0000
Subject: Re: Take 3: sparc64 CDs work?
Message-Id: <200406091109.50841.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040605001932.GA22926@darjeeling.triplehelix.org>
In-Reply-To: <20040605001932.GA22926@darjeeling.triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 09 June 2004 08:50, Frederik Dannemare wrote:
> Activating swap-devices in /etc/fstab...
> failed
> Checking file systems...
> fsck 1.24a (02-Sep-2001)
> fsck.ext2: No such file or directory while trying to open /dev/hda1
> (null):

Try booting with devfs=nomount.  This issue looks like the kernel is 
mounting devfs, but there's no devfs daemon to make the "normal 
looking" device symlinks.

Looking back through the logs, I see this:

> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x1

and this:

> Partition check:
> /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4

which means you've got devfs compiled in (and probably being mounted) 
but no indicator that devfsd is starting.

Pat
-- 
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
