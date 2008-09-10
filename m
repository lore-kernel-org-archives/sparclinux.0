From: Robert Reif <reif@earthlink.net>
Date: Wed, 10 Sep 2008 02:25:47 +0000
Subject: Re: [PATCH 2/2]: sparc32: Use OF device probing for sun4m irq registers.
Message-Id: <48C7302B.7050200@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080908.222028.203662832.davem@davemloft.net>
In-Reply-To: <20080908.222028.203662832.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

With both patches applied, I get:

<#0> ok boot
Boot device: /iommu/sbus/SUNW,fas/sd@0,0 File and args:
SILO Version 1.4.13
boot:
Uncompressing image...
Loading kernel version 2.6.27
Loading initial ramdisk (2738820 bytes at 0x3000000 phys, 0x60000000 
virt)...
PROMLIB: obio_ranges 5
OF stdout device is: /iommu@f,e0000000/sbus@f,e0001000/cgsix@3,0
Booting Linux...
Level 15 Interrupt
<#2 ok>
