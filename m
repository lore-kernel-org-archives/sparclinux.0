From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Oct 2010 07:14:29 +0000
Subject: Re: [PATCH 3/3] sparc32: fix build failure on CONFIG_SPARC_LEON
Message-Id: <4CC67FD5.4080101@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1288021958-3130-3-git-send-email-namhyung@gmail.com> <20101025.090043.71110898.davem@davemloft.net> <20101025161122.GA25358@merkur.ravnborg.org> <20101025.115331.193708760.davem@davemloft.net> <20101025194155.GA26282@merkur.ravnborg.org>
In-Reply-To: <20101025194155.GA26282@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, namhyung@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Sam Ravnborg wrote:

>On Mon, Oct 25, 2010 at 11:53:31AM -0700, David Miller wrote:
>  
>
>>From: Sam Ravnborg <sam@ravnborg.org>
>>Date: Mon, 25 Oct 2010 18:11:22 +0200
>>
>>    
>>
>>>On Mon, Oct 25, 2010 at 09:00:43AM -0700, David Miller wrote:
>>>      
>>>
>>>>From: Namhyung Kim <namhyung@gmail.com>
>>>>Date: Tue, 26 Oct 2010 00:52:38 +0900
>>>>
>>>>        
>>>>
>>>>>  CC      arch/sparc/kernel/irq_32.o
>>>>>arch/sparc/kernel/irq_32.c: In function 'request_fast_irq':
>>>>>arch/sparc/kernel/irq_32.c:370:25: error: conflicting types for 'trapbase_cpu1'
>>>>>          
>>>>>
>>>>I doubt SMP LEON chips even exist, so better to just anti-dep
>>>>this in arch/sparc/Kconfig
>>>>        
>>>>
>>>I have a nice eval board at my desk with a dual-core LEON4 processor.
>>>I only lack time to play with it...
>>>      
>>>
>>Ok.  But whenever someone gets a time to play with it and
>>verify it works, we can sort out this build failure by
>>modifying the code as needed.
>>
>>But for now I prefer the Kconfig SMP dependency fix.
>>    
>>
>
>Yup - I agree.
>My only intention was to tell that such a processor exists in reality
>and not only on paper.
>
I stumbled into the same problem last weeks, enabling "Normal floppy 
disk support" (BLK_DEV_FD) on the LEON makes this error appear. There is 
no hardware for "Normal floppy disk support" on a LEON.

Regards,
Daniel Hellstrom

