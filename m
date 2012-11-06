From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 06 Nov 2012 22:38:30 +0000
Subject: Re: [PATCH 10/16] mm: use vm_unmapped_area() on mips architecture
Message-Id: <20121106143830.29de3bad.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-11-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-11-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon,  5 Nov 2012 14:47:07 -0800
Michel Lespinasse <walken@google.com> wrote:

> Update the mips arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.
> 

Are the changes to the coloring equivalent to what was there before? 
It's unobvious..

COLOUR_ALIGN_DOWN() is now unused and should be removed?

