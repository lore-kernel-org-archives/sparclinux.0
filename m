From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 16 Dec 2005 22:29:29 +0000
Subject: Re: 2.6.15.rc5+git fails to boot on Ultra 5
Message-Id: <20051216.142929.44398821.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512141730370.26778@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Dec 2005 15:16:38 +0200 (EET)

> I reverted locally applied IRQ stack patch and compiled todays git and 
> it boots fine.
> 
> Maybe something was botched in my tree, or maybe irqstacks do not wor 
> with current git snapshot.

Thanks for the report.

Something is funky for some reason wrt. that patch, and I intend
to get back to it.  You'll also be happy to know that I have
reproduced that SAB serial console corruption thing here locally
so that might get fixed soon too :-)
