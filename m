From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sat, 24 Sep 2005 09:20:14 +0000
Subject: Ultra2 poweroff patch
Message-Id: <20050924092014.GA852@sparc>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I don't know why, but the following change lets my Ultra2 poweroff.

Christopher

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch

--- linux-2.6.13.1/arch/sparc64/prom/misc.c	2005-09-10 04:42:58.000000000 +0200
+++ linux-2.6.13.1_patched/arch/sparc64/prom/misc.c	2005-09-24 11:10:46.000000000 +0200
@@ -83,17 +83,17 @@
 #endif
 again:
 	p1275_cmd("exit", P1275_INOUT(0, 0));
 	goto again; /* PROM is out to get me -DaveM */
 }
 
 void prom_halt_power_off(void)
 {
-#ifdef CONFIG_SMP
+#ifdef 0 /*CONFIG_SMP*/
 	smp_promstop_others();
 	udelay(8000);
 #endif
 	p1275_cmd("SUNW,power-off", P1275_INOUT(0, 0));
 
 	/* if nothing else helps, we just halt */
 	prom_halt();
 }

--C7zPtVaVf+AK4Oqc--
