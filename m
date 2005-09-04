From: Jason Wever <weeve@gentoo.org>
Date: Sun, 04 Sep 2005 21:30:24 +0000
Subject: PCI device issues between Blade 100 and Blade 100
Message-Id: <20050904153024.630204cb@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart_Sun__4_Sep_2005_15_30_24_-0600_es+DuEq7=WfViKod"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--Multipart_Sun__4_Sep_2005_15_30_24_-0600_es+DuEq7=WfViKod
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I've been noticing some differences using PCI devices in 2.6 kernels
between a Blade 100 and Blade 1000.

On a Blade 100, I've gotten a PCI USB2 controller (NEC chipset) to work
using the ehci driver with no problems as well as a PCI cs46xx sound
card (Hercules GameTheater XP).  However, when I try to use the same
cards in the Blade 1000, the drivers appear to have issues getting IRQs
when the drivers load.  Below is sample output from the 2.6.13 kernel of
what happens when the drivers attempt to load;

USB controller;
ehci_hcd 0001:00:01.2: NEC Corporation USB 2.0
ehci_hcd 0001:00:01.2: reset hcs_params 0x2385 dbg=0 cc=2 pcc=3 !ppc
ports=5 ehci_hcd 0001:00:01.2: reset portroute 1 0 1 0 0 
ehci_hcd 0001:00:01.2: reset hcc_params 0002 thresh 0 uframes
256/512/1024 ehci_hcd 0001:00:01.2: new USB bus registered, assigned bus
number 1 ehci_hcd 0001:00:01.2: request interrupt 10,20e failed
ehci_hcd 0001:00:01.2: USB bus 1 deregistered
ehci_hcd 0001:00:01.2: init 0001:00:01.2 fail, -16
ehci_hcd: probe of 0001:00:01.2 failed with error -16
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI) ohci_hcd: block sizes: ed 80 td 96
ohci_hcd 0001:00:01.0: NEC Corporation USB
ohci_hcd 0001:00:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:00:01.0: request interrupt 10,20c failed
ohci_hcd 0001:00:01.0: USB bus 1 deregistered
ohci_hcd 0001:00:01.0: init 0001:00:01.0 fail, -16
ohci_hcd: probe of 0001:00:01.0 failed with error -16
ohci_hcd 0001:00:01.1: NEC Corporation USB (#2)
ohci_hcd 0001:00:01.1: new USB bus registered, assigned bus number 1
ohci_hcd 0001:00:01.1: request interrupt 10,20d failed
ohci_hcd 0001:00:01.1: USB bus 1 deregistered
ohci_hcd 0001:00:01.1: init 0001:00:01.1 fail, -16
ohci_hcd: probe of 0001:00:01.1 failed with error -16


Sound controller;
unable to grab IRQ 8752768
Sound Fusion CS46xx: probe of 0001:00:02.0 failed with error -16


At first I was thinking that maybe there was an issue with the PCI bus
on the Blade 1000, but I have a r8169 chipset based Gigabit Ethernet
card in there and that works just fine.  The IRQ it shows its using when
the driver loads seems a bit high, but doesn't seem to affect
performance.  Kernel output from the driver loading for that is;

r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0x7fe00134000, 00:c0:49:fa:1d:71, IRQ 8752896


I've also tried rotating the location of the PCI cards around a bit
based on the 33MHz and 66MHz PCI slots, but no noticeable difference in
behaviors.

For reference, I've included the lspci output from the Sun Blade 100 and
Sun Blade 1000.

Sun Blade 100;

0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Ultra IIe
0000:00:03.0 Non-VGA unclassified device: ALi Corporation M7101 Power
Management Controller [PMU]
0000:00:05.0 PCI bridge: Digital Equipment Corporation DECchip 21152
(rev 03)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge
[Aladdin IV]
0000:00:08.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)
0000:00:0c.0 Bridge: Sun Microsystems Computer Corp. RIO EBUS (rev 01)
0000:00:0c.1 Ethernet controller: Sun Microsystems Computer Corp. RIO
GEM (rev 01)
0000:00:0c.2 FireWire (IEEE 1394): Sun Microsystems Computer Corp. RIO
1394 (rev 01)
0000:00:0c.3 USB Controller: Sun Microsystems Computer Corp. RIO USB
(rev 01)
0000:00:0d.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
0000:00:13.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:01:00.0 USB Controller: NEC Corporation USB (rev 43)
0000:01:00.1 USB Controller: NEC Corporation USB (rev 43)
0000:01:00.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
0000:01:01.0 Multimedia audio controller: Aureal Semiconductor Vortex 2
(rev fe)
0000:01:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 26)


Sun Blade 1000;

0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Schizo PCI Bus
Module
0000:00:01.0 VGA compatible controller: ATI Technologies Inc Radeon
RV100 QY [Radeon 7000/VE]
0000:00:04.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre
Channel Adapter (rev 05)
0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Schizo PCI Bus
Module
0001:00:01.0 USB Controller: NEC Corporation USB (rev 41)
0001:00:01.1 USB Controller: NEC Corporation USB (rev 41)
0001:00:01.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
0001:00:02.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
0001:00:03.0 Ethernet controller: U.S. Robotics USR997902 10/100/1000
Mbps PCI Network Card (rev 10)
0001:00:05.0 Bridge: Sun Microsystems Computer Corp. RIO EBUS (rev 01)
0001:00:05.1 Ethernet controller: Sun Microsystems Computer Corp. RIO
GEM (rev 01)
0001:00:05.2 FireWire (IEEE 1394): Sun Microsystems Computer Corp. RIO
1394 (rev 01)
0001:00:05.3 USB Controller: Sun Microsystems Computer Corp. RIO USB
(rev 01)
0001:00:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 37)
0001:00:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 37)


If anyone has any ideas or suggestions or would like any more
information, please let me know.

Cheers,
-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Multipart_Sun__4_Sep_2005_15_30_24_-0600_es+DuEq7=WfViKod
Content-Type: application/pgp-signature; name=
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4xIChHTlUv
TGludXgpCgppRDhEQlFGQ3NpYVNkS3ZnZFZpb3EyOFJBdEgyQUtDY3BSSUlWK0lVamFScDcrR3pa
Rmg3VWRiSXBnQ2ZXako4Ck9rZFM4Q1FBUi9oNHZ0UVNRc2I0UWZVPQo9ZmxSOQotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0K

--Multipart_Sun__4_Sep_2005_15_30_24_-0600_es+DuEq7=WfViKod--
