From: Ben Collins <bcollins@debian.org>
Date: Sun, 20 Jun 2004 19:25:49 +0000
Subject: Re: New SILO (was Re: [SOLVED] Take 3: sparc64 CDs work?)
Message-Id: <20040620192549.GC19634@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040620170821.GA19634@phunnypharm.org>
In-Reply-To: <20040620170821.GA19634@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jun 20, 2004 at 12:41:25PM -0700, David S. Miller wrote:
> On Sun, 20 Jun 2004 13:08:22 -0400
> Ben Collins <bcollins@debian.org> wrote:
> 
> > I suspect that in the long run, I really need to make it so that the
> > initrd gets lower memory precendence over the kernel. The kernel itself
> > can be loaded anywhere for sparc64, even in 64-bit address ranges.
> > 
> > But for now, I am about to release SILO 1.4.6 to atleast make this less
> > of a mystery on systems where it fails.
> 
> I have a better idea, remove the 32-bit limitation.
> 
> Create a new HdrS version, add a new member at the end of the bootloader
> header area "sparc_ramdisk_image64", set it to ~0 by default, if the
> bootloader sets it to some non-~0 value, we use it instead of the
> 32-bit limited sparc_ramdisk_image value.

The downside is that I need to load and evaluate the kernel before
loading the initrd in order for it to work. I was already considering
this, but I need to make sure I don't get into a chicken and egg
situation like I did with the feature to load the kernel to a non-zero
location.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
