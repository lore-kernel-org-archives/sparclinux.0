From: David Miller <davem@davemloft.net>
Date: Tue, 23 Feb 2016 20:20:45 +0000
Subject: Re: Invalid sk_policy[] access
Message-Id: <20160223.152045.440181358695767083.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160222010201.GB23053@oracle.com>
	<20160223121244.GI28756@oracle.com>
	<alpine.LRH.2.20.1602232132190.30129@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1602232132190.30129@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 23 Feb 2016 21:36:24 +0200 (EET)

> Sorry, I do not understand - what is 32-bit on V440? The kernel should 
> be 64-bit since it's sun4u.

Indeed, the kernel is 64-bit in both cases.

And the userland bit-arity has no relevance whatsoever for this bug.
