From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 09 Apr 2015 08:54:41 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <1428569681.18187.69.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	 <1427857069-6789-4-git-send-email-yinghai@kernel.org>
	 <20150406220638.GH10892@google.com>
	 <20150406.203533.1356187749826485194.davem@davemloft.net>
	 <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	 <20150408154759.GN10892@google.com>
	 <1428527527.18187.28.camel@kernel.crashing.org>
	 <CAE9FiQXQN-VqN3ynLEhHh5WUYE+8tLR8ubKKMeHZ3h=BQ0rA9A@mail.gmail.com>
	 <1428549459.18187.56.camel@kernel.crashing.org>
	 <CAErSpo5VwuLjZtQFcJqfpkC=j5TJmLD0oZPQ=6oJpSOthB+BFA@mail.gmail.com>
In-Reply-To: <CAErSpo5VwuLjZtQFcJqfpkC=j5TJmLD0oZPQ=6oJpSOthB+BFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Wed, 2015-04-08 at 23:26 -0500, Bjorn Helgaas wrote:
> I'm not planning to review this until after the merge window opens,
> but I took a quick glance, and I agree with Ben.  I don't want to add
> a new IORESOURCE_ flag.  I think a pci_resource_compatible() helper is
> a great idea.

So the new resource flag was handy here still regardless of the
implementation choice because otherwise, we have to do the whole tree
walk to check for "PCI Express only path".

*But*, this is a property of the device as a whole, not of the resource,
so we could instead have a pci_dev flag established at probe time that
indicates that the path to a given device is PCIe only.

The cool thing is that can be very easily done by simply propagating
from the parent. If the parent has it and the device is PCIe, then set
it, the only break would happen on PCIe to PCI bridges, which is exactly
what we are after.

That way, you avoid the special resource flag alltogether.

> I am absolutely not in favor of "minimally intrusive" as a goal.
> "Minimally intrusive" sounds good but it is often used to justify
> clever hacks which end up being an anti-maintainer strategy in the
> long term.  "Maximum readability" is what I'm looking for.

Yup, I agree. The code is too hard to understand already which makes it
bug prone in the long run.

Cheers,
Ben.


