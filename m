From: David Miller <davem@davemloft.net>
Date: Fri, 24 Jul 2020 23:37:19 +0000
Subject: Re: [PATCH 3/3] sparc: Drop unused MAX_PHYSADDR_BITS
Message-Id: <20200724.163719.765874169250237597.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200723231544.17274-1-nivedita@alum.mit.edu>
	<20200723231544.17274-4-nivedita@alum.mit.edu>
In-Reply-To: <20200723231544.17274-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nivedita@alum.mit.edu
Cc: x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 23 Jul 2020 19:15:44 -0400

> The macro is not used anywhere, so remove the definition.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: David S. Miller <davem@davemloft.net>
