From: Rik van Riel <riel@redhat.com>
Date: Mon, 05 Nov 2012 23:37:37 +0000
Subject: Re: [PATCH 16/16] mm: use vm_unmapped_area() in hugetlbfs on tile architecture
Message-Id: <50984DC1.2030608@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-17-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-17-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the tile hugetlb_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

