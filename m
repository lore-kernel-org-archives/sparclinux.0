From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 27 Sep 2017 20:29:30 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Use lzcnt instruction for fls and __fls
Message-Id: <029daf33-40f3-97be-e9f5-3fb0a48f3be5@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1506540326-9604-1-git-send-email-vijay.ac.kumar@oracle.com>
 <1506540326-9604-3-git-send-email-vijay.ac.kumar@oracle.com>
 <20170927195637.GB15193@ravnborg.org>
In-Reply-To: <20170927195637.GB15193@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, babu.moger@oracle.com, rob.gardner@oracle.com

Hi Sam,

On 9/27/2017 2:56 PM, Sam Ravnborg wrote:
>>   	.size	niagara4_patch_pageops,.-niagara4_patch_pageops
>> +
>> +	.globl	niagara4_patch_fls
>> +	.type	niagara4_patch_fls,#function
>> +niagara4_patch_fls:
>> +	NG_DO_PATCH(fls, NG4fls)
>> +	NG_DO_PATCH(__fls, __NG4fls)
>> +	retl
>> +	 nop
>> +	.size	niagara4_patch_fls,.-niagara4_patch_fls
> Please path the remaining functions in this file with ENTRY(), ENDPROC() - in a separate patch.

Thanks for your comment. Sure, I will make the changes and address other 
comments as well in my revised version.

- Vijay
