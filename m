From: Grant Grundler <grundler@parisc-linux.org>
Date: Mon, 10 Jan 2005 18:28:46 +0000
Subject: PATCH 2.6.10 pci_psycho brainfart
Message-Id: <20050110182846.GA17459@colo.lackof.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave,
I've had more than my fair share of brainfarts...
Patch is against 2.6.10.

hth,
grant

Index: arch/sparc64/kernel/pci_psycho.c
=================================RCS file: /var/cvs/linux-2.6/arch/sparc64/kernel/pci_psycho.c,v
retrieving revision 1.6
diff -u -p -r1.6 pci_psycho.c
--- arch/sparc64/kernel/pci_psycho.c	30 Sep 2004 12:07:55 -0000	1.6
+++ arch/sparc64/kernel/pci_psycho.c	10 Jan 2005 18:17:08 -0000
@@ -453,9 +453,9 @@ static void __psycho_check_one_stc(struc
 		tag_base = regbase + PSYCHO_STC_TAG_A;
 		line_base = regbase + PSYCHO_STC_LINE_A;
 	} else {
-		err_base = regbase + PSYCHO_STC_ERR_A;
-		tag_base = regbase + PSYCHO_STC_TAG_A;
-		line_base = regbase + PSYCHO_STC_LINE_A;
+		err_base = regbase + PSYCHO_STC_ERR_B;
+		tag_base = regbase + PSYCHO_STC_TAG_B;
+		line_base = regbase + PSYCHO_STC_LINE_B;
 	}
 
 	spin_lock(&stc_buf_lock);
