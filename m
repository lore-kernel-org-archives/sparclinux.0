From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2008 16:35:09 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080916.093509.31665516.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Tue, 16 Sep 2008 09:03:44 +0300 (EEST)

> > Please try this patch:
> 
> Works, thank you very much!
> 
> Now it boots up with IRQF_SHARED patch applied and no warnings.

Thanks for testing, I'll push that fix upstream.

> About the PCI Quad HME problem - the device is missing from lspci too
> so it's not sunhme driver problem AFAICS.

I'll try to figure out why we don't add that to the PCI device
list.  It is there in the device tree, but for some reason
the code that pulls the PCI devices from the device tree into
the PCI layer isn't doing so for these specific interfaces.
