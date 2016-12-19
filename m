From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 19 Dec 2016 00:22:31 +0000
Subject: Re: [RFC PATCH 04/14] sparc64: load shared id into context register 1
Message-Id: <86a484e6-7b71-383d-b7da-d64b99206fa9@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
 <1481913337-9331-5-git-send-email-mike.kravetz@oracle.com>
 <20161217074512.GC23567@ravnborg.org>
In-Reply-To: <20161217074512.GC23567@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>

On 12/16/2016 11:45 PM, Sam Ravnborg wrote:
> Hi Mike
> 
>> diff --git a/arch/sparc/kernel/fpu_traps.S b/arch/sparc/kernel/fpu_traps.S
>> index 336d275..f85a034 100644
>> --- a/arch/sparc/kernel/fpu_traps.S
>> +++ b/arch/sparc/kernel/fpu_traps.S
>> @@ -73,6 +73,16 @@ do_fpdis:
>>  	ldxa		[%g3] ASI_MMU, %g5
>>  	.previous
>>  
>> +661:	nop
>> +	nop
>> +	.section	.sun4v_2insn_patch, "ax"
>> +	.word		661b
>> +	mov		SECONDARY_CONTEXT_R1, %g3
>> +	ldxa		[%g3] ASI_MMU, %g4
>> +	.previous
>> +	/* Unnecessary on sun4u and pre-Niagara 2 sun4v */
>> +	mov		SECONDARY_CONTEXT, %g3
>> +
>>  	sethi		%hi(sparc64_kern_sec_context), %g2
> 
> You missed the second instruction to patch with here.
> This bug repeats itself further down.
> 
> Just noted while briefly reading the code - did not really follow the code.

Hi Sam,

This is my first sparc assembly code, so I could certainly have this
wrong.  The code I was trying to write has the two nop instructions,
that get patched with the mov and ldxa on sun4v.  Certainly, this is
not elegant.  And, the formatting may lead to some confusion.

Did you perhaps think the mov instruction after the comment was for
patching?  I am just trying to understand your comment.

-- 
Mike Kravetz
