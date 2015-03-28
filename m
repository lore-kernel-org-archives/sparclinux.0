From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 28 Mar 2015 20:19:28 +0000
Subject: Re: d63e2e1f3df breaks sparc/T5-8
Message-Id: <CAE9FiQVoDVZOsjZ827NDnTeQ6WiAWDvPays7RqYB4Q2Jy1nmMw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <551495EE.20201@oracle.com>
	<CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
	<CAE9FiQWwU4gsq4y0+BTMtisBGQDxF1m_pxAT62PmP-Ct+O1c5A@mail.gmail.com>
	<20150328.111621.1041514784349808716.davem@davemloft.net>
In-Reply-To: <20150328.111621.1041514784349808716.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: David Ahern <david.ahern@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Mar 28, 2015 at 11:16 AM, David Miller <davem@davemloft.net> wrote:
> PCI addresses being 64-bit or not is an attribute of the PCI
> controller and the geography of the bridges behind it, not the
> cpu architecture.

Good point. We should add one choice in pci subsystem Kconfig.

Thanks

Yinghai
