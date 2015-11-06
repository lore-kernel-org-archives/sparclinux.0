From: David Miller <davem@davemloft.net>
Date: Fri, 06 Nov 2015 05:14:29 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20151106.001429.2110589196408149028.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20151105.163959.1438115257720770769.davem@davemloft.net>
	<CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
In-Reply-To: <CA+55aFwvFvsZuiURSfKuP85tcQgNUwj+bXdL9smZgMV8c++1EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2015 16:43:52 -0800

> On Thu, Nov 5, 2015 at 1:39 PM, David Miller <davem@davemloft.net> wrote:
>>
>> 5) Fix iommu-common code so it doesn't emit rediculous warnings
>>    on some architectures, particularly ARM.
> 
> Heh. So looking at that patch, I can't but help to react that this:
> 
>   #define IOMMU_ERROR_CODE       (~(unsigned long) 0)
> 
> is still pretty ridiculous.  Maybe just (-1ul), or for those people
> who don't understand C unsigned long arithmetic and think that a
> negative unsigned long looks odd, (~0ul)?

Yeah I struggled with this, believe it or not.

The expression causing the problem was (~(dma_addr_t) 0) (AKA
DMA_ERROR_CODE) being used as the return value.

So I just replicated that expression.  A neuron did fire saying "hey
pinhead, why not just use ~0UL" but I did not listen to the little
voice in my head this time.
