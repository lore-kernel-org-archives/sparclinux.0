From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 08:38:48 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100
Message-Id: <20080821.013848.150219903.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 21 Aug 2008 11:04:22 +0300 (EEST)

> Sysrq-T and other Sysrq-* commands have not started to magically work 
> with -rc4, so still no dump.

I'd like to help you fix this.

But I suspect, if the cpu is really wedged with interrupts disabled,
no matter how hard we try sysrq isn't going to work unfortunately. :(

Did you already test soemthing, such as get rid of USB support in your
configuration, and after a successful boot try and use sysrq over your
serial console?

Is this serial console over a sunsu device?
