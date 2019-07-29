From: Denis Efremov <efremov@linux.com>
Date: Mon, 29 Jul 2019 10:06:19 +0000
Subject: Re: [EXTERNAL][PATCH 1/5] PCI: Convert pci_resource_to_user to a weak function
Message-Id: <cd83d298-45f6-7330-0347-96025cde8959@linux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190728202213.15550-1-efremov@linux.com>
 <20190728202213.15550-2-efremov@linux.com>
 <20190728224953.kezztdozc6k24ya3@pburton-laptop>
In-Reply-To: <20190728224953.kezztdozc6k24ya3@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Burton <paul.burton@mips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Paul,

On 29.07.2019 01:49, Paul Burton wrote:
> Hi Denis,
> 
> This is wrong - using __weak on the declaration in a header will cause
> the weak attribute to be applied to all implementations too (presuming
> the C files containing the implementations include the header). You then
> get whichever impleentation the linker chooses, which isn't necessarily
> the one you wanted.

Thank you for pointing me on that. I will prepare the v2.
