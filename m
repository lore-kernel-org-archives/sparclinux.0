From: Ben Collins <bcollins@debian.org>
Date: Wed, 02 Jun 2004 20:53:45 +0000
Subject: Re: new debian-installer images for sparc
Message-Id: <20040602205344.GK11678@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040531034458.GF2384@triplehelix.org>
In-Reply-To: <20040531034458.GF2384@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jun 02, 2004 at 05:09:06PM +0200, Frederik Dannemare wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 31 May 2004 05:44, Joshua Kwan wrote:
> > Folks,
> >
> > Here is a mini-ISO image I cooked up with SILO rolled back to 1.3.2.
> > Tom Callaway suggested that I try this because a lot of new stuff
> > related to initrds changed in 1.4.x.
> >
> > http://june.voxel.net/~joshk/mini.iso
> >
> > Tell us what happens! (And wish me luck on finals!)
> 
> Tested on a Sun Ultra 5 (UltraSPARC-IIi 333MHz (sun4u arch)).
> 
> I stops with:
> sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk(1,0)
> Kernel panic: VFS: Unable to mount root fs on 00:00

I'm hoping the kernel patch that was applied from me was removed before
the images were built.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
