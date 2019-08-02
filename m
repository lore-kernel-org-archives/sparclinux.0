From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 02 Aug 2019 05:48:15 +0000
Subject: Re: [PATCH 20/34] xen: convert put_page() to put_user_page*()
Message-Id: <d5140833-e9ee-beb5-ff0a-2d13a4fe819f@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-21-jhubbard@nvidia.com>
 <4471e9dc-a315-42c1-0c3c-55ba4eeeb106@suse.com>
In-Reply-To: <4471e9dc-a315-42c1-0c3c-55ba4eeeb106@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Juergen Gross <jgross@suse.com>, john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: devel@driverdev.osuosl.org, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, x86@kernel.org, linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devel@lists.orangefs.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, rds-devel@oss.oracle.com, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org

On 8/1/19 9:36 PM, Juergen Gross wrote:
> On 02.08.19 04:19, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
...
>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>> index 2f5ce7230a43..29e461dbee2d 100644
>> --- a/drivers/xen/privcmd.c
>> +++ b/drivers/xen/privcmd.c
>> @@ -611,15 +611,10 @@ static int lock_pages(
>>   static void unlock_pages(struct page *pages[], unsigned int nr_pages)
>>   {
>> -    unsigned int i;
>> -
>>       if (!pages)
>>           return;
>> -    for (i = 0; i < nr_pages; i++) {
>> -        if (pages[i])
>> -            put_page(pages[i]);
>> -    }
>> +    put_user_pages(pages, nr_pages);
> 
> You are not handling the case where pages[i] is NULL here. Or am I
> missing a pending patch to put_user_pages() here?
> 

Hi Juergen,

You are correct--this no longer handles the cases where pages[i]
is NULL. It's intentional, though possibly wrong. :)

I see that I should have added my standard blurb to this
commit description. I missed this one, but some of the other patches
have it. It makes the following, possibly incorrect claim:

"This changes the release code slightly, because each page slot in the
page_list[] array is no longer checked for NULL. However, that check
was wrong anyway, because the get_user_pages() pattern of usage here
never allowed for NULL entries within a range of pinned pages."

The way I've seen these page arrays used with get_user_pages(),
things are either done single page, or with a contiguous range. So
unless I'm missing a case where someone is either

a) releasing individual pages within a range (and thus likely messing
up their count of pages they have), or

b) allocating two gup ranges within the same pages[] array, with a
gap between the allocations,

...then it should be correct. If so, then I'll add the above blurb
to this patch's commit description.

If that's not the case (both here, and in 3 or 4 other patches in this
series, then as you said, I should add NULL checks to put_user_pages()
and put_user_pages_dirty_lock().


thanks,
-- 
John Hubbard
NVIDIA
