From: David Miller <davem@davemloft.net>
Date: Tue, 31 Mar 2015 15:06:36 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150331.110636.1386273674508393491.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
	<5519D40D.20903@oracle.com>
	<CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
In-Reply-To: <CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org
Cc: david.ahern@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 30 Mar 2015 18:06:02 -0700

> ok, that is really non-pref mmio 64bit.
> We can workaround the problem by honoring firmware setting, according
> to https://www.pcisig.com/specifications/pciexpress/base2/PCIe_Base_r2.1_Errata_08Jun10.pdf
> page 13
> 
> Please check attached updated patches that should fix the regression
> and kill those "no compatible window" warnings.

Your patch only allows the condition behind resources that have 64-bits
of significance, but that is not what the document above says about
when this situation is allowed.

Please implement the check either exactly as stated in the errata
document, or more loosely if that is not possible, rather than more
strictly than allowed.

Your overly strict and restrictive checks are what got us into this
predicament in the first place. :-(
