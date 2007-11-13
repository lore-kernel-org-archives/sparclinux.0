From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 13 Nov 2007 11:37:55 +0000
Subject: Re: Vmstat: Small revisions to refresh_cpu_vm_stats()
Message-Id: <20071113033755.c2e64c09.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0711091837390.18567@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0711091837390.18567@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Fri, 9 Nov 2007 18:39:03 -0800 (PST) Christoph Lameter <clameter@sgi.com> wrote:

> 1. Add comments explaining how the function can be called.
> 
> 2. Avoid interrupt enable / disable through the use of xchg.
> 
> 3. Collect global diffs in a local array and only spill
>    them once into the global counters when the zone scan
>    is finished. This means that we only touch each global
>    counter once instead of each time we fold cpu counters
>    into zone counters.

: undefined reference to `__xchg_called_with_bad_pointer'

This is sparc64's way of telling you that you can'd do xchg on an s8.

Dave, is that fixable?

I assume not, in which case we either go for some open-coded implementation
for 8- and 16-bits or we should ban (at compile time) 8- and 16-bit xchg on
all architectures.


