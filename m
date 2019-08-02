From: John Hubbard <jhubbard@nvidia.com>
Date: Fri, 02 Aug 2019 19:25:01 +0000
Subject: Re: [PATCH 20/34] xen: convert put_page() to put_user_page*()
Message-Id: <746b2412-f48a-9722-2763-253a1b9c899d@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802022005.5117-21-jhubbard@nvidia.com>
 <4471e9dc-a315-42c1-0c3c-55ba4eeeb106@suse.com>
 <d5140833-e9ee-beb5-ff0a-2d13a4fe819f@nvidia.com>
 <d4931311-db01-e8c3-0f8c-d64685dc2143@suse.com>
 <2807E5FD2F6FDA4886F6618EAC48510E79E66216@CRSMSX101.amr.corp.intel.com>
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79E66216@CRSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Weiny, Ira" <ira.weiny@intel.com>, Juergen Gross <jgross@suse.com>, "john.hubbard@gmail.com" <john.hubbard@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Dave Hansen <dave.hansen@linux.intel.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "devel@lists.orangefs.org" <devel@lists.orangefs.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproj>

On 8/2/19 9:09 AM, Weiny, Ira wrote:
>>
>> On 02.08.19 07:48, John Hubbard wrote:
>>> On 8/1/19 9:36 PM, Juergen Gross wrote:
>>>> On 02.08.19 04:19, john.hubbard@gmail.com wrote:
>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>> ...
>>> If that's not the case (both here, and in 3 or 4 other patches in this
>>> series, then as you said, I should add NULL checks to put_user_pages()
>>> and put_user_pages_dirty_lock().
>>
>> In this case it is not correct, but can easily be handled. The NULL case can
>> occur only in an error case with the pages array filled partially or not at all.
>>
>> I'd prefer something like the attached patch here.
> 
> I'm not an expert in this code and have not looked at it carefully but that patch does seem to be the better fix than forcing NULL checks on everyone.
> 

OK, I'll use Juergen's approach, and also check for that pattern in the
other patches.


thanks,
-- 
John Hubbard
NVIDIA
