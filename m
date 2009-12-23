From: Aaron Scheiner <blue@aquarat.za.net>
Date: Wed, 23 Dec 2009 17:53:49 +0000
Subject: Re: Sun fire V890 UltraSparc server kernel panic, offertoassist
Message-Id: <1261590829.2765.17.camel@mail.aquarat.za.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091122220621.GA16620@orion.carnet.hr>
In-Reply-To: <20091122220621.GA16620@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I just thought I'd let you know that OpenBSD's guys have managed to get
OpenBSD running on this machine.

Aaron

On Thu, 2009-11-26 at 10:26 +0200, Aaron Scheiner wrote:
> Booting both Ubuntu 9.10 and 8.10 results in this error :
> "
> boot: 
> Allocated 64 Megs of memory at 0x40000000 for kernel
> Loaded kernel version 2.6.25
> Loading initial ramdisk (6178206 bytes at 0xA1FF000000 phys, 0x40C00000
> virt)...
> ERROR: Last Trap: Fast Data Access MMU Miss
> 
> {2} ok 
> "
> 
> Interestingly, the machine returns to the boot prom instead of just
> dying altogether.
> 
> Hope that helps :)
> 
> 
> Aaron
> 
> On Tue, 2009-11-24 at 00:10 +0100, Josip Rodin wrote:
> > On Mon, Nov 23, 2009 at 11:56:23PM +0100, Josip Rodin wrote:
> > > On Tue, Nov 24, 2009 at 12:52:21AM +0200, Aaron Scheiner wrote:
> > > > My home network has DHCP server on it (Smoothwall) and two other
> > > > machines running Ubuntu. One of the Ubuntu machines has been configured
> > > > as a TFTP server (used it to hack a Mikrotik router a while back). In
> > > > other words, I should(?) have the environment to boot this Sun machine
> > > > via the network.
> > > > 
> > > > As for the kernel, I found a guide today that should put me on the right
> > > > track : http://wiki.debian.org/DebianInstaller/Modify/CustomKernel .
> > > > 
> > > > I'll work on it a little later today :) .
> > > 
> > > While we're at it, you mentioned earlier that you tried Ubuntu Dapper (6.06)
> > > with 2.6.15 which also failed miserably - Ubuntu shipped a few more sparc
> > > releases other than that one, so you may get lucky with another one. A quick
> > > Google tells me that their 7.04 and 7.10 releases still had sparc, so try
> > > and find installer images from those.
> > 
> > Oddly enough, once I actually figured out the right place to look on the
> > web site, I could also easily find newer ones:
> > http://cdimage.ubuntu.com/ports/releases/hardy/release/ubuntu-8.04.1-server-sparc.iso
> > http://cdimage.ubuntu.com/ports/releases/intrepid/release/ubuntu-8.10-server-sparc.iso
> > http://cdimage.ubuntu.com/ports/releases/jaunty/release/ubuntu-9.04-server-sparc.iso
> > http://cdimage.ubuntu.com/ports/releases/karmic/release/ubuntu-9.10-server-sparc.iso
> > 
> 
> 
> 


