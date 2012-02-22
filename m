From: David Miller <davem@davemloft.net>
Date: Wed, 22 Feb 2012 20:26:26 +0000
Subject: Re: OF-related boot crash in 3.3.0-rc3-00188-g3ec1e88
Message-Id: <20120222.152626.1290364413773909040.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120221010537.GA15898@dhcp-172-17-108-109.mtv.corp.google.com>
	<alpine.SOC.1.00.1202220213180.4171@math.ut.ee>
	<4F45326C.3000408@oldelvet.org.uk>
In-Reply-To: <4F45326C.3000408@oldelvet.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: richm@oldelvet.org.uk
Cc: mroos@linux.ee, tj@kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 22 Feb 2012 18:22:36 +0000

> memblock reserved: ADD [0x0000007fcc0a40-0x0000007fcc0a4e] node 1
> memblock reserved: add [0x0000007fcc0a40-000000007fcc0a4e] node 1 @767

These are physical addresses.

> But a similar address in the registers has fffff800 in there.
> 
> o4: fffff8007fcc0a4d

All of physical memory is mapped linearly starting at 0xfffff80000000000
and this is such a virtual address.
