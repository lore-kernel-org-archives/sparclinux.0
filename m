From: David Miller <davem@davemloft.net>
Date: Sun, 24 Aug 2014 06:43:11 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <20140823.234311.1275789071613181968.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Sun, 24 Aug 2014 11:49:29 +0530

> David,
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
>> 
> 
>  When we are on this topic, here's a patch that attempts to simplify 
> cpu detection. 
> 
> Here's a quick diff.

You can't call C code until you've cleared the BSS, you can't clear
the BSS until you hook up the proper optimized routines, you can't
hook up the proper optimized routined until you know the cpu type.

I would have done this years ago otherwise.
