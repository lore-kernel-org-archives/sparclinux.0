From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 22 Jul 2020 02:56:21 +0000
Subject: Re: [PATCH] SPARC: backoff.h: delete a duplicated word
Message-Id: <f397992d-f2e8-76aa-79c9-158350914369@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200721210033.15408-1-rdunlap@infradead.org>
 <20200721.182248.277146641003054082.davem@davemloft.net>
In-Reply-To: <20200721.182248.277146641003054082.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 7/21/20 6:22 PM, David Miller wrote:

>> @David:
>> In arch/sparc/include/asm/cpu_type.h, line 12,
>> is that duplicated "ploos" correct?
>>   sun4u       = 0x03, /* V8 ploos ploos */
> 
> Yes, it's a funny way of saying "++" :-)

I see. Thanks for the explanation.

-- 
~Randy
