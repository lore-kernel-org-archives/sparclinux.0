From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 20:05:04 +0000
Subject: [SPARC64]: Use correct register values for OBP names
Message-Id: <20040329200503.GA24518@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This looks like a lot of voodoo, but it fixes two real problems: (1)
SMP systems end up with duplicate entries in openpromfs, and (2) the
names there don't match what's shown by OBP which is confusing.

It works properly on U1, U2, and E3500, but I suspect it only works on
spitfire systems.  I don't have access to any cheetahs.  Probably at
least upa-portid is wrong there, but I have no idea what OBP shows on
such systems anyway.

=== arch/sparc64/prom/tree.c 1.1 vs edited ==--- 1.1/arch/sparc64/prom/tree.c	Tue Feb  5 09:40:29 2002
+++ edited/arch/sparc64/prom/tree.c	Mon Mar 29 11:57:44 2004
@@ -196,6 +196,7 @@
 {
 	int i, sbus = 0;
 	int pci = 0, ebus = 0, ide = 0;
+	char *name;
 	struct linux_prom_registers *reg;
 	struct linux_prom64_registers reg64[PROMREG_MAX];
 	
@@ -241,6 +242,7 @@
 		return -1;
 	}
 	buffer [i] = 0;
+	name = buffer;
 	len -= i;
 	i = prom_getproperty (node, "reg", (char *)reg64, sizeof (reg64));
 	if (i <= 0) return 0;
@@ -267,9 +269,15 @@
 	} else if (i = 4) {	/* Happens on 8042's children on Ultra/PCI. */
 		reg = (struct linux_prom_registers *)reg64;
 		sprintf (buffer, "@%x", reg[0].which_io);
+	} else if (!strcmp(name, "fhc") || !strcmp(name, "counter-timer")) {
+		sprintf(buffer, "@%x,%x",
+			(unsigned int)((reg64[0].phys_addr >> 33) & 0x1f),
+			(unsigned int)(reg64[0].phys_addr));
 	} else {
-		sprintf (buffer, "@%x,%x",
-			 (unsigned int)(reg64[0].phys_addr >> 36),
+		int upaid = prom_getint(node, "upa-portid");
+		if (upaid < 0)
+			upaid = (unsigned int)(reg64[0].phys_addr >> 36);
+		sprintf (buffer, "@%x,%x", upaid,
 			 (unsigned int)(reg64[0].phys_addr));
 	}
 	return 0;


-- 
Keith M Wesolowski
