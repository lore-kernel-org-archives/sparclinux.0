From: David Miller <davem@davemloft.net>
Date: Thu, 28 Apr 2016 20:10:58 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160428.161058.711699657514228763.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 28 Apr 2016 21:49:39 +0200

>> diff --git a/arch/sparc/kernel/fpu_traps.S b/arch/sparc/kernel/fpu_traps.S
>> index a686482..336d275 100644
>> --- a/arch/sparc/kernel/fpu_traps.S
>> +++ b/arch/sparc/kernel/fpu_traps.S
>> @@ -100,8 +100,8 @@ do_fpdis:
>>  	fmuld		%f0, %f2, %f26
>>  	faddd		%f0, %f2, %f28
>>  	fmuld		%f0, %f2, %f30
>> -	b,pt		%xcc, fpdis_exit
>> -	 nop
>> +	ba,a,pt		%xcc, fpdis_exit
>> +
> My sparc assembler foo is not good.
> And I could not find any references to "b," branch instructions.
> So I assume the "b," is equivalent to "ba,".
> Which makes this good as the code now uses a documented variant.

In v9, 'b' got changed into 'ba'.  There is no difference except that
with 'ba' you can add the prediction tags like ",pt" and ",pnt".

>>  	add	%g1, 1, %g1
>> -	mov	SUN4V_CHIP_SPARC64X, %g4
>>  	ba,pt	%xcc, 5f
>> -	nop
>> +	 mov	SUN4V_CHIP_SPARC64X, %g4
> 
> Nice..
> Maybe we could have done so in mor places, but I did not spot them.

I tried to find more low hanging fruit, if you do end up spotting some
more let me know. :-)

>> diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
>> index aadd321..7d02b1f 100644
>> --- a/arch/sparc/kernel/vmlinux.lds.S
>> +++ b/arch/sparc/kernel/vmlinux.lds.S
>> @@ -33,6 +33,10 @@ ENTRY(_start)
>>  jiffies = jiffies_64;
>>  #endif
>>  
>> +#ifdef CONFIG_SPARC64
>> +ASSERT((swapper_tsb = 0x0000000000408000), "Error: sparc64 early assembler too large")
>> +#endif
> 
> You did not use:
> . = ASSERT() so older binutils are not supportet.
> This is no problem because my boxes both have newer binutils.
> And the testers that reported back on the mailing list did not
> see any problems either - so I will assume this is OK.

Do you know exactly when plain "ASSERT()" starts working and doesn't
require the ". = " part?

Thanks Sam.
