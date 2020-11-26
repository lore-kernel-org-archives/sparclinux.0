From: Matthew Wilcox <willy@infradead.org>
Date: Thu, 26 Nov 2020 12:43:49 +0000
Subject: Re: [PATCH v2 2/6] mm: Introduce pXX_leaf_size()
Message-Id: <20201126124349.GQ4327@casper.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.102580109@infradead.org>
In-Reply-To: <20201126121121.102580109@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com

On Thu, Nov 26, 2020 at 01:01:16PM +0100, Peter Zijlstra wrote:
> A number of architectures have non-pagetable aligned huge/large pages.
> For such architectures a leaf can actually be part of a larger entry.
> 
> Provide generic helpers to determine the size of a page-table leaf.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
