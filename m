From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2015 20:15:24 +0000
Subject: Re: [PATCH] sparc64: Fix numa distance values
Message-Id: <20151104.151524.1722330668045451237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1446499824-211085-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1446499824-211085-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nitin.m.gupta@oracle.com
Cc: sparclinux@vger.kernel.org, akpm@linux-foundation.org, chris.hyser@oracle.com, khalid.aziz@oracle.com, iamjoonsoo.kim@lge.com, dahi@linux.vnet.ibm.com, tony.luck@intel.com, santosh.shilimkar@oracle.com, sam@ravnborg.org, linux-kernel@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon,  2 Nov 2015 16:30:24 -0500

> Orabug: 21896119
> 
> Use machine descriptor (MD) to get node latency
> values instead of just using default values.
> 
> Testing:
> On an T5-8 system with:
>  - total nodes = 8
>  - self latencies = 0x26d18
>  - latency to other nodes = 0x3a598
>    => latency ratio = ~1.5
> 
> output of numactl --hardware
 ...
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

Looks good, applied, thanks!
