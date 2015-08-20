From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 06:01:19 +0000
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-Id: <CAErSpo7JtRLWRAUPBdsoKauHNmftsb6fST317V9Sg4PkTV91pg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
 <20150818184943.GA26431@google.com> <20150818.121004.1891242587946602543.davem@davemloft.net>
 <20150819221624.GA8150@google.com> <1440023349.2737.21.camel@kernel.crashing.org>
In-Reply-To: <1440023349.2737.21.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, Yijing Wang <wangyijing@huawei.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Meelis Roos <mroos@linux.ee>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>

On Wed, Aug 19, 2015 at 3:29 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-08-19 at 17:16 -0500, Bjorn Helgaas wrote:
>> On Tue, Aug 18, 2015 at 12:10:04PM -0700, David Miller wrote:
>> > From: Bjorn Helgaas <bhelgaas@google.com>
>> > Date: Tue, 18 Aug 2015 13:49:43 -0500
>> >
>> > > [+cc Dave, Eric, Ben, sparclinux]
>> > >
>> > > On Mon, Aug 17, 2015 at 06:47:58PM +0800, Yijing Wang wrote:
>> > > > Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
>> > > > track downstream PCIe links")assumed root port is always
>> > > > the top device in pcie tree. But on sparc64 V245 and T2000tthe
>> > > > pcie tree has no root port device in top level, the
>> > > > upstream port device is connected directly to root bus.
>> > > > So we may get NULL parent for this upstream port device.
>
> Picking up that thread half way through...
>
>> > > > Upstream port ------ Downstream port ------PCIe-PCI bridge
>> > >
>> > > This is an unusual, possibly even illegal, PCIe topology because
>> > > it lacks a Root Port at the top of the hierarchy.  From lspci
>> > > output
>> > > [1]
>> > > collected by Meelis, the top-level devices are:
>
> Nobody cares what is "illegal", what matters is what HW actually does :
> -) Specs only matter as far as they get followed.

I agree.  But nobody can predict all the ways platforms violate specs,
so platforms that don't follow the spec don't work as well, and they
cause a maintenance burden for everybody else.

> In any case, it also
> happens on powerpc, when running under a hypervisor such as IBM
> PowerVM, PCIe devices appear directly under a virtual host bridge which
> is not exposed as a PCIe root complex.

Thanks for the confirmation.

>> I don't like it because we have these PCIe links where we only know
>> about devices on one end of the link, and then we can't manage
>> ASPM/MPS/etc.  But we've had this situation for several years, so
>> I guess nobody cares too much about those things on the affected
>> mahines.
>
> Correct, we have this situation on more than just sparc64 and we
> shouldn't crash. Just don't touch ASPM/MPS/etc... in those cases.

Easier said than done.  AFAIK, we won't crash after we add Yijing's
patch.  But it's unreasonable to expect people writing to the spec to
know the peculiarities of sparc64/powerpc, so there may be future
things we discover the hard way.  We'll just have to deal with them as
we find them.

Bjorn
