From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 26 Nov 2020 12:01:14 +0000
Subject: [PATCH v2 0/6] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-Id: <20201126120114.071913521@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, eranian@google.com
Cc: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org, willy@infradead.org, aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org, davem@davemloft.net, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com, dave.hansen@intel.com, kirill.shutemov@linux.intel.com, peterz@infradead.org

Hi,

These patches provide generic infrastructure to determine TLB page size from
page table entries alone. Perf will use this (for either data or code address)
to aid in profiling TLB issues.

While most architectures only have page table aligned large pages, some
(notably ARM64, Sparc64 and Power) provide non page table aligned large pages
and need to provide their own implementation of these functions.

I've provided (completely untested) implementations for ARM64, Sparc64 and
Power/8xxx (it looks like I'm still missing Power/Book3s64/hash support).

Changes since -v1:

 - Changed wording to reflect these are page-table sizes; actual TLB sizes
   might vary.
 - added Power/8xx

Barring any objections I'll queue these in tip/perf/core, as these patches fix
the code that's currently in there.
