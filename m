From: David Miller <davem@davemloft.net>
Date: Sun, 13 May 2007 03:04:46 +0000
Subject: Re: parport_pc BUG in dma-mapping.h
Message-Id: <20070512.200446.63127628.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705121525460.4493@math>
In-Reply-To: <Pine.SOC.4.64.0705121525460.4493@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sat, 12 May 2007 22:54:44 +0300 (EEST)

> Tried todays git kernel on Ultra 5 (withe the pci __init change and 
> solaris module export patch). Cups startup causes parport_pc probe and 
> this causes the following BUG. Full dmesg is also below.

Usually you're so good at providing you're .config in each and every
report, but you didn't do that this time, please do so.
