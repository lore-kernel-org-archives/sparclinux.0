From: Daniel Hellstrom <daniel@gaisler.com>
Date: Fri, 20 May 2011 08:01:11 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <4DD61FC7.6030204@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Thu, 19 May 2011 15:13:14 +0200
>
>  
>
>>The PowerPC for example assign resources
>>(arch/powerpc/kernel/pci-common.c), and PowerPC may also have a
>>OpenBoot loader:
>>    
>>
>
>On some powerpc systems, like sparc64 Niagara, you can't blindly go
>poking around the PCI config space at all and must rely completely
>and entirely upon the OpenBoot device tree.
>  
>
I see, that may be because IRQ routing or resource allocation is done in 
a non-standard way I guess, perhaps because of bugs on some of the 
motherboards. On all LEON PCI systems I have tested IRQ routing is done 
the standard way and resource allocation need no special quirks, even 
though linux provides means for fixing stuff like that in some degree on 
LEON we currently need no fixups. It just runs beautiful and linux sets 
everything up for us :)

I'm not sure, but I think on x86 the BIOS setup is sometimes discarded 
and linux initializes some resources itself.

>The support you see there is for older and embedded systems.
>  
>
LEON is a embedded system.

I will add support for PROM nodes in LEON PCI layer and fix the build 
error Jan discovered, I have to do that anyways.

Daniel

