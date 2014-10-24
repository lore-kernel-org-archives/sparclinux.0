From: Meelis Roos <mroos@linux.ee>
Date: Fri, 24 Oct 2014 07:49:12 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410241048290.15464@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141022.163949.1761351331649936601.davem@davemloft.net> <alpine.LRH.2.11.1410230221360.28745@adalberg.ut.ee> <20141023.130258.548864295965807596.davem@davemloft.net> <20141023.172258.1371479087269518956.davem@davemloft.net>
In-Reply-To: <20141023.172258.1371479087269518956.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> > I can reproduce and I know what the problem is, fixed patch coming up
> > shortly.
> 
> Ok, please test this patch below.

Thank you, it works fine on my V210, V440 and newly added V245.

-- 
Meelis Roos (mroos@linux.ee)
