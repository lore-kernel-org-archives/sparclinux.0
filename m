From: =?ISO-8859-15?Q?S=E9bastien_Bernard?= <seb@sfrdev.fr>
Date: Wed, 09 Sep 2009 15:47:09 +0000
Subject: Re: Sparc release requalification
Message-Id: <4AA7CDFD.6070802@sfrdev.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

David Miller a =E9crit :
> From: S=E9bastien Bernard <seb@sfrdev.fr>
> Date: Mon, 07 Sep 2009 18:53:15 +0200
>
>  =20
>> David Miller a =E9crit :
>>    =20
>>> [great explanation snipped]
>>> --- a/arch/sparc/kernel/nmi.c
>>> +++ b/arch/sparc/kernel/nmi.c
>>> @@ -103,7 +103,7 @@ notrace __kprobes void perfctr_irq(int irq, struct
>>> pt_regs *regs)
>>>  	}
>>>  	if (!touched && __get_cpu_var(last_irq_sum) =3D sum) {
>>>  		local_inc(&__get_cpu_var(alert_counter));
>>> -		if (local_read(&__get_cpu_var(alert_counter)) =3D 5 * nmi_hz)
>>> + if (local_read(&__get_cpu_var(alert_counter)) =3D 30 * nmi_hz)
>>>  			die_nmi("BUG: NMI Watchdog detected LOCKUP",
>>>  				regs, panic_on_timeout);
>>>  	} else {
>>>  =20
>>>      =20
>> Hum, I tested today, and no, it does not solve the problem. Kernel is
>> still hanging at the same place.
>> I'll get the initcall debug back when I'll have rebuild a kernel
>> withtou the config_prom_console.
>>    =20
>
> Then what bug are you talking about?
>
> You stated that disabling the NMI watchdog completely solves your
> problem right?  That's why I mentioned the above patch to you?
>  =20
My mistake, I didn't look the log hard enough.
I rebuild a new kernel (2.6.31-rc9) with no patch and there was no hang.
It passes the nmi_setup but crashes further when mounting the root=20
partition.
I'll send the complete logs further.
The funny part is that booting with debug_initcalls=3D1 makes the kernel=20
hangs.

Seb
