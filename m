From: Patrick Finnegan <pat@computer-refuge.org>
Date: Tue, 01 Dec 2009 04:04:31 +0000
Subject: Re: Boot problems on a V880
Message-Id: <200911302304.31560.pat@computer-refuge.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 30 November 2009, David Miller wrote:
> From: Patrick Finnegan <pat@computer-refuge.org>
> Date: Mon, 30 Nov 2009 16:02:14 -0500
> 
> > It doesn't seem that the RSC is the problem, but I have two bad
> > slots on the CPU backplane (as verified by booting this on my other
> > V880).  That V880 is installed with "2.6.26-1-sparc64" from
> > Debian/Lenny, which booted ok on this one when I cloned the disk
> > (and pulled the CPU modules from the bottom two slots).  It looks
> > like this 2.6.32-rc3 will boot, but I can't get the onboard
> > (sungem) ethernet to work (on either 2.6.26-1-sparc64 or
> > 2.6.32-rc3).
> 
> What are the symptoms, link simply doesn't come up?
> 
> We made some fixes to link type detection in sungem recently, maybe
>  we need some more touchups to get it perfect.
> 
> Can you please post the output of "prtconf -pv" either from Linux or
> Solaris on this machine?
> 
> Thanks.

It looks like it's not detecting the PHY on the fiber port properly:

from dmesg:

[   56.085593] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[   56.162739] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 
00:03:ba:2f:1f:17
[   56.246201] PHY ID: 18074c1, addr: 0
[   56.247315] eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 
00:03:ba:2f:1f:16
[   56.329681] eth1: Found Generic MII PHY

and running ethtool on the ports:

Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 10Mb/s
        Duplex: Half
        Port: MII
        PHYAD: 0
        Transceiver: external
        Auto-negotiation: on
        Supports Wake-on: d
        Wake-on: d
        Current message level: 0x00000007 (7)
        Link detected: no
v880:~# ethtool eth1
Settings for eth1:
        Supported ports: [ ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
        Advertised auto-negotiation: Yes
        Speed: Unknown! (0)
        Duplex: Half
        Port: Twisted Pair
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Supports Wake-on: d
        Wake-on: d
        Current message level: 0x00000007 (7)
        Link detected: no

I re-ran prtconf -pv under the 2.6.32-rc3 from your sparc git tree, and 
have the output here (it looks like it has what you're looking for):

http://ned.cc.purdue.edu/prtconf-v880

Pat
-- 
Purdue University Research Computing ---  http://www.rcac.purdue.edu/
The Computer Refuge                  ---  http://computer-refuge.org
