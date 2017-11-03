From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 03 Nov 2017 15:50:53 +0000
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <7f4e35ba-2448-16ba-63e1-229eb30b068b@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
 <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
 <ad8c5715-dc4f-1fa7-c25b-e08df68643d0@oracle.com>
 <20171018170651.GG21820@arm.com>
 <e32c677e-62ac-8977-2f9d-7fe7bda4b547@oracle.com>
 <f1cb8d18-4d0f-1f88-c3c5-0add8c6c077a@virtuozzo.com>
 <a587687a-5d90-c03d-f3d2-1ea9cab1b0c4@oracle.com>
 <07ab0b77-0e2a-97b5-73ff-a6598bcb94cd@virtuozzo.com>
In-Reply-To: <07ab0b77-0e2a-97b5-73ff-a6598bcb94cd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

>> 1. Replace these two patches:
>>
>> arm64/kasan: add and use kasan_map_populate()
>> x86/kasan: add and use kasan_map_populate()
>>
>> With:
>>
>> x86/mm/kasan: don't use vmemmap_populate() to initialize
>>   shadow
>> arm64/mm/kasan: don't use vmemmap_populate() to initialize
>>   shadow
>>
> 
> Pavel, could you please send the patches? These patches doesn't interfere with rest of the series,
> so I think it should be enough to send just two patches to replace the old ones.
> 

Hi Andrey,

I asked Michal and Andrew how to proceed but never received a reply from 
them. The patches independent from the deferred page init series as long 
as they come before the series.

Anyway, I will post these two patches to the mailing list soon. But, not 
really sure if they will be taken into mm-tree.

Pavel
