From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Oct 2014 20:20:11 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410162319080.19924@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410150012001.11850@adalberg.ut.ee> <20141014.173246.921084057467310731.davem@davemloft.net> <alpine.LRH.2.11.1410160956090.13273@adalberg.ut.ee> <20141016.160742.1639247937393238792.davem@redhat.com>
In-Reply-To: <20141016.160742.1639247937393238792.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@redhat.com>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> I just reproduced this on my Sun Blade 2500, so it can trigger on UltraSPARC-IIIi
> systems too.

I looked it up - V210 and V440 are also IIIi, not plain III. So I do not 
have information about real USIII, sorry for confusion.

-- 
Meelis Roos (mroos@linux.ee)
