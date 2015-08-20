From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Aug 2015 21:30:51 +0000
Subject: Re: A500 boot crash in 4.2.0-rc3-00246-g763e326
Message-Id: <CAErSpo5uC+V29y4TVmjstWyRZRBaA9Ao09bM2pVNmuyrF0grkA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
 <trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
 <trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
 <alpine.LRH.2.20.1508182141200.24742@math.ut.ee> <55D38BE6.6080302@gmx.de>
 <CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
 <alpine.LRH.2.20.1508190747360.5154@math.ut.ee> <CAE9FiQW9hjDe2NBEfwQqcVZoJKqDjKT1P=7FcGjhVrF7wQW9+g@mail.gmail.com>
 <BLU436-SMTP773488774A8C76BF6C12E597670@phx.gbl> <trinity-ceafa563-3aad-4955-a6c6-205a2caf1e95-1439993198188@3capp-gmx-bs16>
 <20150820054234.GA10267@google.com> <CAE9FiQXmzAoJ-5DtrzR94otRKtwJyzAxx8BUK+tuo2j_+rP9JA@mail.gmail.com>
 <55D6435A.9060808@gmx.de>
In-Reply-To: <55D6435A.9060808@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>
Cc: Yinghai Lu <yinghai@kernel.org>, John David Anglin <dave.anglin@bell.net>, Meelis Roos <mroos@linux.ee>, linux-parisc@vger.kernel.org, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>

On Thu, Aug 20, 2015 at 2:15 PM, Helge Deller <deller@gmx.de> wrote:
> On 20.08.2015 21:31, Yinghai Lu wrote:
>>
>> On Wed, Aug 19, 2015 at 10:42 PM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>>
>>> commit 51a660a2732c
>>> Author: Bjorn Helgaas <bhelgaas@google.com>
>>> Date:   Thu Aug 20 00:08:15 2015 -0500
>>>
>>>      PCI: Don't use 64-bit bus addresses on PA-RISC
>>>
>>>      Meelis and Helge reported that 3a9ad0b4fdcd ("PCI: Add
>>> pci_bus_addr_t")
>>>      caused HPMCs on A500 and hangs on rp5470.
>>>
>>>      PA-RISC does not set ARCH_DMA_ADDR_T_64BIT, even for 64-bit kernels,
>>> so
>>>      prior to 3a9ad0b4fdcd, we always used 32-bit PCI addresses.  After
>>>      3a9ad0b4fdcd, we do use 64-bit PCI addresses in 64-bit kernels, and
>>>      apparently there's some PA-RISC problem related to them.
>>>
>>>      Fixes: 3a9ad0b4fdcd ("PCI: Add pci_bus_addr_t")
>>>      Link:
>>> http://lkml.kernel.org/r/alpine.LRH.2.11.1507260929000.30065@math.ut.ee
>>>      Reported-by: Meelis Roos <mroos@linux.ee>
>>>      Reported-by: Helge Deller <deller@gmx.de>
>>>      Based-on-idea-by: Yinghai Lu <yinghai@kernel.org>
>>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 73de4ef..944f500 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -2,7 +2,7 @@
>>>   # PCI configuration
>>>   #
>>>   config PCI_BUS_ADDR_T_64BIT
>>> -       def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
>>> +       def_bool y if (ARCH_DMA_ADDR_T_64BIT || (64BIT && !PARISC))
>>>          depends on PCI
>>>
>>>   config PCI_MSI
>>
>>
>> Yes, that is better.
>>
>> Acked-by: Yinghai Lu <yinghai@kernel.org>
>
>
>
> Tested-by: Helge Deller <deller@gmx.de>
>   and please add:
> CC: stable@vger.kernel.org  # v3.19+

Done, thanks for testing this!
