From: Yinghai Lu <yinghai@kernel.org>
Date: Mon, 06 Apr 2015 22:35:40 +0000
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
Message-Id: <CAE9FiQWz_VYOmrN+L3nAAmA7OqZdAYawwku2A09RVrNObQn4jQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	<1427857069-6789-4-git-send-email-yinghai@kernel.org>
	<20150406220638.GH10892@google.com>
In-Reply-To: <20150406220638.GH10892@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Miller <davem@davemloft.net>, David Ahern <david.ahern@oracle.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>

On Mon, Apr 6, 2015 at 3:06 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> But this is a general change that affects all platforms, and it's late in
> the cycle for something as invasive as this.  I'd rather include your patch
> in the v4.1 merge window, and revert d63e2e1f3df9 ("sparc/PCI: Clip bridge
> windows to fit in upstream windows") for v4.0.

How about applying first two in this patchset for v4.0, and leaving
this one for v4.1?

Thanks

Yinghai
