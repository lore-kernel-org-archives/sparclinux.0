From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 19:39:14 +0000
Subject: [PATCH 2/4] resources: Add lookup_resource()
Message-Id: <1306006756-32009-3-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Add a function to find an existing resource by a resource start address.
This allows to implement simple allocators (with a malloc/free-alike API)
on top of the resource system.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/ioport.h |    1 +
 kernel/resource.c      |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e9bb22c..63eb429 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -132,6 +132,7 @@ extern int allocate_resource(struct resource *root, struct resource *new,
 						       resource_size_t,
 						       resource_size_t),
 			     void *alignf_data);
+struct resource *lookup_resource(struct resource *root, resource_size_t start);
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
diff --git a/kernel/resource.c b/kernel/resource.c
index 798e2fa..8d0b479 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -473,6 +473,27 @@ int allocate_resource(struct resource *root, struct resource *new,
 
 EXPORT_SYMBOL(allocate_resource);
 
+/**
+ * lookup_resource - find an existing resource by a resource start address
+ * @root: root resource descriptor
+ * @start: resource start address
+ *
+ * Returns a pointer to the resource if found, NULL otherwise
+ */
+struct resource *lookup_resource(struct resource *root, resource_size_t start)
+{
+	struct resource *res;
+
+	read_lock(&resource_lock);
+	for (res = root->child; res; res = res->sibling) {
+		if (res->start = start)
+			break;
+	}
+	read_unlock(&resource_lock);
+
+	return res;
+}
+
 /*
  * Insert a resource into the resource tree. If successful, return NULL,
  * otherwise return the conflicting resource (compare to __request_resource())
-- 
1.7.0.4

