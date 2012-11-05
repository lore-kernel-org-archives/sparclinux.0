From: Rik van Riel <riel@redhat.com>
Date: Mon, 05 Nov 2012 23:35:39 +0000
Subject: Re: [PATCH 11/16] mm: use vm_unmapped_area() on arm architecture
Message-Id: <50984D4B.6090501@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-12-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-12-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the arm arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

