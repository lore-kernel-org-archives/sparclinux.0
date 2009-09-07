From: David Miller <davem@davemloft.net>
Date: Mon, 07 Sep 2009 23:50:04 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090907.165004.100990076.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: S=E9bastien Bernard <seb@sfrdev.fr>
Date: Mon, 07 Sep 2009 18:53:15 +0200

> David Miller a =E9crit :
>> [great explanation snipped]
>> --- a/arch/sparc/kernel/nmi.c
>> +++ b/arch/sparc/kernel/nmi.c
>> @@ -103,7 +103,7 @@ notrace __kprobes void perfctr_irq(int irq, struct
>> pt_regs *regs)
>>  	}
>>  	if (!touched && __get_cpu_var(last_irq_sum) =3D sum) {
>>  		local_inc(&__get_cpu_var(alert_counter));
>> -		if (local_read(&__get_cpu_var(alert_counter)) =3D 5 * nmi_hz)
>> + if (local_read(&__get_cpu_var(alert_counter)) =3D 30 * nmi_hz)
>>  			die_nmi("BUG: NMI Watchdog detected LOCKUP",
>>  				regs, panic_on_timeout);
>>  	} else {
>>  =20
>=20
> Hum, I tested today, and no, it does not solve the problem. Kernel is
> still hanging at the same place.
> I'll get the initcall debug back when I'll have rebuild a kernel
> withtou the config_prom_console.

Then what bug are you talking about?

You stated that disabling the NMI watchdog completely solves your
problem right?  That's why I mentioned the above patch to you?
