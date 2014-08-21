From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 21 Aug 2014 13:52:37 +0000
Subject: Re: [PATCH 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <53F5F993.4010506@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam, Richard,
>>>>> @@ -414,6 +414,7 @@ sun4v_chip_type:
>>>>>       cmp    %g2, 'T'
>>>>>       be,pt    %xcc, 70f
>>>>>        cmp    %g2, 'M'
>>>>> +    be,pt    %xcc, 71f
>>>>>       bne,pn    %xcc, 49f
>>>> Looks like you are missing a nop in the delay slot?
>>>
>>>    I don't think so. I have tested the patch on M7 and I have had no issues with it.
>> Even if it works as expected then it is confusing.
>> I read the code like this:
>>
>> if xcc equals pt then jump to 71 but if pn is not equal to xcc then jump to 49
>>
>> Maybe the second opcode is ignored because it is a conditional jump or maybe
>> they are always equal.
> The two branches are the logical opposite of each other so only one is ever taken and that is why the code "works".

  I'll go ahead and add the delay slot for better readability. It'll look something like this,

	 cmp	%g2, 'T'
 	be,pt	%xcc, 70f
 	 cmp	%g2, 'M'
+	be,pt	%xcc, 71f
+ 	 nop
 	bne,pn	%xcc, 49f
 	 nop

- ALlen
