From: Robert Reif <reif@earthlink.net>
Date: Tue, 21 Aug 2007 23:32:05 +0000
Subject: Re: Re. [SPARC32]: Fix bogus ramdisk image location check.
Message-Id: <46CB75F5.5090401@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040404090209010006060004"
List-Id: <sparclinux.vger.kernel.org>
References: <46CA19DE.3000108@earthlink.net>
In-Reply-To: <46CA19DE.3000108@earthlink.net>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404090209010006060004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

mark@mtfhpc.demon.co.uk wrote:

>Hi Robert,
>
>Can you put some prom_printf's or printk's in to find out where your initrd ramdisk is ending up. 
>
>The code relies on ordering/alignment in the linker script which is not a good idear so the aim needs to be to create some code that correctly identifies the location of the ramdisk without using hard coded offsets based on '&end' and 2*4096 :). I will have another look at the code later on this week and see if I can work out somthing that does the same thing but with more flexibility in what can be done to the linker script (i.e. does not rely on specific alignments and ordering in the linker script).
>
>The information about where the ramdisk is may present a simple solution.
>
>Regards
>    Mark Fortescue.
>
>
>  
>
The following patch gives these numbers:

sparc_ramdisk_image = 3000000, &_end = f028bde0, phys_base = 0, 
sparc_ramdisk_size = 3064303
initrd_start = 3000000, initrd_end = 32ec1ef



--------------040404090209010006060004
Content-Type: text/plain;
 name="init.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="init.diff.txt"

--- a/arch/sparc/mm/init.c
+++ b/arch/sparc/mm/init.c
@@ -206,9 +206,13 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
 	if (sparc_ramdisk_image) {
-		sparc_ramdisk_image -= KERNBASE;
+printk("sparc_ramdisk_image = %x, &_end = %p, phys_base = %lx, sparc_ramdisk_size = %u\n", 
+sparc_ramdisk_image, &_end, phys_base, sparc_ramdisk_size);
+		if (sparc_ramdisk_image >= (unsigned long)&_end - 2 * PAGE_SIZE)
+			sparc_ramdisk_image -= KERNBASE;
 		initrd_start = sparc_ramdisk_image + phys_base;
 		initrd_end = initrd_start + sparc_ramdisk_size;
+printk("initrd_start = %lx, initrd_end = %lx\n", initrd_start, initrd_end);
 		if (initrd_end > end_of_phys_memory) {
 			printk(KERN_CRIT "initrd extends beyond end of memory "
 		                 	 "(0x%016lx > 0x%016lx)\ndisabling initrd\n",

--------------040404090209010006060004--

