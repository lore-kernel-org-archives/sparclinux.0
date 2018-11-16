From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:07:01 +0000
Subject: [PATCH v2 10/10] sparc: Use DT node full_name instead of name for resources
Message-Id: <20181116210701.22968-11-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The device_node.name pointer is going to be removed. As the
device_node.full_name is now just the name+unit-address instead of the
full path, use the full_name pointer instead. This will add the
unit-address if there is one to the resource name.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sparc/kernel/ioport.c       | 2 +-
 arch/sparc/kernel/of_device_32.c | 2 +-
 arch/sparc/kernel/of_device_64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 6799c93c9f27..aeaad04fdd14 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -302,7 +302,7 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 	if (sbus_map_dma_area(dev, dma_addrp, va, res->start, len_total) != 0)
 		goto err_noiommu;
 
-	res->name = op->dev.of_node->name;
+	res->name = op->dev.of_node->full_name;
 
 	return (void *)(unsigned long)res->start;
 
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index ee4841a96058..4ebf51e6e78e 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -333,7 +333,7 @@ static void __init build_device_resources(struct platform_device *op,
 			r->end = result + size - 1;
 			r->flags = flags | ((result >> 32ULL) & 0xffUL);
 		}
-		r->name = op->dev.of_node->name;
+		r->name = op->dev.of_node->full_name;
 	}
 }
 
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index 4b5eabb20ac8..5a9f86b1d4e7 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -413,7 +413,7 @@ static void __init build_device_resources(struct platform_device *op,
 			r->end = result + size - 1;
 			r->flags = flags;
 		}
-		r->name = op->dev.of_node->name;
+		r->name = op->dev.of_node->full_name;
 	}
 }
 
-- 
2.19.1
