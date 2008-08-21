From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 09:59:01 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.025901.143635734.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 12:47:57 +0300 (EEST)

> calling  i2c_ali15x3_init+0x8/0x38 [i2c_ali15x3]
> 
> Three outstanding initcalls (some awk & diff shows there are no more).

This driver uses 16-bit I/O port addressing :-(  That won't work
on anything other than x86.

This I2C_ALI15X3 driver will definitely hard hang your system.
