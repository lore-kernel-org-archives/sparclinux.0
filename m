From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 08 Feb 2011 07:09:38 +0000
Subject: Re: sparc32 linux SMP
Message-Id: <4D50EC32.2050403@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D4C0193.2020900@gaisler.com>
In-Reply-To: <4D4C0193.2020900@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>On Mon, Feb 07, 2011 at 07:26:23PM +0100, Daniel Hellstrom wrote:
>  
>
>>David Miller wrote:
>>
>>    
>>
>>>From: Daniel Hellstrom <daniel@gaisler.com>
>>>Date: Fri, 04 Feb 2011 14:39:31 +0100
>>>
>>> 
>>>
>>>      
>>>
>>>>I just want to report that we have been able to run the SPEC2000
>>>>integer tests successfully on Linux SMP 2.6.38-rc1. After 2-3 days of
>>>>running the tests (users=2) on a dual core LEON@70MHz on Debian Etch,
>>>>the results were correct. Two months ago I was able to run for 1-2
>>>>minutes before the system crashed in different ways or hanged.
>>>>        
>>>>
>
>This is very good news! Then we know a way forward how to fix
>SS1000 / and likel some of the sun4m systems with > 1 processor too.
>
>  
>
>>>>   
>>>>
>>>>        
>>>>
>>>I assume this is with the smp_call_function changes added to your tree,
>>>right?
>>> 
>>>
>>>      
>>>
>>Yes, with the patches I sent to the list. At gaisler.com distribute a  
>>"LEON Linux 2.6.36.3" package with all the patches I used.
>>
>>    
>>
>>>It would be nice to get the sun4m/sun4d bits written so I can integrate
>>>that fix. :-)
>>>      
>>>
>I have added this to my TODO list. But as I do not have any SMP system yet...
>[Working on that]
>
>  
>
>>I agree, it's a pity I'm not so good with sun sparcs. If I find some  
>>free time perhaps I could do an experimental implementation.. free time  
>>has been a rarity lately, so don't expect it to happen... :)
>>    
>>
>If I take a stab on it later at least I hope you find time to review the stuff.
>  
>
Sure, no problemo.

Daniel

