From: Peter Hurley <peter@hurleysoftware.com>
Date: Fri, 06 Dec 2013 15:54:24 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <52A1F330.5020800@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/04/2013 10:35 AM, Meelis Roos wrote:
>>>>>> There were some changes to sunsab.c a couple of versions ago; maybe we
>>>>>> broke it.
>>>>>>
>>>>>> Can you confirm BRKs are being received with
>>>>>> 'sudo cat /proc/tty/driver/serial'
>>>>>
>>>>> In 3.12:
>>>>>
>>>>> # cat /proc/tty/driver/sunsab
>>>>> serinfo:1.0 driver revision:
>>>>> 0: uart:SAB82532 V3.2 mmio:0x1FFF1400000 irq:5 tx:5163 rx:0 CTS|DSR|CD
>>>>> 1: uart:SAB82532 V3.2 mmio:0x1FFF1400040 irq:5 tx:0 rx:
>>>>>
>>>>> cat /proc/sys/kernel/stop-a
>>>>> 1
>>>>>
>>>>> # cat /proc/sys/kernel/reboot-cmd
>>>>>
>>>>> (it was empty, so default "boot" should be used AFAIK)
>>>>
>>>> Meelis,
>>>>
>>>> Would you please re-test trying to break to the PROM with this debug
>>>> patch?  As with the bootpromfs debug patch, the output is in
>>>> '/sys/kernel/debug/trace'.
>>>
>>> Should I activate tracing somehow?
>>
>> You did activate tracing. The lack of output means at that point
>> there is no BRK detected. Can you trigger any sysrq function from
>> that terminal (assuming CONFIG_SERIAL_SUNSAB_CONSOLE && CONFIG_MAGIC_SYSRQ)?
>
> I can not trigger SysRq by sending a break and then immediately s (or t
> also tested). Nothing in trace. Magic SysRq is 0x1 like default in
> kernel conf. This in on the SUNSAB Ultra5 machine.

That's what I thought: just wanted to validate.

Not sure why no BRK is detected (isr1 & ISR1_BRK = 0). Maybe there is
an early-out that is ignoring BRK condition. Or the sunsab driver is not
reading/interpreting the correct register/bits.

You could instrument the irq handler, sunsab_interrupt(), with trace_printk()
to see if BRK is ever detected.

> E3500 with zs serial console has working break but I do now know how to
> send SysRq there - Break drops me to prom prompt, I can "go" there but
> anything after that is inteprreted as normal input.

I'm not sure how BRK is intended to be used for both the PROM console
and SysRq on a serial console. If you temporarily disable the PROM console,
the SysRq should work by typing a SysRq command char after sending a break.

[ FWIW, Minicom's break function sends a lot of BRKs because it's designed
to trigger a modem interrupt. AFAIK there isn't a 'single-char length
break' supported by minicom. ]

> How shoyukd SysRq
> over verial console work - have not used it before?

The first input after a BRK is interpreted as a SysRq command (within 5 secs).

Regards,
Peter Hurley
