From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 14 Jan 2010 19:53:14 +0000
Subject: Re: [PATCH] sparc: leds_resource.end assigned to itself in clock_board_probe()
Message-Id: <4B4F762A.20605@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4B4F4C9B.9040202@gmail.com> <20100114183054.0b53c351@taxman.wild-wind.fr.eu.org>
In-Reply-To: <20100114183054.0b53c351@taxman.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Zyngier <maz@misterjones.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

It should be a 1 byte region.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
>> Is there any reason to assign this to itself?

>> @@ -99,7 +99,6 @@ static int __devinit clock_board_probe(struct
>> of_device *op, 
>>  	p->leds_resource.start = (unsigned long)
>>  		(p->clock_regs + CLOCK_CTRL);
>> -	p->leds_resource.end = p->leds_resource.end;
> 
> I have the feeling that the right fix is to have:
> 
> 	p->leds_resource.end = p->leds_resource.start;
> 
> hence describing a 1 byte region.

diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index f3b5466..4589ca3 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -99,7 +99,7 @@ static int __devinit clock_board_probe(struct of_device *op,
 
 	p->leds_resource.start = (unsigned long)
 		(p->clock_regs + CLOCK_CTRL);
-	p->leds_resource.end = p->leds_resource.end;
+	p->leds_resource.end = p->leds_resource.start;
 	p->leds_resource.name = "leds";
 
 	p->leds_pdev.name = "sunfire-clockboard-leds";
@@ -194,7 +194,7 @@ static int __devinit fhc_probe(struct of_device *op,
 	if (!p->central) {
 		p->leds_resource.start = (unsigned long)
 			(p->pregs + FHC_PREGS_CTRL);
-		p->leds_resource.end = p->leds_resource.end;
+		p->leds_resource.end = p->leds_resource.start;
 		p->leds_resource.name = "leds";
 
 		p->leds_pdev.name = "sunfire-fhc-leds";
