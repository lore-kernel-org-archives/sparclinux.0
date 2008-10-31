From: David Miller <davem@davemloft.net>
Date: Fri, 31 Oct 2008 19:02:38 +0000
Subject: Re: [PATCH] Fix PCI resource mmaping on sparc64
Message-Id: <20081031.120238.156698095.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <eed7af970810310513h6c466ce5h7ada2013ab4053b1@mail.gmail.com>
	<eed7af970810310609o632034dia6140f7bec6fee66@mail.gmail.com>
In-Reply-To: <eed7af970810310609o632034dia6140f7bec6fee66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dmitrmax@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "Max Dmitrichenko" <dmitrmax@gmail.com>
Date: Fri, 31 Oct 2008 16:09:48 +0300

Please post sparc patches to the sparclinux mailing list,
CC:'d

> There is a problem discovered in recent versions of ATI Mach64 driver
> in X.org on sparc64 architecture. In short, the driver fails to mmap
> MMIO aperture (PCI resource #2).
> 
> I've found that kernel's __pci_mmap_make_offset() returns EINVAL. It
> checks whether user attempts to mmap more than the resource length,
> which is 0x1000 bytes in our case. But PAGE_SIZE on SPARC64 is 0x2000
> and this is what actually is being mmaped. So __pci_mmap_make_offset()
> failed for this PCI resource.
> 
> Signed-off-by: Max Dmitrichenko <dmitrmax@gmail.com>
> 
> Code seems to be rather old. At least it was the same in 2.6.24. I
> have no explanation why this bug exposed only now. May be before X.org
> used to use some other method to mmap PCI resource into userspace (now
> it uses libpciaccess).
> 
> The patch is against 2.6.26. Greg, please consider to include it into
> the stable trees.

No, the sparc maintainer (that's me) will submit this patch to -stable
if it is correct and appropriate.
