From: Ben Collins <bcollins@debian.org>
Date: Tue, 24 Feb 2004 14:42:45 +0000
Subject: Re: Linux 2.6.3 still doesn't boot on UltraSparc I
Message-Id: <20040224144245.GA468@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > > > Try this, keep the new head.S and newer SILO, and edit head.S so that
> > > > "HdrS version" is 0x202 instead of 0x300. See if that boots for you
> > > > (would confirm my suspicion).
> > > 
> > > It boots correctly this way. What can we do to help now ?
> > 
> > Can you enable CONFIG_DEBUG_BOOTMEM and boot with "linux -p"?
> 
> Here is the output :
> 
> boot: linux -p
> Allocated 8 Megs of memory at 0x4000000 for kernel
> Kernel doesn't support loading to high memory, relocating done.
> Loaded kernel version 2.6.3
> 
> PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
> Linux version 2.6.3 (root@ensilinx8) (gcc version 3.3.3 20040125 (prerelease) (Debian)) #4 SMP [...]
> ARCH: SUN4U
> PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
> PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
> PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
> PROMLIB: Sun IEEE Boot Prom 3.2.4 1996/05/30 11:17
> [...]
> Looping, had to stop it using Break+A.
> 
> The same kernel boots without -p.

Oooh...that's interesting. It looks like it actually gets all the way
through head.S. The PROMLIB line is from the call to prom_init() in
head.S just before it finally calls start_kernel(), and the the "ARCH:
SUN4U" is in setup_arch(), which is well after head.S has jumped to the
main kernel.

Why it's looping with prom_init(), I'm not sure. Maybe the prom cif
handler and stack aren't getting setup properly. Dave, any ideas?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
