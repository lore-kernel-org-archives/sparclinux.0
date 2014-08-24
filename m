From: Allen Pais <allen.pais@oracle.com>
Date: Sun, 24 Aug 2014 06:43:38 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <53F986CA.9050000@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,
>>  The idea was to also have M5 and M6-32 cpu types supported too with M7. 
>>
>> +71:
>> +	ldub	[%g1 + 7], %g2
>> +	cmp	%g1, '5'
>> +	be,pt	%xcc, 5f
>> +	 mov	SUN4V_CHIP_SPARC_M5, %g4
>> +	cmp	%g1, '6'
>> +	be,pt	%xcc, 5f
>> +	 mov	SUN4V_CHIP_SPARC_M6, %g4
>> +       cmp     %g2, '7'
>> +       be,pt   %xcc, 5f
>> +        mov    SUN4V_CHIP_SPARC_M7, %g4
>> +       ba,pt   %xcc, 49f
>> +        nop
>> +
> 
> Again, why are you bothing with a special code path at all?  You don't
> need to.
> 
> Just add the M7 test to the "70:" label code block, and you're done.
> 

 I was a little confused when you initially mentioned about using "70:" label
code block, now I see the point. I'll re-do the patch and test it.

- Allen
