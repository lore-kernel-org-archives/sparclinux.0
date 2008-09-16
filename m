From: Meelis Roos <mroos@ut.ee>
Date: Tue, 16 Sep 2008 06:03:44 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <Pine.SOC.4.64.0809160901510.6345@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Please try this patch:

Works, thank you very much!

Now it boots up with IRQF_SHARED patch applied and no warnings.

About the PCI Quad HME problem - the device is missing from lspci too
so it's not sunhme driver problem AFAICS.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
