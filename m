From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 24 Jul 2020 15:04:41 +0000
Subject: Re: [PATCH 0/3] Drop unused MAX_PHYSADDR_BITS
Message-Id: <e6747427-30a9-7e5c-2693-5e3d770d578a@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On 7/23/20 4:15 PM, Arvind Sankar wrote:
> This #define is not used anywhere, and has the wrong value on x86_64.

Yeah, it certainly is unused.

> I tried digging into the history a bit, but it seems to have been unused
> even in the initial merge of sparsemem in v2.6.13, when it was first
> defined.

Yep, I don't even remember why we thought we needed it back then.  Feel
free to add my ack on these, or at least the x86 one.
