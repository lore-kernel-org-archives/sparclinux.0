From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 28 Oct 2006 06:46:41 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <4542FCD1.9070301@s5r6.in-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010132943.GB18539@ele.uri.edu>	<20061010.151751.90998930.davem@davemloft.net>	<452CE492.2080607@s5r6.in-berlin.de> <20061027.171210.41635662.davem@davemloft.net>
In-Reply-To: <20061027.171210.41635662.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, simoneau@ele.uri.edu

David Miller wrote:
> Here is the current patch I have Will testing.  It should fix
> all the unaligned u64 pointer dereferences.
> 
> Do you guys mind if I push this into my next batch of 2.6.19-rcX
> networking bug fixes, assuming that testing goes alright for
> Will?

Please do so. Thanks | ACK.
-- 
Stefan Richter
-===-=-=- =-=- ==--
http://arcgraph.de/sr/
