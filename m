From: David Miller <davem@davemloft.net>
Date: Fri, 03 Nov 2006 00:03:39 +0000
Subject: Re: T1000 CPU lockups
Message-Id: <20061102.160339.47547037.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200611011449.37829.dennis@ausil.us>
In-Reply-To: <200611011449.37829.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
Date: Thu, 02 Nov 2006 18:05:54 +0100

> the patch does indeed fix the problem. I was able to build glibc-2.5
> all the way trough on Niagara. I am CC Ben and Martin because we
> need this in .17 kernels too. A similar bug has been found on PPC
> and it has been escalated to local DoS since any user can actually
> kill a system just running the test suite.

Thanks for the testing and confirmation.

Indeed, 2.6.17 has the problem too.  I have already submitted this
patch to the -stable folks for 2.6.17 and 2.6.18 -stable inclusion.
