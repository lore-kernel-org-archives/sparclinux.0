From: Andrea Arcangeli <aarcange@redhat.com>
Date: Thu, 16 Aug 2012 18:29:44 +0000
Subject: Re: [PATCH v3 6/7] mm: make clear_huge_page cache clear only around the fault address
Message-Id: <20120816182944.GN11188@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1345130154-9602-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1345130154-9602-7-git-send-email-kirill.shutemov@linux.intel.com>
 <20120816161647.GM11188@redhat.com>
 <20120816164356.GA30106@shutemov.name>
In-Reply-To: <20120816164356.GA30106@shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andi Kleen <ak@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Alex Shi <alex.shu@intel.com>, Jan Beulich <jbeulich@novell.com>, Robert Richter <robert.richter@amd.com>, Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, Aug 16, 2012 at 07:43:56PM +0300, Kirill A. Shutemov wrote:
> Hm.. I think with static_key we can avoid cache overhead here. I'll try.

Could you elaborate on the static_key? Is it some sort of self
modifying code?

> Thanks, for review. Could you take a look at huge zero page patchset? ;)

I've noticed that too, nice :). I'm checking some detail on the
wrprotect fault behavior but I'll comment there.
