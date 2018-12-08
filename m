From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 08 Dec 2018 13:14:51 +0000
Subject: Re: [PATCH] sparc: merge 32-bit and 64-bit version of pci.h
Message-Id: <20181208131451.GA25729@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181207141048.2723-1-hch@lst.de>
In-Reply-To: <20181207141048.2723-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Christoph.

Nice simplification.

Your patch deletes the following nice comment:
> -/*
> - * On LEON PCI Memory space is mapped 1:1 with physical address space.
> - *
> - * I/O space is located at low 64Kbytes in PCI I/O space. The I/O addresses
> - * are converted into CPU addresses to virtual addresses that are mapped with
> - * MMU to the PCI Host PCI I/O space window which are translated to the low
> - * 64Kbytes by the Host controller.
> - */
Maybe this is obvious and not relevant to keep?

Other than that:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
