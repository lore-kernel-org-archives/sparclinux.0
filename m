From: Andy Dougherty <doughera@lafayette.edu>
Date: Fri, 14 May 2004 17:07:14 +0000
Subject: Re: initrd testing
Message-Id: <Pine.SOL.4.58.0405141301430.11029@maxwell.phys.lafayette.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 14 May 2004, Ben Collins wrote:

AD> Ultra10:  On this one, I got much further.  The kernel was loading,
AD> but failed near the end.  The last messages were
AD>
AD>     RAMDISK: couldn't find valid ramdisk image starting at 0.
AD>     Freeing initrd memory 1443k freed
AD>     cramfs: wrong magic
AD>     sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
AD>     Kernel panic: VFS: Unable to mount root fs on 00:00

> This means something. Atleast we are showing a ramdisk, but the start
> point is all wrong. Did the old cd images work for you?

I'm afraid I haven't been keeping up.  The last CD boot I did was the
woody install.  I can try (a small number) of other images, if you
have any specific suggestions.

-- 
    Andy Dougherty		doughera@lafayette.edu
