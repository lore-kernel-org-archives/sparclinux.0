From: Ben Collins <bcollins@debian.org>
Date: Sat, 05 Jun 2004 14:01:55 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <20040605140155.GA7515@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jun 05, 2004 at 04:13:32PM +0200, Frederik Dannemare wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 05 June 2004 14:57, Ben Collins wrote:
> > FYI, someone reported that adding rootfstype=ext2 made the images
> > bootable. Looks like something in the kernel isn't checking the
> > initrd for ext2. So this may not be a SILO problem (I know Josh is
> > already aware of this, but others are probably interested in the
> > results here).
> 
> I've just tried[1] out the latest netinst image, and even though 
> silo.conf has rootfstype=ext2, I also gave it a test run with 
> rootfstype=ext2 explicitly entered at the silo prompt - but without any 
> luck. 

Ok, so it seems we have a two-fold problem. I suspect the initrd
detection in the kernel is broke (I probably broke it), but we also have
the fs detection broken.

Josh, could you build images with the old silo, this new silo.conf and
make sure the kernels don't have the patch I sent you recently?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
