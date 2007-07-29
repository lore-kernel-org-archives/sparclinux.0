From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 07:55:25 +0000
Subject: Re: [PATCH] v2.6.23-rc1 Sparc32 Serial Port Selection error
Message-Id: <Pine.LNX.4.61.0707290854460.30117@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707290259060.28781@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Sat, 28 Jul 2007, David Miller wrote:

> From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
> Date: Sun, 29 Jul 2007 03:17:39 +0100 (BST)
>
>> The serial console code selection code needs to select the ports the
>> otherway around. The attached patch fixes the problem.
>>
>> --- linux-test/arch/sparc/kernel/prom.c~	2007-07-28 21:02:31.000000000 +0100
>> +++ linux-test/arch/sparc/kernel/prom.c	2007-07-29 02:38:54.000000000 +0100
>> @@ -460,7 +460,7 @@
>>   		strcpy(of_console_path, dp->full_name);
>>   		if (!strcmp(type, "serial")) {
>>   			strcat(of_console_path,
>> -			       (skip ? ":b" : ":a"));
>> +			       (skip ? ":a" : ":b"));
>>   		}
>>   		break;
>
> I don't understand this fix :-)
>
> We set skip to "1" only if *romvec->pv_stdout is PROMDEV_TTYB,
> therefore should definitely use ":b" when it is non-zero, which
> is what the code is doing.
>

Yes but then you do a !skip-- so 0 -> -1 and 1 -> 0


> Perhaps the logic drivers/serial/sunzilog.c or
> drivers/serial/suncore.c is what is reversed instead.
>
>
