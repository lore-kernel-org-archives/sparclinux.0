From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:32 +0000
Subject: [PATCH v2 10/11] tilo: allocate kernel memory dynamically on sun4u
Message-Id: <1387827813-8279-11-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Allocate memory for kernel image dynamically on sun4u. This allows to
boot bigger modern day kernels.

External root image can be used "in-place" from TILO image.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/tilo.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 13 deletions(-)

diff --git a/tilo/tilo.c b/tilo/tilo.c
index d2fcd97b525f..9ed4091e0cdd 100644
--- a/tilo/tilo.c
+++ b/tilo/tilo.c
@@ -171,6 +171,69 @@ extern struct ImageInfo image_table[4];	/* Sun4 kernel, Sun4c/d/m kernel, Sun4u
 
 #define HDRS_TAG	(('H'<<24) | ('d'<<16) | ('r'<<8) | 'S')
 
+static char *sun4u_memory_find (unsigned int len)
+{
+	int n, node, i;
+	struct p1275_mem {
+		unsigned long long phys;
+		unsigned long long size;
+	} *p = (struct p1275_mem *)0;
+	unsigned int virt = 0x40000000;
+	unsigned long long phys = 0, phys_base;
+
+	p = (struct p1275_mem *)malloc(2048);
+
+	node = prom_finddevice("/memory");
+
+	n = prom_getproplen(node, "available");
+
+	if (!n || n = -1 ||
+	    prom_getproperty(node, "available", (char *)p, 2048) = -1) {
+		free (p);
+		printf("Could not get available property\n");
+		return (char *)0;
+	}
+
+	phys = 0;
+	n /= sizeof(*p);
+
+	phys_base = ~(unsigned long long)0;
+	for (i = 0; i < n; i++) {
+		if (p[i].phys < phys_base)
+			phys_base = p[i].phys;
+	}
+
+	for (i = 0; i < n; i++) {
+		/* Do not mess with first 16 Megs of memory */
+		if (p[i].phys = phys_base) {
+			if (p[i].size <= 0x1000000)
+				continue;
+			p[i].phys += 0x1000000;
+			p[i].size -= 0x1000000;
+		}
+
+		if (p[i].size >= len) {
+			phys = p[i].phys;
+			break;
+		}
+	}
+
+	free (p);
+
+	if (!phys) {
+		printf("Could not find any available memory\n");
+		return (char *)0;
+	}
+
+	if (prom_map(PROM_MAP_DEFAULT, (unsigned long long)len, virt, phys) =
+	    -1) {
+		printf("Could not map memory\n");
+		return (char *)0;
+	}
+
+	return (char *)virt + 0x4000;
+}
+
 void parse_executable(char *base, int image_len)
 {
 	union {
@@ -275,10 +338,11 @@ void parse_executable(char *base, int image_len)
 
 char *my_main (struct linux_romvec *promvec, void *cifh, void *cifs)
 {
-char *orig_code,*moved_code,*moved_ramdisk,*moved_kernel,*kernel_base;
+char *orig_code,*moved_code,*moved_ramdisk = NULL,*moved_kernel,*kernel_base;
 unsigned *p,*q = NULL;
 int kernel_number;
 char *kernel_end, *kernel_limit;
+int move_ramdisk;
 
     prom_init(promvec, cifh, cifs);
     
@@ -307,21 +371,55 @@ char *kernel_end, *kernel_limit;
 	}
 	    				
     orig_code = (char*) 0x4000;
-    moved_code = (char*) MOVED_BASE;
-    moved_ramdisk = (char*)((long)(moved_code - image_table[ROOT_IMAGE].packed_len) & ~0xfff);
-    moved_kernel = (char*)((long)(moved_ramdisk - image_table[kernel_number].packed_len) & ~0xfff);
+
+    /*
+     * On sun4u we can allocate more memory and relocate the kernel.
+     */
+    if (kernel_number = SUN4U_KERNEL) {
+        unsigned int size;
+
+	for (size = 64 * 1024 * 1024; size >= 4 * 1024 * 1024;
+	     size -= 4 * 1024 * 1024) {
+		kernel_base = sun4u_memory_find(size);
+		if (kernel_base)
+			break;
+	}
+	if (!kernel_base)
+		goto no_mem;
+	kernel_limit = kernel_base + size;
+	gzminp = (unsigned char *)orig_code +
+		 image_table[kernel_number].packed_start;
+	if (image_table[ROOT_IMAGE].packed_len)
+		image_table[kernel_number].root_start = (unsigned)orig_code +
+			image_table[ROOT_IMAGE].packed_start + 0x400000;
+	else
+		image_table[kernel_number].root_start = 0;
+	move_ramdisk = 0;
+    } else {
+no_mem:
+	move_ramdisk = 1;
+	moved_code = (char*)MOVED_BASE;
+	moved_ramdisk = (char*)((long)(moved_code -
+				image_table[ROOT_IMAGE].packed_len) & ~0xfff);
+	moved_kernel = (char*)((long)(moved_ramdisk -
+			       image_table[kernel_number].packed_len) & ~0xfff);
 #ifdef TILO_DEBUG
-    printf("Locations: moved_code=%x  moved_ramdisk=%x moved_kernel=%x\n",
-	   moved_code, moved_ramdisk, moved_kernel);
+	printf("Locations: moved_code=%x  moved_ramdisk=%x moved_kernel=%x\n",
+	       moved_code, moved_ramdisk, moved_kernel);
 #endif
-    memmove (moved_ramdisk, orig_code + image_table[ROOT_IMAGE].packed_start, image_table[ROOT_IMAGE].packed_len);
-    memmove (moved_kernel, orig_code + image_table[kernel_number].packed_start, image_table[kernel_number].packed_len);
+	memmove(moved_ramdisk, orig_code + image_table[ROOT_IMAGE].packed_start,
+		image_table[ROOT_IMAGE].packed_len);
+	memmove(moved_kernel,
+		orig_code + image_table[kernel_number].packed_start,
+		image_table[kernel_number].packed_len);
+
+	gzminp = (unsigned char *)moved_kernel;		/* decompress kernel */
+	kernel_base = (char*) 0x4000;
+	kernel_limit = moved_kernel;
+    }
 
-    gzminp = (unsigned char *)moved_kernel;		/* decompress kernel */
-    kernel_base = (char*) 0x4000;
     kernel_end = kernel_base +
 		 ((image_table[kernel_number].unpacked_len + 0xfff) & ~0xfff);
-    kernel_limit = moved_kernel;
 
     if (kernel_end > kernel_limit) {
 	printf("No space to decompress the kernel.\n");
@@ -375,8 +473,9 @@ char *kernel_end, *kernel_limit;
     q[5] = image_table[ROOT_IMAGE].packed_len;
  
  						/* move root image */
-    memmove ((void*)(image_table[kernel_number].root_start & 0x3fffff),
-    	moved_ramdisk, image_table[ROOT_IMAGE].packed_len);
+    if (move_ramdisk)
+	memmove ((void*)(image_table[kernel_number].root_start & 0x3fffff),
+		 moved_ramdisk, image_table[ROOT_IMAGE].packed_len);
 #ifdef TILO_DEBUG
     printf("Returning from my_main() with address %x\n", kernel_base);
 #endif
-- 
1.8.5.1

