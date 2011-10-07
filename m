From: David Miller <davem@davemloft.net>
Date: Fri, 07 Oct 2011 15:13:23 +0000
Subject: Re: [PATCH v2] qlogicpti: fix timeout
Message-Id: <20111007.111323.497093696267353976.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1110071050080.648@math.ut.ee>
	<alpine.SOC.1.00.1110071800120.29152@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1110071800120.29152@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: James.Bottomley@hansenpartnership.com, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 7 Oct 2011 18:05:08 +0300 (EEST)

> qlogicpti times out for some tape library operations (like mtx 
> inventory). It seems SCSI command timeout is hardcoded into the driver. 
> Fix it by propagating the timeout from scsi request to the controller as 
> suggested by James Bottomley.
> 
> Tested on Sun Ultra 1 with Sun StorEdge L8 Autoloader.
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

Acked-by: David S. Miller <davem@davemloft.net>
