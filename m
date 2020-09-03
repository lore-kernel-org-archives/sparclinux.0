From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Thu, 03 Sep 2020 08:50:50 +0000
Subject: Re: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg support issue
Message-Id: <21144022-cf75-5b4f-4645-a7f0746b025d@linux.alibaba.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
 <CAMo8BfJT7JJfwT1-X3vfqKGD-E3-Dbf2xyWs-RiRyUUHmbetVA@mail.gmail.com>
In-Reply-To: <CAMo8BfJT7JJfwT1-X3vfqKGD-E3-Dbf2xyWs-RiRyUUHmbetVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, David Hildenbrand <david@redhat.com>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Russell King <linux@armlinux.org.uk>, Alexander Duyck <alexander.duyck@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>



在 2020/9/3 下午3:29, Max Filippov 写道:
>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>> index e997e0119c02..862b008ab09e 100644
>> --- a/arch/xtensa/Kconfig
>> +++ b/arch/xtensa/Kconfig
>> @@ -42,6 +42,7 @@ config XTENSA
>>         select MODULES_USE_ELF_RELA
>>         select PERF_USE_VMALLOC
>>         select VIRT_TO_BUS
>> +       select NO_CMPXCHG_BYTE
> Please keep the lists of select statements in Kconfig files above
> alphabetically sorted.

Hi Max,

Thanks for the reminder, Let's comments from Mel Gorman.

Thanks!
