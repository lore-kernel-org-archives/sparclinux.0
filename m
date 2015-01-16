From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 16 Jan 2015 23:16:28 +0000
Subject: Re: [PATCH 01/28] PCI: Rip out pci_bus_add_devices() from pci_scan_bus()
Message-Id: <CAE9FiQV97PuDWBZYRxh8R0ADnUFTbo1NO3wAufj97en0yseYSQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-2-git-send-email-wangyijing@huawei.com>
 <CAE9FiQUoocCzBKsHL_D4ypH1-DV7XxZMdREX7n=Tz1Kq3kHHeA@mail.gmail.com>
In-Reply-To: <CAE9FiQUoocCzBKsHL_D4ypH1-DV7XxZMdREX7n=Tz1Kq3kHHeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 16, 2015 at 3:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Jan 15, 2015 at 5:43 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>> Pci_bus_add_devices() should not be placed in pci_scan_bus().
>> Now pci device will be added to driver core once its
>> creation. All things left in pci_bus_add_devices() are
>> driver attachment and other trivial sysfs things.
>> Pci_scan_bus() should be the function responsible for
>> scanning PCI devices, not including driver attachment.
>> Other, some callers(m68k,unicore32,alpha) of pci_scan_bus()
>> will call pci_bus_size_bridges() and pci_bus_assign_resources()
>> after pci_scan_bus().
>>
>> E.g.
>> In m68k
>> mcf_pci_init()
>>         pci_scan_bus()
>>                 ...
>>                 pci_bus_add_devices() --- try to attach driver
>>         pci_fixup_irqs()
>>         pci_bus_size_bridges()
>>         pci_bus_assign_resources()
>>
>> It is not correct, resources should be assigned correctly
>> before attaching driver.
>
No, for booting path, at that time pci drivers are *NOT* loaded yet.

Thanks

Yinghai
