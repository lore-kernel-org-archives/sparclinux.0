From: Paul Burton <paul.burton@mips.com>
Date: Sun, 28 Jul 2019 22:49:55 +0000
Subject: Re: [EXTERNAL][PATCH 1/5] PCI: Convert pci_resource_to_user to a weak function
Message-Id: <20190728224953.kezztdozc6k24ya3@pburton-laptop>
List-Id: <sparclinux.vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-2-efremov@linux.com>
In-Reply-To: <20190728202213.15550-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Efremov <efremov@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Denis,

On Sun, Jul 28, 2019 at 11:22:09PM +0300, Denis Efremov wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..1a19d0151b0a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1870,25 +1870,13 @@ static inline const char *pci_name(const struct pci_dev *pdev)
>  	return dev_name(&pdev->dev);
>  }
>  
> -
>  /*
>   * Some archs don't want to expose struct resource to userland as-is
>   * in sysfs and /proc
>   */
> -#ifdef HAVE_ARCH_PCI_RESOURCE_TO_USER
> -void pci_resource_to_user(const struct pci_dev *dev, int bar,
> -			  const struct resource *rsrc,
> -			  resource_size_t *start, resource_size_t *end);
> -#else
> -static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
> -		const struct resource *rsrc, resource_size_t *start,
> -		resource_size_t *end)
> -{
> -	*start = rsrc->start;
> -	*end = rsrc->end;
> -}
> -#endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
> -
> +void __weak pci_resource_to_user(const struct pci_dev *dev, int bar,
> +				 const struct resource *rsrc,
> +				 resource_size_t *start, resource_size_t *end);
>  
>  /*
>   * The world is not perfect and supplies us with broken PCI devices.

This is wrong - using __weak on the declaration in a header will cause
the weak attribute to be applied to all implementations too (presuming
the C files containing the implementations include the header). You then
get whichever impleentation the linker chooses, which isn't necessarily
the one you wanted.

checkpatch.pl should produce an error about this - see the
WEAK_DECLARATION error introduced in commit 619a908aa334 ("checkpatch:
add error on use of attribute((weak)) or __weak declarations").

Thanks,
    Paul
