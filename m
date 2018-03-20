From: David Miller <davem@davemloft.net>
Date: Tue, 20 Mar 2018 21:04:41 +0000
Subject: Re: [PATCH v2 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180320.170441.1570889987094445930.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152157662729.167463.14127576964193645242.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org
Cc: david.ahern@oracle.com, airlied@linux.ie, linux-pci@vger.kernel.org, linux@iam.tj, alex.williamson@redhat.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, khalid.aziz@oracle.com, sparclinux@vger.kernel.org, yinghai@kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Mar 2018 15:14:01 -0500

> These are from an old series from Yinghai [1] that fix some issues on
> sparc64.  The v1 posting is at [2].
> 
> [1] https://lkml.kernel.org/r/20170421050500.13957-1-yinghai@kernel.org
> [2] https://lkml.kernel.org/r/20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com
> 
> Changes from v1:
> - In v1, I reserved the "Video ROM" and "System ROM" regions from system
>   memory, not from the PCI bus address space.  In v2, I removed those
>   reservations completely because they seem to be copied from x86 and are
>   not applicable on sparc.

For the series:

Acked-by: David S. Miller <davem@davemloft.net>
