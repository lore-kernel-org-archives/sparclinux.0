From: David Miller <davem@davemloft.net>
Date: Thu, 24 Oct 2019 16:46:23 +0000
Subject: Re: [PATCH v13 09/22] sparc: mm: Add p?d_leaf() definitions
Message-Id: <20191024.094623.2182520936177775102.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20191024093716.49420-1-steven.price@arm.com>
 <20191024093716.49420-10-steven.price@arm.com>
In-Reply-To: <20191024093716.49420-10-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: steven.price@arm.com
Cc: Mark.Rutland@arm.com, x86@kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, james.morse@arm.com, tglx@linutronix.de, will@kernel.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, kan.liang@linux.intel.com

From: Steven Price <steven.price@arm.com>
Date: Thu, 24 Oct 2019 10:37:03 +0100

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_leaf() functions/macros.
> 
> For sparc 64 bit, pmd_large() and pud_large() are already provided, so
> add macros to provide the p?d_leaf names required by the generic code.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
