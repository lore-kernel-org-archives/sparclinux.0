From: "c.hota" <cghota@mail.midsouth.ualr.edu>
Date: Thu, 02 Sep 2004 15:52:30 +0000
Subject: pci_iommu: alloc_streaming_cluster of npages(1) failed!
Message-Id: <413741BE.9010603@midsouth.ualr.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <413741AD.2050707@midsouth.ualr.edu>
In-Reply-To: <413741AD.2050707@midsouth.ualr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

I am having problems with my SunFire V100.  I loaded Gentoo on it, 
everything went fine, it boots, gives me a login prompt, and all is well 
with the world... for about 30 seconds.

Then, I see the following on my screen:

pci_iommu: alloc_streaming_cluster of npages(1) failed!

Over and over again.

Googling this problem brings up:
    /usr/src/linux/arch/sparc64/kernel/pci_iommu.c
    http://www2.randomlogic.com/linux_html/140152.html

This isn't much help for me, though.  If anyone can let me know what's 
wrong and (even better) how to fix it, I'd be very grateful.

Thanks,

chris.

-- 
Chris Hota
cghota@midsouth.ualr.edu
(501)683-7339 desk
(501)413-1176 cell
http://www.midsouth.ualr.edu/ 

