From: David Miller <davem@davemloft.net>
Date: Tue, 30 Aug 2011 02:34:04 +0000
Subject: Re: 3.0.3 on V120 Panic
Message-Id: <20110829.223404.328606541669023992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
In-Reply-To: <D5A65271-7B45-4B76-AC73-A4F140F1FB11@nayr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ryan <admin@nayr.net>
Date: Mon, 29 Aug 2011 16:58:21 -0600

> Built latest stable kernel and it works perfectly fine on a SunFire
> T1000, tried to install the same kernel on a V120 and this is the
> result from boot:

I know, I hit this myself earlier today, this should fix it:

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 3e9daea..3c5bb78 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -440,8 +440,14 @@ static void __init init_sparc64_elf_hwcap(void)
 			cap |= AV_SPARC_VIS;
 		if (tlb_type = cheetah || tlb_type = cheetah_plus)
 			cap |= AV_SPARC_VIS | AV_SPARC_VIS2;
-		if (tlb_type = cheetah_plus)
-			cap |= AV_SPARC_POPC;
+		if (tlb_type = cheetah_plus) {
+			unsigned long impl, ver;
+
+			__asm__ __volatile__("rdpr %%ver, %0" : "=r" (ver));
+			impl = ((ver >> 32) & 0xffff);
+			if (impl = PANTHER_IMPL)
+				cap |= AV_SPARC_POPC;
+		}
 		if (tlb_type = hypervisor) {
 			if (sun4v_chip_type = SUN4V_CHIP_NIAGARA1)
 				cap |= AV_SPARC_ASI_BLK_INIT;
