From: Meelis Roos <mroos@linux.ee>
Date: Fri, 31 Oct 2014 21:01:09 +0000
Subject: Re: DMA-API warning from sunhme - unchecked dma_map_single error
Message-Id: <alpine.DEB.2.03.1410312258170.17220@cyber.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141031205258.C3A2F7FE2E@ilves.cyber.ee>
In-Reply-To: <20141031205258.C3A2F7FE2E@ilves.cyber.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org

>> It seems to be correct warning - dma_map_single is used unchecked in
>> sunhme.c. I can try fixing it - the error handling will be the only
>> problem. Is it considered worthwile?
>
> Can you test this patch?

It works fine on E3500 where I had many debugging options on and caught 
it. No warnings, network still works.

-- 
Meelis Roos (mroos@linux.ee)
