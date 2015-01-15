From: Yinghai Lu <yinghai@kernel.org>
Date: Thu, 15 Jan 2015 04:31:37 +0000
Subject: [PATCH v2 10/10] PCI, sparc: clip firmware assigned resource under parent bridge's
Message-Id: <1421296297-6371-11-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
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
 arch/sparc/kernel/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index b36365f..9ce5afe 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -639,7 +639,10 @@ static void pci_claim_bus_resources(struct pci_bus *bu=
s)
 				       (unsigned long long)r->end,
 				       (unsigned int)r->flags);
=20
-			pci_claim_resource(dev, i);
+			if (pci_claim_resource(dev, i) =3D 0)
+				continue;
+
+			pci_claim_bridge_resource(dev, i);
 		}
 	}
=20
--=20
1.8.4.5

