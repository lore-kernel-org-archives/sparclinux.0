From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Apr 2011 18:15:42 +0000
Subject: Re: [PATCH 2/3] sparc32: cleanup code for irq init
Message-Id: <20110419181542.GA20033@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303161944-13611-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303161944-13611-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> -
>> +#else
>> +extern int pcic_present(void) { return 0; }
>>  
>>
> typo, it should be static inline int pcic_preset... will not compile  
> otherwise.

Obviously not testet without PCI defined.
>
>> +static inline int pcic_probe(void) { return 0; }
>> +static inline void sun4m_pci_init_IRQ(void) {}
>> +#endif
>> #endif
>>
>> /* Size of PCI I/O space which we relocate. */
>> diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
>> index 7c93df4..b2dbb4b 100644
>> --- a/arch/sparc/kernel/irq_32.c
>> +++ b/arch/sparc/kernel/irq_32.c
>> @@ -607,14 +607,11 @@ void __init init_IRQ(void)
>> 		break;
>>
>> 	case sun4m:
>> -#ifdef CONFIG_PCI
>> 		pcic_probe();
>> -		if (pcic_present()) {
>> +		if (pcic_present())
>> 			sun4m_pci_init_IRQ();
>> -			break;
>> -		}
>> -#endif
>> -		sun4m_init_IRQ();
>> +		else
>> +			sun4m_init_IRQ();
>> 		break;
>>
>> 	case sun4d:
>>  
>>
> Similarily you can add "static inline void pci_time_init(void) {};" and  
> remove the CONFIG_PCI in time_32.c?

Yes - will do so.

Thanks.
	Sam
