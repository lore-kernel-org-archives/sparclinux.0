From: David Miller <davem@davemloft.net>
Date: Thu, 23 Feb 2017 16:34:07 +0000
Subject: Re: [PATCH] sparc64: memblock resizes are not handled properly
Message-Id: <20170223.113407.1193372017291081764.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1487276034-154065-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1487276034-154065-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 16 Feb 2017 15:13:54 -0500

> In add_node_ranges() when memblock resize happens, the iterator keeps using
> the previous freed array. This bug cause hangs on machine where there are
> over 128 memory blocks during boot. For example, on machines where memory
> interleaving is small.
> The problem is seen on T4-4 because it cant have 2T of memory, and memory
> is  interleaved at 8G. So we have 2T/8G = 256 regions to set node IDs. The
> starting size of regions array is 128. Thus, we have to double at least one
> time (actually we have to double twice because some memory is already
> reserved and thus we need more than 256 regions). We start using an
> incorrect pointer to the array after the first doubling.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: Babu Moger <babu.moger@oracle.com>

Applied.
