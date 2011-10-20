From: David Miller <davem@davemloft.net>
Date: Thu, 20 Oct 2011 22:23:52 +0000
Subject: Re: [PATCH 3/3] sparc32: Correct the return value of memcpy.
Message-Id: <20111020.182352.854418532625087933.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111019.184425.145807140541223467.davem@davemloft.net>
In-Reply-To: <20111019.184425.145807140541223467.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Thu, 20 Oct 2011 23:02:14 +0200 (CEST)

> On Wed, 19 Oct 2011, David Miller wrote:
> 
>> 
>> Properly return the original destination buffer pointer.
>> 
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>>
> 
> Works great on my test systems. Thanks.
> 
> Tested-by: Kjetil Oftedal <oftedal@gmail.com> 

Thanks for testing.
