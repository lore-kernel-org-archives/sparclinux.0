From: mroos@linux.ee
Date: Tue, 14 Feb 2012 05:54:18 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <alpine.SOC.1.00.1202140750130.1759@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20120213080618.GA11077@ponder.secretlab.ca> <alpine.SOC.1.00.1202131119040.1488@math.ut.ee> <20120213214623.GJ11077@ponder.secretlab.ca> <20120213.195835.1573147101037168145.davem@davemloft.net>
In-Reply-To: <20120213.195835.1573147101037168145.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

> FWIW I've been running current kernels on my niagara boxes without
> incident for several weeks.

It runs for me on Ultra 1, Ultra 5 IDE, Ultra 10 SCSI and Blade 100. 
Fails on E3500, V100 and Netra X1 so it's probably dependent on 
something in the device tree.

I will try bisecting and the suggested printk's but it takes time since 
I will be away from computers most of today.

-- 
Meelis Roos (mroos@linux.ee)
