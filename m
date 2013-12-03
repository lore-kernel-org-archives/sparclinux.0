From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 03 Dec 2013 16:47:00 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <529E0B04.10503@hurleysoftware.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 12/03/2013 11:11 AM, Meelis Roos wrote:
>>>>>> Does the RED state exception trigger if you manually break to the prom
>>>>>> command line and issue a boot command?
>>>>>
>>>>> It seems I can not break from running kernel to PROM by sending break
>>>>> from minicom. PROM itself reacts to my break (during memory test for
>>>>> example) so it's Linux not accepting the break. I seem to remember it
>>>>> having worked some time ago, although not when the kergel hung.
>>>>
>>>> Argghh.
>>>>
>>>> There were some changes to sunsab.c a couple of versions ago; maybe we
>>>> broke it.
>>>>
>>>> Can you confirm BRKs are being received with
>>>> 'sudo cat /proc/tty/driver/serial'
>>>
>>> In 3.12:
>>>
>>> # cat /proc/tty/driver/sunsab
>>> serinfo:1.0 driver revision:
>>> 0: uart:SAB82532 V3.2 mmio:0x1FFF1400000 irq:5 tx:5163 rx:0 CTS|DSR|CD
>>> 1: uart:SAB82532 V3.2 mmio:0x1FFF1400040 irq:5 tx:0 rx:
>>>
>>> cat /proc/sys/kernel/stop-a
>>> 1
>>>
>>> # cat /proc/sys/kernel/reboot-cmd
>>>
>>> (it was empty, so default "boot" should be used AFAIK)
>>
>> Meelis,
>>
>> Would you please re-test trying to break to the PROM with this debug
>> patch?  As with the bootpromfs debug patch, the output is in
>> '/sys/kernel/debug/trace'.
>
> Should I activate tracing somehow?

You did activate tracing. The lack of output means at that point
there is no BRK detected. Can you trigger any sysrq function from
that terminal (assuming CONFIG_SERIAL_SUNSAB_CONSOLE && CONFIG_MAGIC_SYSRQ)?

> I enabled some trace options in the
> kernel and got a bunch of files under /sys/kernel/debug/tracing/ but
> /sys/kernel/debug/tracing/trace show only the header and
> /sys/kernel/debug/tracing/enabled_functions is empty.
> /sys/kernel/debug/tracing/tracing_on is "1" and
> /sys/kernel/debug/tracing/current_tracer is "nop".
>

