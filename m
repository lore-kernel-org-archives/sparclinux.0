From: David Miller <davem@davemloft.net>
Date: Tue, 07 Apr 2015 00:35:33 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <20150406.203533.1356187749826485194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
In-Reply-To: <20150406220638.GH10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bhelgaas@google.com
Cc: yinghai@kernel.org, david.ahern@oracle.com, linux-pci@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 6 Apr 2015 17:06:38 -0500

> But this is a general change that affects all platforms, and it's late in
> the cycle for something as invasive as this.  I'd rather include your patch
> in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
> windows to fit in upstream windows") for v4.0.

I would kindly ask that we not proceed this way and use the change
which implements the fix properly.
