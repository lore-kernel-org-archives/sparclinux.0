From: David Miller <davem@davemloft.net>
Date: Thu, 21 Jan 2016 18:56:50 +0000
Subject: Re: Minor tweak to silo regarding GPT labeled drives
Message-Id: <20160121.105650.2068471743883736942.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <569D2C3E.5060608@oracle.com>
In-Reply-To: <569D2C3E.5060608@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 21 Jan 2016 15:52:29 +0300

> On Thu, Jan 21, 2016 at 3:11 AM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> Next, compiled with gpt-patch, and applied another patch from oracle linux on
>> sparc silo.src.rpm package
>> (http://yum.oracle.com/repo/linux_sparc64/latest//silo-1.4.14-4.0.18.el6.src.rpm),
>> called silo-1.4.14-timer-timeout.patch
>>
>> diff --git a/second/timer.c b/second/timer.c
>> index 7f03996..b559f93 100644
>> --- a/second/timer.c
>> +++ b/second/timer.c
>> @@ -145,7 +145,7 @@ static inline int sun4u_init_timer ()
>>             prom_getstring(node, "device_type", node_str, sizeof(node_str));
>>              if (!strcmp(node_str, "cpu")) {
>>                  foundcpu = 1;
>> -                clock_frequency = prom_getintdefault(node, "clock-frequency", 0) / 100;
>> +                clock_frequency = (unsigned int) prom_getintdefault(node, "clock-frequency", 0) / 100;
>>              }
>>          }
>>          if (notimer) {
>> @@ -155,7 +155,7 @@ static inline int sun4u_init_timer ()
>>          }
>>      }
>>      if (!foundcpu || !clock_frequency)
>> -        clock_frequency = prom_getint(prom_root_node, "clock-frequency") / 100;
>> +        clock_frequency = (unsigned int) prom_getint(prom_root_node, "clock-frequency") / 100;
>>      if (notimer && !sun4v_cpu) {
>>          sun4u_notimer = 1;
>>          __asm__ __volatile__ ("\t"
> 
> found an owner of this patch in silo.spec changelog, quote:
> 
> * Fri Aug 30 2013 Nikita Gerasimov <nikita.gerasimov@oracle.com> 1.4.14-4.0.14
> - silo.conf timeout property does not work due to overflow. Basically
>   the CPU is so fast now that it overslows the signed 32bit value.
>   I guess at some point it'll be even faster and we'll have to promte
>   prom_getintdefault() to returning an unsigned double int.
> 
> So we need to make Nikita Gerasimov <nikita.gerasimov@oracle.com> as
> Signed-off-by as well.

And maybe we can ask them how to get access to this amazing "unsigned
double int" type.  I'd like to start using it too.
