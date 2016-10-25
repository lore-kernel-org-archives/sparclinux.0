From: David Miller <davem@davemloft.net>
Date: Tue, 25 Oct 2016 19:07:56 +0000
Subject: Re: [PATCH 09/11] sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.
Message-Id: <20161025.150756.369977868336191997.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.110228.1744774836277392991.davem@davemloft.net>
In-Reply-To: <20161025.110228.1744774836277392991.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 25 Oct 2016 20:39:40 +0200

> One small comment below.
 ...
>> @@ -22,21 +23,17 @@
>>  #endif
>>  
>>  #ifndef EX_LD
>> -#define EX_LD(x)	x
>> +#define EX_LD(x,y)	x
> 
> The above line will result in following assembelr code fragment:
> .word 98b, ;           \
>           ^
>           empty
> Maybe this is just fine - but it looks wrong.
> Same goes for other uses of related macros.

It's a macro definition which just emits the first argument
when actually used.

Can you explain in more detail what you think happens?
