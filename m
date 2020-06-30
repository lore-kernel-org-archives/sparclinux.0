From: David Miller <davem@davemloft.net>
Date: Tue, 30 Jun 2020 20:52:37 +0000
Subject: Re: [PATCH v4 21/26] mm/sparc64: Use general page fault accounting
Message-Id: <20200630.135237.1160983148962711910.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200630204556.39491-1-peterx@redhat.com>
In-Reply-To: <20200630204556.39491-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, jhubbard@nvidia.com, mpe@ellerman.id.au, gerald.schaefer@de.ibm.com, aarcange@redhat.com, torvalds@linux-foundation.org, will@kernel.org, sparclinux@vger.kernel.org

From: Peter Xu <peterx@redhat.com>
Date: Tue, 30 Jun 2020 16:45:56 -0400

> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
> 
> CC: David S. Miller <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
