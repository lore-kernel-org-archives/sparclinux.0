From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Oct 2014 12:31:56 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410191459210.32417@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20141016.165017.1151349565275102498.davem@davemloft.net> <alpine.LRH.2.11.1410171410210.25429@adalberg.ut.ee> <20141018.135907.356113264227709132.davem@davemloft.net> <20141018.142335.1935310766779155342.davem@davemloft.net>
In-Reply-To: <20141018.142335.1935310766779155342.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> > I don't want to define the array size of the fpregs save area
> > explicitly and thereby placing an artificial limit there.
> 
> Nevermind, it seems we have a hard limit of 7 FPU save areas anyways.
> 
> Meelis, please try this patch:

Works fine with 3.17.0-09670-g0429fbc + fault patch.

Will try current git next to find any new problems :)

-- 
Meelis Roos (mroos@linux.ee)
