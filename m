From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 06:40:28 +0000
Subject: Re: [PATCH 2/7] sparc32,leon: add support for extended interrupt
Message-Id: <4DAE7FDC.6070109@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-2-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-2-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>Hi Daniel.
>
>A few nits that I missed during the private review.
>
>  
>
>>+#define LEON_IMASK (&leon3_irqctrl_regs->mask[0])
>>+#define LEON_IACK (&leon3_irqctrl_regs->iclear)
>>    
>>
>
>Hiding these behind macros may not make code more obvious.
>But I am not strongly about it.
>  
>
LEON_MASK was defined since before, I only removed a pair of unused 
parenteses and added LEON_IACK in the same spirit. I will leave it the 
way it is, I think it can be cleaned up later.

>  
>
>>+#define LEON_DO_ACK_HW 1
>> 
>>-/* Return the IRQ of the pending IRQ on the extended IRQ controller */
>>-int sparc_leon_eirq_get(int eirq, int cpu)
>>+/* Return the last ACKed IRQ by the Extended IRQ controller. It has already
>>+ * been (automatically) ACKed when the CPU takes the trap.
>>+ */
>>    
>>
>In general - nice to see the improved comments
>
>  
>
>> /* The extended IRQ controller has been found, this function registers it */
>>-void sparc_leon_eirq_register(int eirq)
>>+void leon_eirq_setup(unsigned int eirq)
>> {
>>-	int irq;
>>+	unsigned long mask, oldmask;
>>+	int veirq;
>>    
>>
>
>veirq is used for an unsigned int value later.
>Use "unsigned int" to avoid mixing signed/unsigned.
>  
>
I will fix this and resend the patch.

Thanks,
Daniel
