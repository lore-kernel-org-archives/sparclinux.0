From: Andy Dougherty <doughera@lafayette.edu>
Date: Fri, 14 May 2004 16:45:34 +0000
Subject: Re: initrd testing
Message-Id: <Pine.SOL.4.58.0405141236140.10880@maxwell.phys.lafayette.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 13 May 2004, Joshua Kwan wrote:

> [ Sorry for the huge crosspost, but this is a pretty big deal. ]
>
> On Thu, May 13, 2004 at 04:21:46PM -0400, Ben Collins wrote:
> > Some people have reported problems with initrd on sparc64. I'm trying to
> > trace that problem (hard, because I can't reproduce it). If you've had
> > the problem where silo reports loading the initrd into memory, but the
> > kernel fails to detect and use it, please try the second.b in the url
> > below, and recompile a kernel using one of the two patches there aswell
> > (2.4 and 2.6).
> >
> > The new second.b will show the phys address that the initrd was loaded
> > to, in addition to the virtual address.
>
> I've built debian-installer images for sparc based on kernels with this
> patch (for 2.4) and the new second.b.
>
> You probably want the CDROM image since it's the one most commonly
> reported as not being able to boot. (cdrom-mini.iso) I am personally not
> able to try these out until I receive a sparc64 machine, which should
> happen sometime in the near future.
>
> http://june.voxel.net/~joshk/d-i/images/2004-05-14/

I tried http://june.voxel.net/~joshk/d-i/images/2004-05-14/drom-mini.iso
on two machines, an Ultra1 and an Ultra10; both failed, though
differently.

Ultra1:  On this one, I got (modulo any typos)

    Loading initial ramdisk (1477684 bytes at 0x01x phys 022340800 virt) ...
    [spinning \/]
    Remapping the kernel ...  FP Disabled
    ok

and I was back to the OpenBoot 'ok' prompt.

Ultra10:  On this one, I got much further.  The kernel was loading,
but failed near the end.  The last messages were

    RAMDISK: couldn't find valid ramdisk image starting at 0.
    Freeing initrd memory 1443k freed
    cramfs: wrong magic
    sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
    Kernel panic: VFS: Unable to mount root fs on 00:00

I hope this means something to somebody.

-- 
    Andy Dougherty		doughera@lafayette.edu
