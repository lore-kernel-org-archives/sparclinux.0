From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 28 Jul 2019 20:25:18 +0000
Subject: Re: [PATCH 5/5] spark/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Message-Id: <db0f3329-898b-d018-a5ed-cd7bdbd649bf@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-6-efremov@linux.com>
In-Reply-To: <20190728202213.15550-6-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Efremov <efremov@linux.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Denis!

On 7/28/19 10:22 PM, Denis Efremov wrote:
> The function pci_resource_to_user() was turned to a weak one. Thus,
> spark-specific version will automatically override the generic one
> and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Typo, it should be "sparc/PCI" in the subject and "sparc-specific"
in the commit description.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
