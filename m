From: David Miller <davem@davemloft.net>
Date: Wed, 06 Mar 2019 19:02:23 +0000
Subject: Re: [PATCH v4 07/19] sparc: mm: Add p?d_large() definitions
Message-Id: <20190306.110223.879768694292631517.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190306155031.4291-1-steven.price@arm.com>
 <20190306155031.4291-8-steven.price@arm.com>
In-Reply-To: <20190306155031.4291-8-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: steven.price@arm.com
Cc: Mark.Rutland@arm.com, x86@kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, sparclinux@vger.kernel.org, james.morse@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kan.liang@linux.intel.com

From: Steven Price <steven.price@arm.com>
Date: Wed,  6 Mar 2019 15:50:19 +0000

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For sparc 64 bit, pmd_large() and pud_large() are already provided, so
> add #defines to prevent the generic versions (added in a later patch)
> from being used.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
