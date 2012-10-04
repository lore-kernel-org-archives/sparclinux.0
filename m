From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 04 Oct 2012 16:42:48 +0000
Subject: Re: [PATCH 3/8] sparc64: Eliminate PTE table memory wastage.
Message-Id: <87y5jmfbd3.fsf@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20121002.182642.49574627747120711.davem@davemloft.net>
In-Reply-To: <20121002.182642.49574627747120711.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, linux-mm@kvack.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, aarcange@redhat.com, hannes@cmpxchg.org

David Miller <davem@davemloft.net> writes:

> We've split up the PTE tables so that they take up half a page instead
> of a full page.  This is in order to facilitate transparent huge page
> support, which works much better if our PMDs cover 4MB instead of 8MB.
>
> What we do is have a one-behind cache for PTE table allocations in the
> mm struct.
>
> This logic triggers only on allocations.  For example, we don't try to
> keep track of free'd up page table blocks in the style that the s390
> port does.

I am also implementing a similar change for powerpc. We have a 64K page
size, and want to make sure PMD cover 16MB, which is the huge page size
supported by the hardware. I was looking at using the s390 logic,
considering we have 16 PMDs mapping to same PTE page. Should we look at
generalizing the case so that other architectures can start using the
same code ?

-aneesh

