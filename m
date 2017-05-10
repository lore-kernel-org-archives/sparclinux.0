From: David Miller <davem@davemloft.net>
Date: Wed, 10 May 2017 15:20:59 +0000
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-Id: <20170510.112059.169845404310247896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3f5f1416-aa91-a2ff-cc89-b97fcaa3e4db@oracle.com>
	<20170510145726.GM31466@dhcp22.suse.cz>
	<ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
In-Reply-To: <ab667486-54a0-a36e-6797-b5f7b83c10f7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pasha.tatashin@oracle.com
Cc: mhocko@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 10 May 2017 11:01:40 -0400

> Perhaps you are right, and I will measure on x86. But, I suspect hit
> can become unacceptable on some platfoms: there is an overhead of
> calling a function, even if it is leaf-optimized, and there is an
> overhead in memset() to check for alignments of size and address,
> types of setting (zeroing vs. non-zeroing), etc., that adds up
> quickly.

Another source of overhead on the sparc64 side is that we much
do memory barriers around the block initializiing stores.  So
batching calls to memset() amortize that as well.
