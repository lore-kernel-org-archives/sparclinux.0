From: David Miller <davem@davemloft.net>
Date: Fri, 20 May 2011 08:08:16 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <20110520.040816.1411861187670192730.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 10:01:11 +0200

> David Miller wrote:
> 
>>From: Daniel Hellstrom <daniel@gaisler.com>
>>Date: Thu, 19 May 2011 15:13:14 +0200
>>
>>  
>>>The PowerPC for example assign resources
>>>(arch/powerpc/kernel/pci-common.c), and PowerPC may also have a
>>>OpenBoot loader:
>>>    
>>
>>On some powerpc systems, like sparc64 Niagara, you can't blindly go
>>poking around the PCI config space at all and must rely completely
>>and entirely upon the OpenBoot device tree.
>>  
> I see, that may be because IRQ routing or resource allocation is done
> in a non-standard way I guess, perhaps because of bugs on some of the
> motherboards.

Or because PCI accesses have to go through a hypervisor.

The point is that having it all setup in OpenBoot is a great
abstraction because you don't have to care.

It also allows things like being able to disable devices with things
like "pcia-probe-list" and "pcib-probe-list" properties in the PCI
host controller node, which we end up honoring on sparc64 simply
because we never directly probe PCI space to probe devices.
