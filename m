From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 06 Apr 2013 16:12:48 +0000
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics adapters on Power
Message-Id: <CAErSpo4oaG8-rPVXt=Qb3m3VT6DdkX15Gz8gqPenQTtsLnaM7w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com> <1365235201.31207.9.camel@pasglop>
In-Reply-To: <1365235201.31207.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brian King <brking@linux.vnet.ibm.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>, klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org

On Sat, Apr 6, 2013 at 2:00 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-04-05 at 14:11 -0600, Bjorn Helgaas wrote:
>>
>> I think sparc has the same issue in its own copy of
>> of_create_pci_dev().
>>
>> Of course, both of_create_pci_dev() implementations are basically
>> copies of the generic pci_setup_device() that most arches use.  That's
>> the reason why I wish sparc and powerpc had used config space
>> accessors that hid the OF mangling internally so they could use the
>> generic pci_setup_device() instead of cloning it.
>
> I disagree :-) I want the config space accessors to actually do the
> config space access (it might be necessary for some reasons, if anything
> for diagnostic). Also one of the reasons we create devices that way
> originally iirc, is that on older pre-PCIe setups, we could have cases
> of a bridge showing up at function N > 0 without anything at function
> 0.
>
> We are also not allowed to mess with bridge BARs on old EADS bridges,
> and similar issues where the hypervisor can get upset.
>
> A "filtering" config space code would be a lot messier than just
> creating them like we do.

Yeah, maybe so.  I guess it's just hard for me to let go of ideas
until I've tried myself and failed :)

Anyway, I hope putting a little more into alloc_pci_dev() will resolve
this particular issue.

Bjorn
