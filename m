From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Mar 2018 20:14:01 +0000
Subject: [PATCH v2 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: David Ahern <david.ahern@oracle.com>, David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org, TJ <linux@iam.tj>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Alex Williamson <alex.williamson@redhat.com>, sparclinux@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

These are from an old series from Yinghai [1] that fix some issues on
sparc64.  The v1 posting is at [2].

[1] https://lkml.kernel.org/r/20170421050500.13957-1-yinghai@kernel.org
[2] https://lkml.kernel.org/r/20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com

Changes from v1:
- In v1, I reserved the "Video ROM" and "System ROM" regions from system
  memory, not from the PCI bus address space.  In v2, I removed those
  reservations completely because they seem to be copied from x86 and are
  not applicable on sparc.

---

Bjorn Helgaas (1):
      sparc/PCI: Stop reserving System ROM and Video ROM in PCI space

Yinghai Lu (1):
      sparc/PCI: Support arbitrary host bridge address offset


 arch/sparc/kernel/pci.c        |    6 ++--
 arch/sparc/kernel/pci_common.c |   54 +++++++++++++++++++---------------------
 arch/sparc/kernel/pci_impl.h   |    4 +++
 3 files changed, 33 insertions(+), 31 deletions(-)
