From: Meelis Roos <mroos@linux.ee>
Date: Fri, 31 Oct 2014 21:03:28 +0000
Subject: Re: NULL dereference in schizo error handler
Message-Id: <alpine.DEB.2.03.1410312253370.17220@cyber.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> I understand there is a bug in earlier revisions of Schizo PCI bridge
>> (that I have in my V480) and we do not have a workaround for that. Now
>> when I happen to hit it, I get a crash in the handler and that seems a
>> bug whether or not we have the workaround.
>>
>> In particular, it seems that pbm->pci_bus->self is NULL and that causes
>> a NULL pointer dereference in schizo_pcierr_intr_other:
>>
>> pci_read_config_word(pbm->pci_bus->self, PCI_STATUS, &stat);
>>
>> Since the error happens during PCI scanning, maybe we just do not have
>> this field initialized yet - in pci_scan_one_pbm() or in something it
>> calls?
>
> I am looking into this now.  Any chance I can get a prtconf dump?

Sent privately.

> This schizo error handler definitely needs to be adjusted.  The
> bus->self value is not necessarily going to be there.  In fact
> often it won't be.
>
> The PCI controller's themselves don't show up in the device tree as
> bonafide PCI devices, so we don't instantiate them with the PCI
> subsystem, and therefore bus->self never takes on a non-NULL value.
>
> If you look at arch/sparc/kernel/psycho_common.c:psycho_pcierr_intr_other()
> it addresses this by doing the PCI config space access by hand, thus
> avoiding the bus->self dereference.
>
> Meanwhile, this patch might allow things to get further:

It seems to work - no crash but this in dmesg, and it continues booting 
fine:

[   69.137735] /pci@9,600000: PCI Error, primary error type[Master Abort]
[   69.144196] /pci@9,600000: bytemask[0003] was_block(0) space(Memory)
[   69.150520] /pci@9,600000: PCI AFAR [00000000004000c0]
[   69.155632] /pci@9,600000: PCI Secondary errors [(none)]
[   69.160984] /pci@9,600000: PCI bus error, PCI_STATUS[22a0]

So at least this instance of the crash is gone. I seem to remember getting 
some crashes later too occassionally, so that I had some first lines of 
the error printed and then crash, but I do not seem to have preserved the 
console logs from them. I will keep an eye open.

Thank you!

-- 
Meelis Roos (mroos@linux.ee)
