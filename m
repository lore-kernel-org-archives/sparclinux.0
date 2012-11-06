From: Rik van Riel <riel@redhat.com>
Date: Tue, 06 Nov 2012 22:48:05 +0000
Subject: Re: [PATCH 09/16] mm: use vm_unmapped_area() in hugetlbfs on i386 architecture
Message-Id: <509993A5.2000605@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-10-git-send-email-walken@google.com>
 <20121106143826.dc3b960c.akpm@linux-foundation.org>
In-Reply-To: <20121106143826.dc3b960c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/06/2012 05:38 PM, Andrew Morton wrote:
> On Mon,  5 Nov 2012 14:47:06 -0800
> Michel Lespinasse <walken@google.com> wrote:
>
>> Update the i386 hugetlb_get_unmapped_area function to make use of
>> vm_unmapped_area() instead of implementing a brute force search.
>
> The x86_64 coloring "fix" wasn't copied into i386?

Only certain 64 bit AMD CPUs have that issue at all.

On x86, page coloring is really not much of an issue.

All the x86-64 patch does is make the x86-64 page
coloring code behave the same way page coloring
does on MIPS, SPARC, ARM, PA-RISC and others...
