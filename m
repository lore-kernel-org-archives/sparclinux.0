From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 05 Jan 2011 08:58:11 +0000
Subject: Re: [RFC 1/8] sparc: prom: Sanitize return value from prom_nbputchar()
Message-Id: <4D2432A3.307@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BBC6.3080809@julian.is-a-geek.org>
In-Reply-To: <4CF9BBC6.3080809@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Julian Calaby wrote:

>On Wed, Jan 5, 2011 at 04:50, David Miller <davem@davemloft.net> wrote:
>  
>
>>From: Daniel Hellstrom <daniel@gaisler.com>
>>Date: Tue, 04 Jan 2011 15:42:45 +0100
>>
>>    
>>
>>>David Miller wrote:
>>>
>>>      
>>>
>>>>From: Julian Calaby <jcalaby@julian.is-a-geek.org>
>>>>Date: Sat, 04 Dec 2010 14:55:50 +1100
>>>>
>>>>
>>>>        
>>>>
>>>>>Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>>>>>
>>>>>          
>>>>>
>>>>Applied.
>>>>
>>>>        
>>>>
>>>I think this patch breaks the backwards compatability...
>>>      
>>>
>>Backwards compatability for who?  There is one and only one caller
>>of this function, and it is marked static and not exported to any
>>other piece of code in the tree.
>>    
>>
With this patch we need to have two different versions of the PROM 
emulation implementation, it is a bit sad that it will not work for both 
versions of the linux kernel 2.6.36 and 2.6.37, that's all.

I'm probably out of line here, I havn't read the PROMv0 specification, 
the old linux implementation was perhaps faulty all along and we made 
our PROM code looking at it rather than the PROMv0 spec.

My impression was that pv_nbputchar() in PROM has to be implemented as 
non-blocking in order to avoid taking the prom_lock too long, in order 
to do that in a linux 2.6.36 kernel the PROM has to return -1 from 
pv_nbputchar() when the UART is busy and a 1 when pv_nbputchar() 
actually sends a character. However with this patch the pv_nbputchar() 
must return a 0 when UART is busy, this means that backwards compability 
to the PROM emultation software is lost.

>
>The other point is that sparc64's version works like this, so why
>should sparc32's version be different?
>  
>
Good point. Havn't looked at the SPARC64 code. Probably we should have 
submitted a patch for the old bad behaviour before.

We can live with two different versions of the PROM... there are more 
important things in life :)

Thank you,
Daniel

