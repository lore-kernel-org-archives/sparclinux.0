From: Jann Horn <jannh@google.com>
Date: Wed, 14 Oct 2020 22:29:42 +0000
Subject: Re: [PATCH 1/2] mm/mprotect: Call arch_validate_prot under mmap_lock and with length
Message-Id: <CAG48ez0hoNb+DsMtzanGMXWdU63GwSvpzFCx5CkQa3Xxxo+Abg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201007073932.865218-1-jannh@google.com>
 <d5332a7b-c300-6d28-18b9-4b7d4110ef86@oracle.com>
 <20201010110949.GA32545@gaia>
 <af207cf8-3049-85eb-349d-5fed6b9be49c@oracle.com>
 <20201012172218.GE6493@gaia> <20c85633-b559-c299-3e57-ae136b201526@oracle.com>
 <20201013091638.GA10778@gaia>
 <e4c2c56b-3dbe-73dd-ea72-a5378de7de6a@oracle.com>
In-Reply-To: <e4c2c56b-3dbe-73dd-ea72-a5378de7de6a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, linuxppc-dev@lists.ozlabs.org, kernel list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, sparclinux@vger.kernel.org, Anthony Yznaga <anthony.yznaga@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 14, 2020 at 11:24 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
[...]
> current code? What FreeBSD does seems like a reasonable thing to do. Any
> way first thing to do is to update sparc to use arch_validate_flags()
> and update sparc_validate_prot() to not peek into vma without lock. I
> can do that unless Jann wants to rework this 2 patch series with these
> changes.

Ah, if you're willing to take care of that, that'd be nice, please do. :)
