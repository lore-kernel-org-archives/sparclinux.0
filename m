From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 04 May 2004 13:21:04 +0000
Subject: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504132104.GA23807@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

The following patch replaces unnecessary duplicated testing with a set
of if/else tests, and removes some unused variables in the same routine.
Maybe the 'highest_paddr' value was used in earlier versions of the
file, but it isn't used anywhere now. I've booted a 2.6.6-rc kernel with
this patch applied.

Art Haas

=== arch/sparc/kernel/setup.c 1.28 vs edited ==--- 1.28/arch/sparc/kernel/setup.c	Sun Mar 21 16:43:34 2004
+++ edited/arch/sparc/kernel/setup.c	Mon May  3 14:21:51 2004
@@ -257,7 +257,6 @@
 void __init setup_arch(char **cmdline_p)
 {
 	int i;
-	unsigned long highest_paddr;
 
 	sparc_ttable = (struct tt_entry *) &start;
 
@@ -266,14 +265,23 @@
 	strcpy(saved_command_line, *cmdline_p);
 
 	/* Set sparc_cpu_model */
-	sparc_cpu_model = sun_unknown;
-	if(!strcmp(&cputypval,"sun4 ")) { sparc_cpu_model=sun4; }
-	if(!strcmp(&cputypval,"sun4c")) { sparc_cpu_model=sun4c; }
-	if(!strcmp(&cputypval,"sun4m")) { sparc_cpu_model=sun4m; }
-	if(!strcmp(&cputypval,"sun4s")) { sparc_cpu_model=sun4m; }  /* CP-1200 with PROM 2.30 -E */
-	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=sun4d; }
-	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
-	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
+	if (!strcmp(&cputypval,"sun4 ")) {
+		sparc_cpu_model=sun4;
+	} else if (!strcmp(&cputypval,"sun4c")) {
+		sparc_cpu_model=sun4c;
+	} else if (!strcmp(&cputypval,"sun4m")) {
+		sparc_cpu_model=sun4m;
+	} else if (!strcmp(&cputypval,"sun4s")) {
+		sparc_cpu_model=sun4m;	 /* CP-1200 with PROM 2.30 -E */
+	} else if (!strcmp(&cputypval,"sun4d")) {
+		sparc_cpu_model=sun4d;
+	} else if (!strcmp(&cputypval,"sun4e")) {
+		sparc_cpu_model=sun4e;
+	} else if (!strcmp(&cputypval,"sun4u")) {
+		sparc_cpu_model=sun4u;
+	} else {
+		sparc_cpu_model = sun_unknown;
+	}
 
 #ifdef CONFIG_SUN4
 	if (sparc_cpu_model != sun4) {
@@ -320,16 +328,9 @@
 	(void) prom_probe_memory();
 
 	phys_base = 0xffffffffUL;
-	highest_paddr = 0UL;
 	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
-		unsigned long top;
-
 		if (sp_banks[i].base_addr < phys_base)
 			phys_base = sp_banks[i].base_addr;
-		top = sp_banks[i].base_addr +
-			sp_banks[i].num_bytes;
-		if (highest_paddr < top)
-			highest_paddr = top;
 	}
 	pfn_base = phys_base >> PAGE_SHIFT;
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
