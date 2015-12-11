From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 11 Dec 2015 05:06:00 +0000
Subject: [PATCH v9 04/60] sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
Message-Id: <1449810416-2950-5-git-send-email-yinghai@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, sparclinux@vger.kernel.org

For device resource PREF bit setting under bridge 64-bit pref resource,
we need to make sure only set PREF for 64bit resource, so set
IORESOUCE_MEM_64 for 64bit resource during of device resource flags
parsing.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=96261
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96241
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Tested-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/kernel/of_device_32.c | 5 +++--
 arch/sparc/kernel/of_device_64.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device=
_32.c
index 185aa96..3e9f273 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -83,11 +83,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *ad=
dr, unsigned long flags)
 	case 0x01:
 		flags |=3D IORESOURCE_IO;
 		break;
-
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |=3D IORESOURCE_MEM;
 		break;
+	case 0x03: /* 64 bits */
+		flags |=3D IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |=3D IORESOURCE_PREFETCH;
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device=
_64.c
index 7bbdc26..defee61 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -146,11 +146,12 @@ static unsigned long of_bus_pci_get_flags(const u32 *=
addr, unsigned long flags)
 	case 0x01:
 		flags |=3D IORESOURCE_IO;
 		break;
-
 	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
 		flags |=3D IORESOURCE_MEM;
 		break;
+	case 0x03: /* 64 bits */
+		flags |=3D IORESOURCE_MEM | IORESOURCE_MEM_64;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |=3D IORESOURCE_PREFETCH;
--=20
1.8.4.5

