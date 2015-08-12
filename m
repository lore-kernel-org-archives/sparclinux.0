From: Meelis Roos <mroos@linux.ee>
Date: Wed, 12 Aug 2015 18:56:34 +0000
Subject: bisected: boot hang on sparc64 after PCIe changes
Message-Id: <alpine.LRH.2.20.1508122118210.18637@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

4.1.0 worked but 4.2-rc2 hangs on boot after switching console but=20
before reprinting dmesg to the new console. That happens on 2 of my=20
sparc64's: T2000 and V245. These happen to have the PCIe slot names in=20
sysfs so it may be related. The following commit breaks the boot at=20
least on V245 where I performed the bisection:

d0751b98dfa391f862e02dc36a233a54615e3f1d is the first bad commit
commit d0751b98dfa391f862e02dc36a233a54615e3f1d
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Thu May 21 15:05:02 2015 +0800

    PCI: Add dev->has_secondary_link to track downstream PCIe links

    A PCIe Port is an interface to a Link.  A Root Port is a PCI-PCI bridge=
 in
    a Root Complex and has a Link on its secondary (downstream) side.  For
    other Ports, the Link may be on either the upstream (closer to the Root
    Complex) or downstream side of the Port.

    The usual topology has a Root Port connected to an Upstream Port.  We
    previously assumed this was the only possible topology, and that a
    Downstream Port's Link was always on its downstream side, like this:

                      +---------------------+
      +------+        |          Downstream |
      | Root |        | Upstream       Port +--Link--
      | Port +--Link--+ Port                |
      +------+        |          Downstream |
                      |                Port +--Link--
                      +---------------------+

    But systems do exist (see URL below) where the Root Port is connected t=
o a
    Downstream Port.  In this case, a Downstream Port's Link may be on eith=
er
    the upstream or downstream side:

                      +---------------------+
      +------+        |            Upstream |
      | Root |        | Downstream     Port +--Link--
      | Port +--Link--+ Port                |
      +------+        |          Downstream |
                      |                Port +--Link--
                      +---------------------+

    We can't use the Port type to determine which side the Link is on, so a=
dd a
    bit in struct pci_dev to keep track.

    A Root Port's Link is always on the Port's secondary side.  A component
    (Endpoint or Port) on the other end of the Link obviously has the Link =
on
    its upstream side.  If that component is a Port, it is part of a Switch=
 or
    a Bridge.  A Bridge has a PCI or PCI-X bus on its secondary side, not a
    Link.  The internal bus of a Switch connects the Port to another Port w=
hose
    Link is on the downstream side.

    [bhelgaas: changelog, comment, cache "type", use if/else]
    Link: http://lkml.kernel.org/r/54EB81B2.4050904@pobox.com
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=94361
    Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

:040000 040000 3ab85bca5c0a1bdb75f7b83131482fe63110c96f dc49c2621bd450d16ee=
a33491a27affc1dab35ce M      drivers
:040000 040000 37493ef5238ad154ccad6a184617975e8502730e ef846910636ac240587=
9bcf5395e261df396e266 M      include


--=20
Meelis Roos (mroos@linux.ee)
