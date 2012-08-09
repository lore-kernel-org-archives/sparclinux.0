From: "Jan Beulich" <JBeulich@suse.com>
Date: Thu, 09 Aug 2012 15:28:56 +0000
Subject: Re: [PATCH v2 6/6] x86: switch the 64bit uncached page clear to SSE/AVX v2
Message-Id: <5023F3580200007800093F2C@nat28.tlf.novell.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1344524583-1096-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1344524583-1096-7-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Robert Richter <robert.richter@amd.com>, Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Alex Shi <alex.shu@intel.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, x86@kernel.org, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org, Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, Andrea Arcangeli <aarcange@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

>>> On 09.08.12 at 17:03, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
>  ENTRY(clear_page_nocache)
>  	CFI_STARTPROC
> -	xorl   %eax,%eax
> -	movl   $4096/64,%ecx
> +	push   %rdi
> +	call   kernel_fpu_begin
> +	pop    %rdi

You use CFI annotations elsewhere, so why don't you use
pushq_cfi/popq_cfi here?

Jan

