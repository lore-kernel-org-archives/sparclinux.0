From: David Miller <davem@davemloft.net>
Date: Fri, 27 Mar 2015 21:50:16 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <20150327.145016.86183910134380870.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
In-Reply-To: <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org
Cc: david.ahern@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 27 Mar 2015 14:01:54 -0700

> On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com> wrote:
>> On 3/26/15 2:43 PM, Yinghai Lu wrote:
>>>
>>> Can you send out boot log with "debug ignore_loglevel"?
>>
>>
>> attached
> 
> So the kernel config is sparc32 or sparc64 ?
> 
> pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
> 0x110204000)
> 
> 
> only could happen when dma_addr_t is 32bit.

All DMA occurs behind an IOMMU and these IOMMUs only
support 32-bit addressing, therefore dma_addr_t is
32-bit on sparc64.

If you want to represent PCI address in some way, you
absolutely cannot use dma_addr_t as your data type.
