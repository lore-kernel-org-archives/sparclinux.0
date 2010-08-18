From: David Miller <davem@davemloft.net>
Date: Wed, 18 Aug 2010 05:48:12 +0000
Subject: Re: 64-bit ppc rwsem
Message-Id: <20100817.224812.226786243.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1282107803.22370.173.camel@pasglop>
	<20100817.222818.193699062.davem@davemloft.net>
	<20100818053955.GA11962@merkur.ravnborg.org>
In-Reply-To: <20100818053955.GA11962@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 18 Aug 2010 07:39:55 +0200

>> @@ -15,7 +15,7 @@ lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
>>  lib-$(CONFIG_SPARC32) += copy_user.o locks.o
>>  lib-y                 += atomic_$(BITS).o
>>  lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
>> -lib-y                 += rwsem_$(BITS).o
>> +lib-$(CONFIG_SPARC32) += rwsem_$(BITS).o
> 
> You could write this explicit as:
> 
>> +lib-$(CONFIG_SPARC32) += rwsem_32.o
> 
> As rwsem_64 is gone now.

Sure, I'll make that change, thanks Sam.
