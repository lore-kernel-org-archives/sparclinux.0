From: David Miller <davem@davemloft.net>
Date: Fri, 21 Jul 2017 19:11:17 +0000
Subject: Re: [PATCH 1/3] sparc64: recognize and support sparc M8 cpu type
Message-Id: <20170721.201117.714300967324958322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500536437-14589-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen <allen.pais@oracle.com>
Date: Fri, 21 Jul 2017 14:51:59 +0530

> 
> Hi Sam,
> 
>>> +++ b/arch/sparc/kernel/head_64.S
>>> @@ -439,6 +439,9 @@ EXPORT_SYMBOL(sun4v_chip_type)
>>>   	cmp	%g2, '7'
>>>   	be,pt	%xcc, 5f
>>>   	 mov	SUN4V_CHIP_SPARC_M7, %g4
>>> +	cmp	%g2, '8'
>>> +	be,pt	%xcc, 5f
>>> +	 mov	SUN4V_CHIP_SPARC_M8, %g4
>>
>> Could we use this opportunity to create properly named
>> constants for '7', '8', 'N' etc, rather than harcoding these
>> in some assembler files.
>> (Obviously in a separate patch).
> 
> Would this work?

That won't even boot.

You're changing an ASCII character '?' value into a raw
constant.
