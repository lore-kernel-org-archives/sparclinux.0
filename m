From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 27 Mar 2015 21:01:54 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
In-Reply-To: <551495EE.20201@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/26/15 2:43 PM, Yinghai Lu wrote:
>>
>> Can you send out boot log with "debug ignore_loglevel"?
>
>
> attached

So the kernel config is sparc32 or sparc64 ?

pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
0x110204000)


only could happen when dma_addr_t is 32bit.

in drivers/pci/probe.c::__pcie_read_base()
                if ((sizeof(dma_addr_t) < 8) && l) {
                        /* Above 32-bit boundary; try to reallocate */
                        res->flags |= IORESOURCE_UNSET;
                        res->start = 0;
                        res->end = sz64;
                        dev_info(&dev->dev, "reg 0x%x: can't handle
BAR above 4GB (bus address %#010llx)\n",
                                 pos, (unsigned long long)l64);
                        goto out;
                }

also root bus has
pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff]
(bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff]
(bus address [0x00000000-0x7effffff])
pci_bus 0000:00: root bus resource [bus 00-77]

and children device have
pci 0000:05:00.0: can't claim BAR 0 [mem
0x800100000000-0x800100001fff]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 0 [mem 0x800110000000-0x8001101fffff
pref]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 4 [mem 0x800110200000-0x800110203fff
pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 0 [mem 0x800110600000-0x8001107fffff
pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 4 [mem 0x800110404000-0x800110407fff
pref]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 1 [mem
0x800120000000-0x80012000ffff]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 3 [mem
0x800120040000-0x80012007ffff]: no compatible bridge window


looks like some root bus resource get dumped because it is out of range.

Also please make sure your config have

CONFIG_PCI_DEBUG=y

and capture serial console with "debug ignore_loglevel", so we check if
pci 0000:00:01.0 really have resource assigned.

Thanks

Yinghai
