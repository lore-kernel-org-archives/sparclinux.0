From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Thu, 21 Aug 2014 12:29:36 +0000
Subject: Re: [PATCH 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <53F5E630.6050700@oldelvet.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 21/08/2014 13:14, Sam Ravnborg wrote:
> On Thu, Aug 21, 2014 at 03:33:27PM +0530, Allen Pais wrote:
>>
>>>> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
>>>> index 452f04f..508a542 100644
>>>> --- a/arch/sparc/kernel/head_64.S
>>>> +++ b/arch/sparc/kernel/head_64.S
>>>> @@ -414,6 +414,7 @@ sun4v_chip_type:
>>>>   	cmp	%g2, 'T'
>>>>   	be,pt	%xcc, 70f
>>>>   	 cmp	%g2, 'M'
>>>> +	be,pt	%xcc, 71f
>>>>   	bne,pn	%xcc, 49f
>>> Looks like you are missing a nop in the delay slot?
>>
>>    I don't think so. I have tested the patch on M7 and I have had no issues with it.
> Even if it works as expected then it is confusing.
> I read the code like this:
>
> if xcc equals pt then jump to 71 but if pn is not equal to xcc then jump to 49
>
> Maybe the second opcode is ignored because it is a conditional jump or maybe
> they are always equal.
The two branches are the logical opposite of each other so only one is 
ever taken and that is why the code "works".

> But whatever it is confusing.
>
> Adding an extra nop would help the readability.
>
Agreed. This isn't performance sensitive code.

Regards

Richard

P.S. Historical note - SPARC V8 didn't define what happens in the above 
case as noted on page 77 of the SPARC v9 manual)

"V8 Compatibility Note:
SPARC-V8 left as undefined the result of executing a delayed conditional 
branch that had a delayed control transfer in its delay slot. For this 
reason, programmers should avoid such constructs when
backwards compatibility is an issue."
