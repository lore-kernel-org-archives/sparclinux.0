From: David Miller <davem@davemloft.net>
Date: Tue, 18 Jul 2006 04:04:09 +0000
Subject: Re: sparc32 git tree
Message-Id: <20060717.210409.26966602.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Raymond Burns <rayburns@comcast.net>
Date: Mon, 17 Jul 2006 11:27:50 -0700 (PDT)

> Since it's probably related I have attached the ksymoops output
> 
> sbus0 suceeds along with it's 3 dma channels.
> prom item:
> /io-unit@f,e0200000/sbi@0,0
> 
> sbus1 dies
> prom item:
> /io-unit@f,e1200000/sbi@0,0

It's trying to register a node named "sbi@0,0" at the top-level
of the SBUS hierarchy twice, which thus fails.

These things live in their own namespace, so let's just do the
following to get them named uniquely:

diff --git a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
index 16b5977..935952e 100644
--- a/drivers/sbus/sbus.c
+++ b/drivers/sbus/sbus.c
@@ -233,7 +233,7 @@ static void __init build_one_sbus(struct
 	sbus->ofdev.node = dp;
 	sbus->ofdev.dev.parent = NULL;
 	sbus->ofdev.dev.bus = &sbus_bus_type;
-	strcpy(sbus->ofdev.dev.bus_id, dp->path_component_name);
+	sprintf(sbus->ofdev.dev.bus_id, "sbus%d", num_sbus);
 
 	if (of_device_register(&sbus->ofdev) != 0)
 		printk(KERN_DEBUG "sbus: device registration error for %s!\n",
