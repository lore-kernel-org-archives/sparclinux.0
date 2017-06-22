From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 22 Jun 2017 10:53:57 +0000
Subject: Re: [PATCH] sparc64: Fix gup_huge_pmd
Message-Id: <CAGRGNgXePANYQ5HNhc-mojrf9=tA0Xvfh-ySFgaWatbB3fmLiw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1498081816-179369-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1498081816-179369-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Nitin,

On Thu, Jun 22, 2017 at 7:50 AM, Nitin Gupta <nitin.m.gupta@oracle.com> wrote:
> The function assumes that each PMD points to head of a
> huge page. This is not correct as a PMD can point to
> start of any 8M region with a, say 256M, hugepage. The
> fix ensures that it points to the correct head of any PMD
> huge page.
>
> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> ---
>  arch/sparc/mm/gup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
> index cd0e32b..9116a6f 100644
> --- a/arch/sparc/mm/gup.c
> +++ b/arch/sparc/mm/gup.c
> @@ -80,6 +80,8 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned long addr,
>         refs = 0;
>         head = pmd_page(pmd);
>         page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +       if (PageTail(head))
> +               head = compound_head(head);

Stupid question: shouldn't this go before the page calculation?

>         do {
>                 VM_BUG_ON(compound_head(page) != head);
>                 pages[*nr] = page;

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
