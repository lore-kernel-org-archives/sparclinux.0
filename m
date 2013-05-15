From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 May 2013 21:32:37 +0000
Subject: Re: [PATCH v2, part 1 3/9] PCI: Convert alloc_pci_dev(void) to pci_alloc_dev(bus) instead
Message-Id: <1368653557.9603.21.camel@pasglop>
List-Id: <sparclinux.vger.kernel.org>
References: <1368461313-4371-1-git-send-email-jiang.liu@huawei.com>
	 <1368461313-4371-4-git-send-email-jiang.liu@huawei.com>
	 <CAE9FiQVKKKmZRQ8CcKCzU8Gqzwb5SjWYagVB2OZiRqbSWXVpiw@mail.gmail.com>
	 <5191F53E.4000305@cn.fujitsu.com> <51925136.5050302@gmail.com>
	 <CAE9FiQWO-jR5y35kKiW0m6gVR54ZyRsBsdhP4BmFLSsDzCS3rA@mail.gmail.com>
	 <51926CF6.1050706@gmail.com>
	 <CAE9FiQWXN_ETRFPb5oFx-6LXyuHviX3h3NXCQKjcxtv2Uma-JA@mail.gmail.com>
	 <51939E16.9090105@gmail.com>
	 <CAE9FiQUXrOmN0rkvOwE1G_acEGY3-gouzaXjBMT7EE6uAqvuZA@mail.gmail.com>
	 <51939FB1.20203@gmail.com>
	 <CAE9FiQVCSm14S0A1sVWewc7UX-dyOmu9aq1UwqdPZK6qSmbFxQ@mail.gmail.com>
In-Reply-To: <CAE9FiQVCSm14S0A1sVWewc7UX-dyOmu9aq1UwqdPZK6qSmbFxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yinghai Lu <yinghai@kernel.org>
Cc: Liu Jiang <liuj97@gmail.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, linuxppc-dev@lists.ozlabs.org, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Gu Zheng <guz.fnst@cn.fujitsu.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Myron Stowe <myron.stowe@redhat.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>

On Wed, 2013-05-15 at 07:58 -0700, Yinghai Lu wrote:

> Ben,
> 
> in drivers/pci/probe.c::pci_scan_device() there is
> 
>         pci_set_of_node(dev);
> 
>         if (pci_setup_device(dev)) {
>                 kfree(dev);
>                 return NULL;
>         }
> 
> so if pci_setup_device fails, there is one dev reference is not release.
> 
> please check you can just move down pci_set_of_node down after that
> failing path, like
> 
> 
>         if (pci_setup_device(dev)) {
>                 kfree(dev);
>                 return NULL;
>         }
> 
>         pci_set_of_node(dev);

No, we want the OF node set when we run the quirks, we intentionally do
that early, the right thing to do is to to call pci_release_of_node()
in the error path (it's safe to call even if the node is NULL).

Cheers,
Ben.



