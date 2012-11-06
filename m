From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 06 Nov 2012 22:38:26 +0000
Subject: Re: [PATCH 09/16] mm: use vm_unmapped_area() in hugetlbfs on i386 architecture
Message-Id: <20121106143826.dc3b960c.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-10-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-10-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon,  5 Nov 2012 14:47:06 -0800
Michel Lespinasse <walken@google.com> wrote:

> Update the i386 hugetlb_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.

The x86_64 coloring "fix" wasn't copied into i386?
