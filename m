From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 28 Mar 2015 20:24:27 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQV_BOKQu8+mCqQRx_RJYucwuGAfJog7qoUW0J_i=9u=Tg@mail.gmail.com>
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
In-Reply-To: <5516BF4B.9030901@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Ahern <david.ahern@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Mar 28, 2015 at 7:48 AM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/27/15 11:26 PM, Yinghai Lu wrote:
>>

>>
>> looks like the offset for mem64 is not right.
>>
>> Please try attached v2.

still have problem.

[139295.760918] pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
[139295.831448] pci_bus 0000:00: root bus resource [io
0x804000000000-0x80400fffffff] (bus address [0x0000-0xfffffff])
[139295.958623] pci_bus 0000:00: root bus resource [mem
0x800000000000-0x80007effffff] (bus address [0x00000000-0x7effffff])
[139296.091392] pci_bus 0000:00: root bus resource [mem
0x800100000000-0x8007ffffffff] (bus address [0x100000000-0x7ffffffff])
[139296.225779] pci_bus 0000:00: root bus resource [bus 00-77]
...
[139298.092814] pci 0000:05:00.0: can't claim BAR 0 [mem
0x800100000000-0x800100001fff]: no compatible bridge window
[139298.215949] pci 0000:06:00.0: can't claim BAR 7 [mem
0x800110204000-0x800110303fff 64bit]: no compatible bridge window
[139298.346479] pci 0000:06:00.0: can't claim BAR 10 [mem
0x800110304000-0x800110403fff 64bit]: no compatible bridge window
[139298.476953] pci 0000:06:00.1: can't claim BAR 7 [mem
0x800110408000-0x800110507fff 64bit]: no compatible bridge window
[139298.607105] pci 0000:06:00.1: can't claim BAR 10 [mem
0x800110800000-0x8001108fffff 64bit]: no compatible bridge window
[139298.739341] pci 0000:07:00.0: can't claim BAR 1 [mem
0x800120000000-0x80012000ffff]: no compatible bridge window
[139298.862467] pci 0000:07:00.0: can't claim BAR 3 [mem
0x800120040000-0x80012007ffff]: no compatible bridge window

Can you append "ofpci_debug=1" in boot command line?

So we can check if the bridge get 64 bus from the of layer.

Thanks

Yinghai
