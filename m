From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 17 Nov 2008 11:15:14 +0000
Subject: Sun GEM (PCI) 10/100/1000 Fibre SX receiver not recognized
Message-Id: <20081117111514.GB9175@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello all,

a 1000SX Receiver seem to be not correctly treated by the sungem driver.
In a sparc V880 (with buildin 100BaseT and 1000SX) I get only a message 
about finding the 100 Mbit copper interface transceiver in the kernel log 
and in a 480R where I put an GEM pci-card with 1000SX transceiver
the link disappears on the other end when I do an ifconfig up.

Kernel log (debian 2.6.24-etchnhalf.1-sparc64-smp, vanilla 2.6.27.6 did
not boot), "ethtool" and "lspci -vnn" is appended.

The sungem is located in the 10/100Mbit config section and from searching
the web it's not clear to me if the 1000SX transceiver is supposed to work.

Thanks for any help,
  Hermann

----------------------------------------------------------------
480R:

#dmesg
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PCI: Enabling device: (0001:00:02.0), cmd 146
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:0c:95:3e
(udev seems to change numbering beetween)
...
eth12: Link is up at 1000 Mbps, full-duplex.
eth12: Link is up at 1000 Mbps, full-duplex.
eth12: Link is up at 1000 Mbps, full-duplex.
eth12: Link is up at 1000 Mbps, full-duplex.
...
eth12: Link is up at 1000 Mbps, half-duplex.
eth12: Pause is disabled
eth12: no IPv6 routers present

# ethtool eth12
Settings for eth12:
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
        Link detected: yes

# lspci -vnn
0001:00:02.0 Ethernet controller [0200]: Sun Microsystems Computer Corp. GEM [108e:2bad] (rev 01)
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 12
        Memory at 00200000 (32-bit, non-prefetchable) [size=2M]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        Expansion ROM at 00400000 [disabled] [size=1M]
---------------------------------------------------------------
V880:

# dmesg
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 18074c1, addr: 0
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:08:d9:24
eth0: Found Generic MII PHY
eth1: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:08:d9:25
eth0: Link is up at 100 Mbps, full-duplex.

# ethtool eth1
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

# lspci -vnn
0002:00:01.1 Ethernet controller [0200]: Sun Microsystems Computer Corp. RIO GEM [108e:1101] (rev 01)
        Flags: bus master, medium devsel, latency 64, IRQ 22
        BIST result: 00
        Memory at 00100000 (32-bit, non-prefetchable) [size8K]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        Expansion ROM at 00400000 [disabled] [size=4M]

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
