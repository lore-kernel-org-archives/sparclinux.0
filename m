From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:33:58 +0000
Subject: Re: [PATCH] sparc64: use latency groups to improve add_node_ranges speed
Message-Id: <20170223.113358.412371215880084081.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1487275558-153109-2-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1487275558-153109-2-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 15:05:58 -0500

> add_node_ranges() takes 2.6s - 3.6s per 1T of boot time. On machine with 6T
> memory it takes 15.4s, on 32T it would take 82s-115s of boot time.
> This function sets NUMA ids for memory blocks, and scans the whole memory a
> page at a time to do so. But, we could use values in latency groups mask
> and match to determine the boundaries without checking every single page.
> With the fix the add_node_ranges() time is reduced from 15.4s down to 0.2s
> on machine with 6T memory.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: Bob Picco <bob.picco@oracle.com>

Applied.
