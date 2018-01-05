From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 05 Jan 2018 17:45:04 +0000
Subject: Re: [PATCH v7 05/10] PCI: Add support for relative addressing in quirk tables
Message-Id: <CAKv+Gu_1i_8zpYd3UXOLR-AnKNSEVKHGoZxzyNgn=Y46Ghq7iA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-6-ard.biesheuvel@linaro.org>
 <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
In-Reply-To: <20180105174112.jk3mvo5qwg7l4vzo@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 5 January 2018 at 17:41, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Jan 02, 2018 at 08:05:44PM +0000, Ard Biesheuvel wrote:
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 10684b17d0bd..b6d51b4d5ce1 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>>                    f->vendor = (u16) PCI_ANY_ID) &&
>>                   (f->device = dev->device ||
>>                    f->device = (u16) PCI_ANY_ID)) {
>> -                     calltime = fixup_debug_start(dev, f->hook);
>> -                     f->hook(dev);
>> -                     fixup_debug_report(dev, calltime, f->hook);
>> +                     void (*hook)(struct pci_dev *dev);
>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> +                     hook = (void *)((unsigned long)&f->hook_offset +
>> +                                     f->hook_offset);
>> +#else
>> +                     hook = f->hook;
>> +#endif
>
> More of a nitpick but I've seen this pattern in several places in your
> code, maybe worth defining a macro (couldn't come up with a better
> name):
>
> #define offset_to_ptr(off) \
>         ((void *)((unsigned long)&(off) + (off)))
>

Yeah, good point. Or even

static inline void *offset_to_ptr(const s32 *off)
{
    return (void *)((unsigned long)off + *off);
}
