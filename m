From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 10 Apr 2015 04:13:02 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAE9FiQVT8uqBxmQbFrvfoKwuKzsPDmtqYq_KLc2o5Zg-Z=N2ig@mail.gmail.com>
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
	<1428569681.18187.69.camel@kernel.crashing.org>
	<CAE9FiQWf1kRx2Dx7LzCy7WhDonO54Q3o+5Nu+uxxsCs1unBMtg@mail.gmail.com>
	<1428622302.18187.87.camel@kernel.crashing.org>
In-Reply-To: <1428622302.18187.87.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Thu, Apr 9, 2015 at 4:31 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> should we make
>>
>> int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
>>
>> to
>>
>> int pci_bus_alloc_resource(struct pci_bus *bus, struct pci_dev *dev,
>> struct resource *res,
>
> Do you need to pass bus if you have dev ?

in following path:

_pci_assign_resource only take dev, and it will go up for parent bus

        while ((ret = __pci_assign_resource(bus, dev, resno, size,
                                                min_align, fit))) {
                if (!bus->parent || !bus->self->transparent)
                        break;
                bus = bus->parent;
        }

and __pci_assign_resource will call pci_bus_alloc_resource.

so it is could go up several levels to use upper bus there.
