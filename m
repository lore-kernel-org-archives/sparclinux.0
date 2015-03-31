From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 31 Mar 2015 18:16:11 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQUbKu-UWRBMJwn-fTH+LnEpODnOW+kGHg1FCtTZ3oDepQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
	<5519D40D.20903@oracle.com>
	<CAE9FiQUVSRkKNRzh99JA7V8dqsY78z_GtnMnwTrpSFXkJV9CKA@mail.gmail.com>
	<20150331.110636.1386273674508393491.davem@davemloft.net>
In-Reply-To: <20150331.110636.1386273674508393491.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 31, 2015 at 8:06 AM, David Miller <davem@davemloft.net> wrote:
> Your patch only allows the condition behind resources that have 64-bits
> of significance, but that is not what the document above says about
> when this situation is allowed.
>
> Please implement the check either exactly as stated in the errata
> document, or more loosely if that is not possible, rather than more
> strictly than allowed.
>
> Your overly strict and restrictive checks are what got us into this
> predicament in the first place. :-(

From that errata:
---
Here are criteria that are sufficient to guarantee correctness for a
given candidate BAR:

The entire path from the host to the adapter is over PCI Express.

No conventional PCI or PCI-X devices do peer-t o-peer reads to the
range mapped by the BAR.

The PCI Express Host Bridge does no byte merging. (This is believed to
be true on most
platforms.)

Any locations with read side-effects are never the target of Memory
Reads with the TH bit Set.
See Section 2.2.5
---

We can verify first one that we have all pcie device all the way to
the hostbridge.

But we can not verify or guarantee other three.

System should get better about the constraints with system design.
So if it would assign 64bit (and above 4G) mmio to those non-pref 64bit BAR,
that means it already make sure system design will follow those criteria.
and then we can safely set pref bit in resource flags.

Thanks

Yinghai
