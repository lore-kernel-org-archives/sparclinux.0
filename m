From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 28 Apr 2016 22:54:29 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <572294A5.50201@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/28/2016 02:10 PM, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Thu, 28 Apr 2016 21:49:39 +0200
>
>>> diff --git a/arch/sparc/kernel/fpu_traps.S b/arch/sparc/kernel/fpu_traps.S
>>> index a686482..336d275 100644
>>> --- a/arch/sparc/kernel/fpu_traps.S
>>> +++ b/arch/sparc/kernel/fpu_traps.S
>>> @@ -100,8 +100,8 @@ do_fpdis:
>>>   	fmuld		%f0, %f2, %f26
>>>   	faddd		%f0, %f2, %f28
>>>   	fmuld		%f0, %f2, %f30
>>> -	b,pt		%xcc, fpdis_exit
>>> -	 nop
>>> +	ba,a,pt		%xcc, fpdis_exit
>>> +
>> My sparc assembler foo is not good.
>> And I could not find any references to "b," branch instructions.
>> So I assume the "b," is equivalent to "ba,".
>> Which makes this good as the code now uses a documented variant.
> In v9, 'b' got changed into 'ba'.  There is no difference except that
> with 'ba' you can add the prediction tags like ",pt" and ",pnt".
>
>>>   	add	%g1, 1, %g1
>>> -	mov	SUN4V_CHIP_SPARC64X, %g4
>>>   	ba,pt	%xcc, 5f
>>> -	nop
>>> +	 mov	SUN4V_CHIP_SPARC64X, %g4
>> Nice..
>> Maybe we could have done so in mor places, but I did not spot them.
> I tried to find more low hanging fruit, if you do end up spotting some
> more let me know. :-)
>


It's good to free up a few bytes here and there, but I think we're going 
to need to go further than this in the near future since code in this 
tiny region between 404000 and 0x408000 is going to grow. For example, 
code to check for new cpu chips is always being added. Also, new code 
such as Khalid's ADI patch adds a new exception handler for memory 
corruption detection.

Having run into this problem myself, I tried to understand why all this 
code needed to be squeezed into this small area, and as best I could 
determine, it was just an attempt to not "waste" the space. So why 
couldn't some of the code be moved to the region after the trap table? 
As long as code in the trap table can reach (in the branch displacement 
sense) all the code it needs to, is there any problem with moving 
things? For instance, there is a list of includes beginning with  
"etrap_64.S", and one or more of those can be moved to after the include 
"ttable_64.S", which will free up a chunk of space immediately.

Rob Gardner

