From: David Miller <davem@davemloft.net>
Date: Mon, 19 Jan 2009 21:26:22 +0000
Subject: Re: fhc led registration warnings
Message-Id: <20090119.132622.254948193.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0901161258360.2120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 19 Jan 2009 09:49:54 +0200 (EET)

> > Does this patch fix the problem?
> > 
> > sparc64: Initialize FHC/CLOCK LED platform_device 'id' field correctly.
> 
> Yes, than you very much!
> 
> [  135.931836] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e] (Central)
> [  135.932612] fhc: Board #3, Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
> [  135.933390] fhc: Board #1, Version[1] PartID[fa0] Manuf[3e]
> [  135.934172] fhc: Board #7, Version[1] PartID[fa0] Manuf[3e]
> [  135.935570] clock_board: Detected 5 slot Enterprise system.
 ...
> With Sams 2 patches and this path, my E3500 seems to work fine again.

Thank you for testing.
