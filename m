From: David Miller <davem@redhat.com>
Date: Thu, 26 Sep 2013 17:18:21 +0000
Subject: Re: include/linux/version.h not updated
Message-Id: <20130926.131821.1371932451518980586.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.002304.2121420558807412031.davem@davemloft.net>
	<alpine.SOC.1.00.1309261347030.11084@math.ut.ee>
	<alpine.SOC.1.00.1309261601050.11084@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1309261601050.11084@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Sep 2013 16:12:55 +0300 (EEST)

> As it happens, 198144 is the value from Aug 10 2012 and it happens to be 
> 00030600 hex. Here is the culprit, we are not rebuilding 
> include/linux/version.h.

That explains everything, thanks for tracking it down.
