From: David Miller <davem@davemloft.net>
Date: Thu, 08 May 2014 17:15:17 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140508.131517.882947417059966112.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 8 May 2014 07:30:57 +0300 (EEST)

>> Thanks I'll fix my patch up to build properly with THP off, please
>> test with THP enabled meanwhile.
> 
> All machines are now with THP on and latest git + yesterdays patch:
> 
> V440 still works.
> 
> V100, Netra X1 and Ultra 5 still hang on first/second git clone :(
> 
> So it seems the patch did not fix it yet.

Thanks for testing, oh well, I thought I had found it but perhaps not.

Oh I see, the bug didn't even exist.  In __tsb_context_switch the
address is adjusted properly when the huge TSB mapping is installed in
the TLB.  So there's no bug at all. :-/

Will keep looking, thanks again.
