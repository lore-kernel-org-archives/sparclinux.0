From: David Miller <davem@davemloft.net>
Date: Sat, 08 Oct 2011 19:22:51 +0000
Subject: Re: longjmp question
Message-Id: <20111008.152251.756339360111106440.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111007232209.GA11892@wooyd.org>
In-Reply-To: <20111007232209.GA11892@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 8 Oct 2011 13:55:35 +0100

> On Sat, Oct 08, 2011 at 02:43:55AM -0400, David Miller wrote:
>> @@ -67,15 +67,13 @@ LOC(thread):
>>  #ifdef PTR_DEMANGLE
>>  	ld	ENV(g1,JB_PC), %g5 /* Set return PC. */
>>  	ld	ENV(g1,JB_SP), %g1 /* Set saved SP on restore below. */
>> -	PTR_DEMANGLE2 (%o7, %g5, %g4)
>> +	PTR_DEMANGLE2 (%i7, %g5, %g4)
>>  	PTR_DEMANGLE2 (%fp, %g1, %g4)
>>  #else
>> -	ld	ENV(g1,JB_PC), %o7 /* Set return PC. */
>> +	ld	ENV(g1,JB_PC), %i7 /* Set return PC. */
>>  	ld	ENV(g1,JB_SP), %fp /* Set saved SP on restore below. */
>>  #endif
>> -	sub	%fp, 64, %sp	/* Allocate a register frame. */
>> -	st	%g3, RW_FP	/* Set saved FP on restore below. */
>> -	retl
>> +	jmp	%i7 + 8
>>  	 restore %g2, 0, %o0	/* Restore values from above register frame. */
> 
> I don't really see anything in the code which would ensure that after 
> we execute this restore, fp is going to be set to target fp value 
> (available as ENV(g1,JB_FP) or g3. It might be the responsibility of 
> the unwinding part, but then it would not explain why such code was 
> explicitly present in the old version.

Because the restore traps, causing a window fill, and that trap
handler will load up the register window at JB_SP, inside of which
JB_FP is contained.

The only reason we store JB_FP is for the implementation the optimized
longjmp loop.
