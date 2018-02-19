From: David Miller <davem@davemloft.net>
Date: Mon, 19 Feb 2018 14:49:51 +0000
Subject: Re: [PATCH] sparc: Use generic pci_mmap_resource_range()
Message-Id: <20180219.094951.2098243214524004486.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
In-Reply-To: <1519045452-22645-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw@amazon.co.uk
Cc: sparclinux@vger.kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>
Date: Mon, 19 Feb 2018 13:04:12 +0000

> Commit f719582435 ("PCI: Add pci_mmap_resource_range() and use it for
> ARM64") added this generic function with the intent of using it
> everywhere and ultimately killing the old arch-specific implementations.
> 
> Let's get on with that eradication...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

David, the generic code is definitely doing different things.

For one, the sparc specific code allows mmap'ing any address range
within a PCI bus device.  The generic code does not allow that.

I know this was used by the X server and that's why the logic is
there.

So we can't just use the generic code without breaking things, sorry.
