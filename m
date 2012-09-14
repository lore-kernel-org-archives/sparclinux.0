From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 14 Sep 2012 22:35:31 +0000
Subject: Re: [PATCH 1/2] PCI: Annotate pci_fixup_irqs with __devinit
Message-Id: <20120914223531.GA8771@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
In-Reply-To: <CAErSpo6BqPUEpMmh2+FuEi-mHFK0U1XCmdCpJfo6V2XcNxzMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 14, 2012 at 02:53:11PM -0600, Bjorn Helgaas wrote:
> +cc Greg KH
> 
> On Fri, Sep 14, 2012 at 2:44 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > In order to keep pci_fixup_irqs() around after init (e.g. for hotplug),
> > mark it __devinit instead of __init. This requires the same change for
> > the implementation of the pcibios_update_irq() function on all
> > architectures.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Note: Ideally these annotations should go away completely in order to
> > be independent of the HOTPLUG symbol. However, there is work underway
> > to get rid of HOTPLUG altogether, so I've kept the __devinit for now.

No, just take away the __init marking completly.  For 3.7,
CONFIG_HOTPLUG will always be enabled, making it be the same thing.
That way this saves me the time and energy from deleting the __devinit
markings when I get to that point in the patch series :)

thanks,

greg k-h
