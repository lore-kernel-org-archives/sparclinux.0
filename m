From: David Miller <davem@davemloft.net>
Date: Mon, 23 Sep 2013 20:36:43 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <20130923.163643.2197376291925046530.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com>
	<alpine.SOC.1.00.1309231638330.9952@math.ut.ee>
	<CALMQjD8ys=rGGQ5BVfAVPZuN8urr6_xTtCEWq9sYubP4+0bPjQ@mail.gmail.com>
In-Reply-To: <CALMQjD8ys=rGGQ5BVfAVPZuN8urr6_xTtCEWq9sYubP4+0bPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: oftedal@gmail.com
Cc: mroos@linux.ee, airlied@gmail.com, michel@daenzer.net, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Mon, 23 Sep 2013 21:06:11 +0200

> That looks quite strange. I guess the kernel should map the ROM at the
> address OpenBoot/OF assigned to it. ( 10020000 ).

The address you see is a raw physical I/O address, which is a concatenation
of the I/O window physical address for that PCI controller and the
PCI bus assigned address.

This is what we store in the resource values.

The pci_assign_resource() path must have some bug that causes the
resource values to be set incorrectly or similar.

Meelis, what is the value of pci_resource_start(pdev, PCI_ROM_RESOURCE)
before the pci_map_rom() call?


