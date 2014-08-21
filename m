From: Allen Pais <allen.pais@oracle.com>
Date: Thu, 21 Aug 2014 10:15:27 +0000
Subject: Re: [PATCH 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <53F5C3EF.1040607@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408424013-20390-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
>> index 452f04f..508a542 100644
>> --- a/arch/sparc/kernel/head_64.S
>> +++ b/arch/sparc/kernel/head_64.S
>> @@ -414,6 +414,7 @@ sun4v_chip_type:
>>  	cmp	%g2, 'T'
>>  	be,pt	%xcc, 70f
>>  	 cmp	%g2, 'M'
>> +	be,pt	%xcc, 71f
>>  	bne,pn	%xcc, 49f
> Looks like you are missing a nop in the delay slot?

  I don't think so. I have tested the patch on M7 and I have had no issues with it.

- Allen

