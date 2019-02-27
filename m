From: David Miller <davem@davemloft.net>
Date: Wed, 27 Feb 2019 18:38:37 +0000
Subject: Re: [PATCH v3 20/34] sparc: mm: Add p?d_large() definitions
Message-Id: <20190227.103837.668255833945043179.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-21-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-21-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: steven.price@arm.com
Cc: Mark.Rutland@arm.com, x86@kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, james.morse@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kan.liang@linux.intel.com

From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:54 +0000

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For sparc, we don't support large pages, so add stubs returning 0.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Sparc does support large pages on 64-bit, just not at this level.  It
would be nice if the commit message was made more accurate.  Other than
that:

Acked-by: David S. Miller <davem@davemloft.net>
