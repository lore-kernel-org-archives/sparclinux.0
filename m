From: Aaron Scheiner <blue@aquarat.za.net>
Date: Mon, 23 Nov 2009 22:52:21 +0000
Subject: Re: Sun fire V890 UltraSparc server kernel panic, offertoassist
Message-Id: <1259016741.7731.8.camel@mail.aquarat.za.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091122220621.GA16620@orion.carnet.hr>
In-Reply-To: <20091122220621.GA16620@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hey Joy

The machine is currently connected to my home LAN. I powered it up from
a remote location today via SSH -> Telnet (RSC) and executed some
commands on the Solaris installation... I think that's pretty cool :P . 

My home network has DHCP server on it (Smoothwall) and two other
machines running Ubuntu. One of the Ubuntu machines has been configured
as a TFTP server (used it to hack a Mikrotik router a while back). In
other words, I should(?) have the environment to boot this Sun machine
via the network.

As for the kernel, I found a guide today that should put me on the right
track : http://wiki.debian.org/DebianInstaller/Modify/CustomKernel .

I'll work on it a little later today :) .

On Mon, 2009-11-23 at 23:34 +0100, Josip Rodin wrote:
> On Mon, Nov 23, 2009 at 11:16:59AM +0200, Aaron Scheiner wrote:
> > I don't know who's going to do this, but if it's me does anyone have a
> > guide lying around ? :P
> > 
> > ...or some useful links.
> 
> Yeah, the problem is, if you had just a single working Linux version on the
> machine, you could try these things on your own; but since you don't, you're
> depending on either cross-compiling or someone else compiling the kernel,
> *AND* building it into a bootable image.
> 
> Maybe if you could plug the machine into a network with another machine
> which could serve the boot image over PXE or something...
> 


