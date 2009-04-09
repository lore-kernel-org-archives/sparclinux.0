From: Tejun Heo <tj@kernel.org>
Date: Thu, 09 Apr 2009 21:45:19 +0000
Subject: Re: [PATCH 12/12]: sparc64: Use new dynamic per-cpu allocator.
Message-Id: <49DE6C6F.8090402@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408.223758.81953207.davem@davemloft.net>	<49DDE07C.8050101@kernel.org> <20090409.142923.252620650.davem@davemloft.net>
In-Reply-To: <20090409.142923.252620650.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller wrote:
>> Isn't it better to use embedding allocator for !NUMA cases (one less
>> TLB entry usage for each CPU)?
> 
> Heck, the embedding case would probably be optimal for Niagara NUMA
> systems too.
> 
> On Niagara systems all of the "possible" cpu numbers are linear and in
> order.  No holes, gaps, or other stuff like this.  So just allocating
> big TLB mapping chunks and chopping them up to the individual cpus is
> the best scheme possible.

Sounds great.  I wonder whether the remap allocator could be replaced
with embed allocator with right parameters on x86 too.

Thanks.

-- 
tejun
