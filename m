From: David Miller <davem@davemloft.net>
Date: Sun, 05 Oct 2014 23:54:23 +0000
Subject: Re: [PATCH v3 0/9] sparc64: MM/IRQ patch queue.
Message-Id: <20141005.195423.404867166207762669.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141004.192630.315529201590329439.davem@davemloft.net>
In-Reply-To: <20141004.192630.315529201590329439.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Picco <bpicco@meloft.net>
Date: Sun, 5 Oct 2014 14:49:43 -0400

> Remote M7-4 up with spec-jbb and hugepages. Local T4-2 up with DEBUG_PAGEALLOC.
> Remote T5-8 being severely thrashed with several different loads concurrently.
> Local T5-2 was under severe load with THP "always" until my "QuietComfort 3"
> headphones declared magnificent/enough :)
> 
> Seriously, I believe we are in good condition. There will be issues but
> this is always the challenge.
> 
> Should you desire a boot log, please feel free to request. I've consumed 
> nearly all boot logs with scrutiny.
> 
> Acked-by: Bob Picco <bob.picco@oracle.com>

Thanks a lot for testing, I'll push all of this work out.
