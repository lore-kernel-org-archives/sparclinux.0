From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2012 20:43:43 +0000
Subject: Re: [PATCH 16/21] sparc/PCI: register busn_res for root buses
Message-Id: <20120507.164343.229555682968117237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
	<1336422606-4244-17-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-17-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yinghai@kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, tony.luck@intel.com, x86@kernel.org, linux@dominikbrodowski.net, akpm@linux-foundation.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Mon,  7 May 2012 13:30:01 -0700

> Add the host bridge bus number aperture to the resource list.
> Like the MMIO and I/O port apertures, this is used when assigning
> resources to hot-added devices or in the case of conflicts.
> 
> [bhelgaas: write changelog]
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
