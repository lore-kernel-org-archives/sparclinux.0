From: David Miller <davem@davemloft.net>
Date: Sun, 12 Feb 2012 21:59:03 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120212.165903.587584594133126346.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202122258030.22974@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202122258030.22974@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 12 Feb 2012 23:19:41 +0200 (EET)

> This is my first post-3.2 test on 2-CPU Sun Enterprise 3500 (PCI+SBus 
> IO). prtconf is also below. Something OF-related seems to be happening 
> here.

Since a lot of the regressions popping up lately are due to generic
device-tree layer changes, and not by any Sparc specific changes
(I haven't touched the sparc specific bits in a long time) I'd
really appreciate it if you would at least CC: the appropriate
parties so they could take a look too.

Thanks.
