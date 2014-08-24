From: David Miller <davem@davemloft.net>
Date: Sun, 24 Aug 2014 06:18:25 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <20140823.231825.587583919202204950.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Sun, 24 Aug 2014 11:37:09 +0530

>> 
>> I don't think this is correct.
>> 
>>> @@ -414,6 +414,8 @@ sun4v_chip_type:
>>>  	cmp	%g2, 'T'
>>>  	be,pt	%xcc, 70f
>>>  	 cmp	%g2, 'M'
>>> +	be,pt	%xcc, 71f
>>> +	 nop
>>>  	bne,pn	%xcc, 49f
>>>  	 nop
>> 
>> This code block is supposed to fallthrough when %g2 is 'M' so that
>> we accept all of "{T,M}345..." but your change is breaking that
>> such that we will now only accept "M" as a prefix for "7".
>> 
>> That's a regression.
>> 
>> All you have to do is add the new comparison against '7' in the
>> "70:" label code block, and you're done.
> 
>  The idea was to also have M5 and M6-32 cpu types supported too with M7. 
> 
> +71:
> +	ldub	[%g1 + 7], %g2
> +	cmp	%g1, '5'
> +	be,pt	%xcc, 5f
> +	 mov	SUN4V_CHIP_SPARC_M5, %g4
> +	cmp	%g1, '6'
> +	be,pt	%xcc, 5f
> +	 mov	SUN4V_CHIP_SPARC_M6, %g4
> +       cmp     %g2, '7'
> +       be,pt   %xcc, 5f
> +        mov    SUN4V_CHIP_SPARC_M7, %g4
> +       ba,pt   %xcc, 49f
> +        nop
> +

Again, why are you bothing with a special code path at all?  You don't
need to.

Just add the M7 test to the "70:" label code block, and you're done.
