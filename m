From: David Howells <dhowells@redhat.com>
Date: Thu, 03 Oct 2013 08:54:17 +0000
Subject: Re: [PATCH] Fix generic hugetlb pte check return type.
Message-Id: <20301.1380790457@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20131002.142509.1450460988268165850.davem@davemloft.net>
In-Reply-To: <20131002.142509.1450460988268165850.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> The include/asm-generic/hugetlb.h stubs that just vector huge_pte_*()
> calls to the pte_*() implementations won't work in certain situations.
> 
> x86 and sparc, for example, return "unsigned long" from the bit
> checks, and just go "return pte_val(pte) & PTE_BIT_FOO;"
> 
> But since huge_pte_*() returns 'int', if any high bits on 64-bit are
> relevant, they get chopped off.
> 
> The net effect is that we can loop forever trying to COW a huge page,
> because the huge_pte_write() check signals false all the time.
> 
> Reported-by: Gurudas Pai <gurudas.pai@oracle.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: David Howells <dhowells@redhat.com>
