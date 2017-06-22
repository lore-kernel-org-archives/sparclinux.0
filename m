From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 22 Jun 2017 14:45:15 +0000
Subject: Re: [PATCH] sparc64: Fix gup_huge_pmd
Message-Id: <CAGRGNgVK3GpBJX-qFb=nyFKPnb1re+unYfikBFzQ2UUwngLs8Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1498081816-179369-1-git-send-email-nitin.m.gupta@oracle.com>
 <CAGRGNgXePANYQ5HNhc-mojrf9=tA0Xvfh-ySFgaWatbB3fmLiw@mail.gmail.com> <34836bf2-2cef-6fc0-52e5-92767883eabf@oracle.com>
In-Reply-To: <34836bf2-2cef-6fc0-52e5-92767883eabf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nitin Gupta <nitin.m.gupta@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Nitin,

On Fri, Jun 23, 2017 at 12:37 AM, Nitin Gupta <nitin.m.gupta@oracle.com> wrote:
> Hi Julian,
>
>
> On 6/22/17 3:53 AM, Julian Calaby wrote:
>>
>> On Thu, Jun 22, 2017 at 7:50 AM, Nitin Gupta <nitin.m.gupta@oracle.com>
>> wrote:
>>>
>>> The function assumes that each PMD points to head of a
>>> huge page. This is not correct as a PMD can point to
>>> start of any 8M region with a, say 256M, hugepage. The
>>> fix ensures that it points to the correct head of any PMD
>>> huge page.
>>>
>>> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
>>> ---
>>>   arch/sparc/mm/gup.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
>>> index cd0e32b..9116a6f 100644
>>> --- a/arch/sparc/mm/gup.c
>>> +++ b/arch/sparc/mm/gup.c
>>> @@ -80,6 +80,8 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd,
>>> unsigned long addr,
>>>          refs = 0;
>>>          head = pmd_page(pmd);
>>>          page = head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>>> +       if (PageTail(head))
>>> +               head = compound_head(head);
>>
>> Stupid question: shouldn't this go before the page calculation?
>
>
> No, it should be after page calculation: First, 'head' points to base of
> the PMD page, then 'page' points to an offset within that page. Finally,
> we make sure that head variable points to head of the compound page
> which contains the addr.

Thanks for the explanation, that makes a bit more sense to me.

> I think confusion comes from the use of 'head' for pointing to a
> non-head page. So, maybe it would be more clear to write that part
> of the function this way:
>
>         page = pmd_page(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>         head = compound_head(page);

More verbose variable names would help too. =)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
