From: Yinghai Lu <yinghai@kernel.org>
Date: Sun, 29 Mar 2015 20:07:44 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQXu8qvCo9Dx6vUBXEO029n8K=c=CGtsfvWMGYdVgqtgOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<5515F6B8.8020606@oracle.com>
	<5515F782.7060301@oracle.com>
	<CAE9FiQXpNKrX9BuC5-sgb8XEdFPN1a-wBRR2XqY5Mh1cnhXSPQ@mail.gmail.com>
	<551623C1.2040300@oracle.com>
	<CAE9FiQUNLaNYAk6DoTDCAfbS=B1uks_=381KJDUk46+yg5cVwg@mail.gmail.com>
	<5516BF4B.9030901@oracle.com>
	<CAE9FiQV_BOKQu8+mCqQRx_RJYucwuGAfJog7qoUW0J_i=9u=Tg@mail.gmail.com>
	<55181065.8090807@oracle.com>
In-Reply-To: <55181065.8090807@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>, David Miller <davem@davemloft.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Mar 29, 2015 at 7:47 AM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/28/15 2:24 PM, Yinghai Lu wrote:
>>
>> Can you append "ofpci_debug=1" in boot command line?
>
>
> here you go.


[  286.647560] PCI: scan_bus[/pci@300/pci@1/pci@0/pci@6] bus no 8
[  286.921232] PCI: Claiming 0000:00:01.0: Resource 15:
0000800100000000..00008004afffffff [220c]
[  287.229190] PCI: Claiming 0000:01:00.0: Resource 15:
0000800100000000..00008004afffffff [220c]
[  287.533428] PCI: Claiming 0000:02:04.0: Resource 15:
0000800100000000..000080012fffffff [220c]
[  288.149831] PCI: Claiming 0000:03:00.0: Resource 15:
0000800100000000..000080012fffffff [220c]
[  288.252466] PCI: Claiming 0000:04:06.0: Resource 14:
0000800100000000..000080010fffffff [220c]
[  288.867196] PCI: Claiming 0000:05:00.0: Resource 0:
0000800100000000..0000800100001fff [204]
[  288.968221] pci 0000:05:00.0: can't claim BAR 0 [mem
0x800100000000-0x800100001fff]: no compatible bridge window

the bridge resource has IORESOURCE_PREFETCH, but the device doesn't have that.

So pci_claim_resource can not find parent resource for device
resource: we can not
put non pref mem under pref mem.

Can you send out result from ?
lspci -vvxxx -s 0000:05:00.0

If it does have pref, could be of device layer does not pass the pref
flag properly
via pci_parse_of_addrs/of_get_property(node, "assigned-addresses".

or the addr0 from "ranges" and "assigned-address" has different definition.

Thanks

Yinghai
