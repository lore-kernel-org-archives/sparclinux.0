From: David Miller <davem@davemloft.net>
Date: Tue, 16 Apr 2013 21:26:26 +0000
Subject: [PATCH] silo: Add support for firmware flash images on sun4u and later.
Message-Id: <20130416.172626.1145248757320462876.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


You specify the flash image just like a kernel image
with "image=" and "label=" directives.  Then you add
the "flash" boolean option.

Here is an example:

image=/flash_image_file
	label=whatever
	flash

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I've just used this to update the OBP/POST firmware on a Sunblade 2500 (Silver)

 second/cfg.c  |    1 +
 second/main.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/second/cfg.c b/second/cfg.c
index 13dfc64..69de34c 100644
--- a/second/cfg.c
+++ b/second/cfg.c
@@ -93,6 +93,7 @@ CONFIG cf_image[]      {cft_flag, "pause-after", NULL},
     {cft_strg, "pause-message", NULL},
     {cft_flag, "solaris", NULL},
+    {cft_flag, "flash", NULL},
     {cft_flag, "fill-reboot-cmd", NULL},
     {cft_strg, "bootblock", NULL},
     {cft_flag, "single-key", NULL},
diff --git a/second/main.c b/second/main.c
index a45807d..0a90438 100644
--- a/second/main.c
+++ b/second/main.c
@@ -86,6 +86,7 @@ static int floppyswap = 0;
 int tab_ambiguous = 0;
 int other_part = -1;
 int solaris = 0;
+int flash = 0;
 int other = 0;
 char *password = 0;
 int initrd_can_do_64bit_phys = 0;
@@ -537,6 +538,8 @@ static int get_params (char **device, int *part, char **kname, char **proll,
 	    	other = 1;
 	    else if (cfg_get_flag (label, "solaris"))
 	    	solaris = 1;
+	    else if (cfg_get_flag (label, "flash"))
+	    	flash = 1;
 	    p = cfg_get_strg (label, "literal");
 	    if (!p && other)
 	    	p = cfg_get_strg (label, "append");
@@ -851,6 +854,11 @@ static int get_params (char **device, int *part, char **kname, char **proll,
     	    }
     	}
     }
+    if (!flash) {
+    	p = strstr (*params, "flash");
+	if (p)
+	    flash = 1;
+    }
     return 0;
 }
 
@@ -919,7 +927,27 @@ static int parse_executable (unsigned char *base, int image_len, unsigned int *p
 			   "ELF image");
 		prom_halt ();
 	    }
-	    if (solaris) {
+	    if (flash) {
+	        int i;
+
+		if (architecture != sun4u) {
+		    silo_fatal("Flash boots only supported on sun4u "
+			       "and later");
+		    prom_halt ();
+		}
+	        for (i = 0; i < hp.e->e_phnum; i++, p++) {
+	            printf("SILO: Loading flash segment %d at vaddr[0x%x] len[0x%x]\n",
+			   i, p->p_vaddr, p->p_filesz);
+	            memcpy ((char *)p->p_vaddr,
+			    (base + p->p_offset), p->p_filesz);
+	            if (p->p_filesz < p->p_memsz)
+	                memset ((char *)(p->p_vaddr + p->p_filesz), 0,
+				p->p_memsz - p->p_filesz);
+	        }
+	        isfile = 1;
+	        st = hp.e->e_entry;
+		printf("SILO: Flash image entry is at vaddr[0x%x]\n", st);
+	    } else if (solaris) {
 	        int i;
 	        unsigned long sa = (unsigned long)&_start;
 
@@ -977,7 +1005,28 @@ static int parse_executable (unsigned char *base, int image_len, unsigned int *p
 			   "ELF image");
 		prom_halt ();
 	    }
-	    if (solaris) {
+	    if (flash) {
+		int i;
+
+		if (architecture != sun4u) {
+		    silo_fatal("Flash boots only supported on sun4u "
+			       "and later");
+		    prom_halt ();
+		}
+		for (i = 0; i < hp.f->e_phnum; i++, p++) {
+	            printf("SILO: Loading flash segment %d at vaddr[0x%x] len[0x%x]\n",
+			   i, (unsigned int) p->p_vaddr, (unsigned int) p->p_filesz);
+		    memcpy ((Elf64_Addr *)(long)(p->p_vaddr),
+			    (Elf64_Addr *)(long)(base + p->p_offset),
+			    p->p_filesz);
+		    if (p->p_filesz < p->p_memsz)
+			memset ((Elf64_Addr *)(long)(p->p_vaddr + p->p_filesz),
+				0, p->p_memsz - p->p_filesz);
+		}
+		isfile = 1;
+		st = hp.f->e_entry;
+		printf("SILO: Flash image entry is at vaddr[0x%x]\n", st);
+	    } else if (solaris) {
 		int i;
 		unsigned long sa = (unsigned long)&_start;
 
@@ -1257,7 +1306,7 @@ try_again:
     if (solaris) {
     	params = params_device;
     	params_device = sol_params;
-    } else if (!other) {
+    } else if (!other && !flash) {
 	struct HdrS_struct *hdrs;
 
     	params_device = 0;
-- 
1.7.2.5

