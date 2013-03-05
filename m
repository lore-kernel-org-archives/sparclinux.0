From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 05 Mar 2013 15:51:29 +0000
Subject: Re: [PATCH v3] sparc,leon: support for GRPCI1 PCI host bridge controller
Message-Id: <51361481.2090108@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1362392724-27005-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1362392724-27005-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/04/2013 09:47 PM, Sam Ravnborg wrote:
> On Mon, Mar 04, 2013 at 11:25:24AM +0100, Daniel Hellstrom wrote:
>> Some of the GRPCI1 cores does not support detection of all PCI
>> errors, the default is therefore limited PCI error handling.
>> The property all_pci_errors my be set by the boot loader to
>> enable interrupt on all PCI errors.
>>
>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>> ---
>>   arch/sparc/Kconfig                  |   11 +
>>   arch/sparc/kernel/Makefile          |    1 +
>>   arch/sparc/kernel/leon_pci_grpci1.c |  724 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 736 insertions(+), 0 deletions(-)
>>   create mode 100644 arch/sparc/kernel/leon_pci_grpci1.c
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 9bff3db..9aa2cb8 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -500,6 +500,17 @@ config LEON_PCI
>>   	depends on PCI && SPARC_LEON
>>   	default y
>>   
>> +config SPARC32_GRPCI1
>> +	bool "GRPCI Host Bridge Support"
>> +	depends on LEON_PCI
>> +	default y
>> +	help
>> +	  Say Y here to include the GRPCI Host Bridge Driver. The GRPCI
>> +	  PCI host controller is typically found in GRLIB SPARC32/LEON
>> +	  systems. The driver has one property (all_pci_errors) controlled
>> +	  from the bootloader that makes the GRPCI to generate interrupts
>> +	  on detected PCI Parity and System errors.
>> +
> Please - use SPARC_ prefix.
> All arch specific symbols shall have the ARCH_ prefix.
> In the x86 world we do: X86_32_ for the 32 bit specific symbols.
>
> I know someone(*) added a SPARC32_SMP - but thats not a good example to follow.
>
> (*) Yeah - that was me. I got wiser now.
>
> 	Sam

Sam and Dave, sorry for messing up this simple stuff. I simply did a typo. I appreciate your time and effort regarding this. I will update the two last patches shortly using SPARC_* instead.

Daniel

