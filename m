From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Jan 2005 21:32:56 +0000
Subject: Re: [patch 1/2] ebus.c replace pci_find_device with pci_get_device
Message-Id: <20050110133256.1cd601d2.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050110174852.931F21F1ED@trashy.coderock.org>
In-Reply-To: <20050110174852.931F21F1ED@trashy.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 10 Jan 2005 18:48:51 +0100
domen@coderock.org wrote:

> As pci_find_device is going away I've replaced it with pci_get_device.
> If someone with a Sparc64 system could test it I would appreciate it.
> Thanks.

You need to add the appropriate pci_dev_put() calls if you make
this change since pci_get_device() obtains a reference count
to the device object.
