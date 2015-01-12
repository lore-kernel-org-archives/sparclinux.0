From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 12 Jan 2015 19:23:20 +0000
Subject: [PATCH 10/10] PCI, sparc: clip firmware assigned resource under parent bridge's
Message-Id: <1421090600-9750-11-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Yijing Wang <wangyijing@huawei.com>, Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org

Some bios put range that is not fully coverred by root bus resources.
Try to clip them and update them in pci bridge bars.

We'd like to fix other arches instead of just x86.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
Reported-by: Marek Kordik <kordikmarek@gmail.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 6=
4-bit resources")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Yijing Wang <wangyijing@huawei.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b36365f..0e391e5 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -623,6 +623,7 @@ static void pci_claim_bus_resources(struct pci_bus *bus)
 	struct pci_dev *dev;
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		bool changed =3D false;
 		int i;
=20
 		for (i =3D 0; i < PCI_NUM_RESOURCES; i++) {
@@ -639,8 +640,25 @@ static void pci_claim_bus_resources(struct pci_bus *bu=
s)
 				       (unsigned long long)r->end,
 				       (unsigned int)r->flags);
=20
-			pci_claim_resource(dev, i);
+			if (pci_claim_resource(dev, i) >=3D 0)
+				continue;
+
+			if (dev->subordinate &&
+			    i >=3D PCI_BRIDGE_RESOURCES &&
+			    i < PCI_NUM_RESOURCES &&
+			    (dev->class >> 8) =3D PCI_CLASS_BRIDGE_PCI &&
+			    pci_bus_clip_resource(dev, r)) {
+				changed =3D true;
+				pci_claim_resource(dev, i);
+			} else if (i < PCI_BRIDGE_RESOURCES &&
+				   i !=3D PCI_ROM_RESOURCE &&
+				   pci_bus_clip_resource(dev, r)) {
+					pci_update_resource(dev, i);
+					pci_claim_resource(dev, i);
+			}
 		}
+		if (changed)
+			pci_setup_bridge(dev->subordinate);
 	}
=20
 	list_for_each_entry(child_bus, &bus->children, node)
--=20
1.8.4.5

