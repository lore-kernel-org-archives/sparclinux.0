From: David Miller <davem@davemloft.net>
Date: Thu, 19 Aug 2010 21:14:46 +0000
Subject: Re: [PATCH] sparc64: simple microoptimizations for atomic functions
Message-Id: <20100819.141446.193698223.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.1008181402450.9287@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 19 Aug 2010 09:42:55 -0400 (EDT)

>>  #define BACKOFF_SETUP(reg)
>> -#define BACKOFF_SPIN(reg, tmp, label) \
>> -	ba,pt	%xcc, label; \
>> -	 nop;
> 
> I'm just curious, is there some good reason to place nop in the delay slot 
> instead of the anul bit? --- i.e. some inefficiency or bugs?

It's definitely slower on pre-Niagara cpus.

> BTW, I found a missing delay slot.

Good catch, I'll apply this, thanks!
