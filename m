From: David Miller <davem@davemloft.net>
Date: Sat, 01 Nov 2014 04:28:16 +0000
Subject: Re: NULL dereference in schizo error handler
Message-Id: <20141101.002816.1774392257560364558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410260022340.19758@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 31 Oct 2014 23:03:28 +0200 (EET)

>> This schizo error handler definitely needs to be adjusted.  The
>> bus->self value is not necessarily going to be there.  In fact
>> often it won't be.
>>
>> The PCI controller's themselves don't show up in the device tree as
>> bonafide PCI devices, so we don't instantiate them with the PCI
>> subsystem, and therefore bus->self never takes on a non-NULL value.
>>
>> If you look at
>> arch/sparc/kernel/psycho_common.c:psycho_pcierr_intr_other()
>> it addresses this by doing the PCI config space access by hand, thus
>> avoiding the bus->self dereference.
>>
>> Meanwhile, this patch might allow things to get further:
> 
> It seems to work - no crash but this in dmesg, and it continues
> booting fine:

Thanks for testing, I'll push this upstream and to -stable.

> [ 69.137735] /pci@9,600000: PCI Error, primary error type[Master
> Abort]
> [ 69.144196] /pci@9,600000: bytemask[0003] was_block(0) space(Memory)
> [   69.150520] /pci@9,600000: PCI AFAR [00000000004000c0]
> [   69.155632] /pci@9,600000: PCI Secondary errors [(none)]
> [   69.160984] /pci@9,600000: PCI bus error, PCI_STATUS[22a0]

Ok, the PCI status register has these bits set:

	PCI_STATUS_REC_MASTER_ABORT
	PCI_STATUS_DEVSEL_MEDIUM
	PCI_STATUS_FAST_BACK
	PCI_STATUS_66MHZ

The only error condition is that it received a master abort.

I wonder if this happend during firmware init or something before
Linux even booted.

I'll see if there is some way we can track down if there is something
specific that Linux is doing at this moment that might have triggered
this.
