From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 03 Aug 2015 01:35:05 +0000
Subject: Re: [v3, 2/8] powerpc/perf/hv-24x7: Simplify extracting counter from result buffer
Message-Id: <20150803013505.22281140DF7@ozlabs.org>
List-Id: <sparclinux.vger.kernel.org>
In-Reply-To: <1436929315-28520-3-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Wed, 2015-15-07 at 03:01:49 UTC, Sukadev Bhattiprolu wrote:
> Simplify code that extracts a 24x7 counter from the HCALL's result buffer.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/465345ca387ed491c467

cheers
