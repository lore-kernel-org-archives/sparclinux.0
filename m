From: David Miller <davem@davemloft.net>
Date: Thu, 01 Feb 2018 03:36:02 +0000
Subject: Re: [PATCH 2/2] sparc,leon: Select USB_UHCI_BIG_ENDIAN_{MMIO,DESC}
Message-Id: <20180131.223602.362388254047189521.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
        <cover.a68aa8a51a9733579dc929dcc4367a56b22f0c75.1517437177.git-series.jhogan@kernel.org>
        <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
In-Reply-To: <fb8ebffece031b246324cef5ad3afd75cf3795dd.1517437177.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jhogan@kernel.org
Cc: gregkh@linuxfoundation.org, linux-mips@linux-mips.org, paul.burton@mips.com, ralf@linux-mips.org, clabbe.montjoie@gmail.com, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org

From: James Hogan <jhogan@kernel.org>
Date: Wed, 31 Jan 2018 22:24:46 +0000

> Now that USB_UHCI_BIG_ENDIAN_MMIO and USB_UHCI_BIG_ENDIAN_DESC are moved
> outside of the USB_SUPPORT conditional, simply select them from
> SPARC_LEON rather than by the symbol's defaults in drivers/usb/Kconfig,
> similar to how it is done for USB_EHCI_BIG_ENDIAN_MMIO and
> USB_EHCI_BIG_ENDIAN_DESC.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
