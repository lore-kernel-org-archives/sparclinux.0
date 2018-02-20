From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 20 Feb 2018 23:39:35 +0000
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-Id: <20180220233935.GE32228@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180215151118.196756.99622.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org, David Ahern <david.ahern@oracle.com>, TJ <linux@iam.tj>

[+cc David Ahern, TJ]

On Thu, Feb 15, 2018 at 09:17:58AM -0600, Bjorn Helgaas wrote:
> I'm trying to make some progress on this old series from Yinghai [1].
> There's a lot more to do than just these first two patches, but maybe a
> tiny bit of incremental progress is better than none.
> 
> The first patch ("Support arbitrary host bridge address offset") is
> unchanged from Yinghai's posting except for the changelog.
> 
> I'm interested in feedback about the second ("Reserve System ROM and Video
> ROM") patch because it changes something that *looks* wrong to me, but I
> don't know anything about the Sparc address map.
> 
> If this is on the right track, I'd like to merge these via my PCI tree in
> the hope that I can include more of Yinghai's patches as well.
> 
> [1] https://lkml.kernel.org/r/20170421050500.13957-1-yinghai@kernel.org
> 
> ---
> 
> Bjorn Helgaas (1):
>       sparc/PCI: Reserve System ROM and Video ROM outside of PCI space
> 
> Yinghai Lu (1):
>       sparc/PCI: Support arbitrary host bridge address offset
> 
> 
>  arch/sparc/kernel/pci.c        |    6 ++--
>  arch/sparc/kernel/pci_common.c |   54 +++++++++++++++++++---------------------
>  arch/sparc/kernel/pci_impl.h   |    4 +++
>  arch/sparc/mm/init_64.c        |   17 +++++++++++++
>  4 files changed, 50 insertions(+), 31 deletions(-)

Both these patches are on my pci/sparc branch and appeared in the
Feb 19 linux-next tree.

Any testing and feedback (especially on the second patch, which should
change /proc/iomem) would be great.

They're headed for v4.17 unless I hear about issues.

It would be useful to hear about what's still broken so I can try to
pull in the other patches.

IIUC, the first patch should fix something on T4.

I think patch 04/13 of the original series adds IORESOURCE_MEM_64 to
host bridge windows.  We don't do that for other arches, so it's not
clear to me why we need it for sparc.

Patch 09/13 of the original series fixes something on T5-8.  I haven't
included that yet, so it's probably still broken.

Bjorn
