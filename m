From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 23 Feb 2006 12:19:35 +0000
Subject: [PATCH]: Fix SILO initrd calculations
Message-Id: <20060223.041935.49765803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


SILO uses a different idea of "phys_base" than the kernel
does when deciding the value to stick into the ramdisk
cookie of the kernel.

The kernel uses the smallest "phys" found in the "available"
properties, whereas SILO uses the "phys" of the first element of the
"reg" property.  This can be different, as the following Niagara
system /memory node dump shows:

reg                      00000000 00800000 00000003 ff800000 
available                00000003 fffd0000 00000000 00002000 
                         00000003 fffcc000 00000000 00002000 
                         00000003 fffc0000 00000000 00006000 
                         00000003 fffa4000 00000000 0000c000 
                         00000003 ff000000 00000000 00fa2000 
                         00000000 00c00000 00000003 fe3fe000 
name                     memory

0x800000 vs. 0xc00000

The fix is simple, please apply.

--- second/memory.c.~1~	2006-02-20 19:53:01.000000000 -0800
+++ second/memory.c	2006-02-23 04:05:38.000000000 -0800
@@ -289,14 +289,6 @@
 
 	node = prom_finddevice("/memory");
 
-	if (prom_getproperty(node, "reg", (char *)p, 2048) = -1) {
-		free (p);
-		printf("Could not get reg property\n");
-		return (char *)0;
-	}
-
-	phys_base = p[0].phys;
-
 	n = prom_getproplen(node, "available");
 
 	if (!n || n = -1 || prom_getproperty(node, "available", (char *)p, 2048) = -1) {
@@ -308,6 +300,12 @@
 	phys = 0;
         n /= sizeof(*p);
 
+	phys_base = ~(unsigned long long)0;
+	for (i = 0; i < n; i++) {
+		if (p[i].phys < phys_base)
+			phys_base = p[i].phys;
+	}
+
 	for (i = 0; i < n; i++) {
 		/* Do not mess with first 4 Megs of memory */
 		if (p[i].phys = phys_base) {
