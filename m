Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0A230BB86
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345522; cv=none; b=rlyXODvCnD+6qMs9J530nGS/ogr8Lb8IOdYfkDqD2w3zh5/tSje5h4gTaaksvopDuZXCxrRTu3zgTqWZD0S/C8TqEjsY4APYLukvcssrdjt8v7/TY1F4eZY8PQKlNhYOwd7hSi9ReAqz5AYWevYBqTmG8NrbPys2XcerT+GBHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345522; c=relaxed/simple;
	bh=HjoLd5JLKL9SfHfGX5t6gCZDhrFLCM+vW92wg97Uhhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgfMw+vMwSSDdOZbsan+TCKdofnVOCcQFuqjsHj7d4SVhN5Edyz5MC2S1kjeECdIPEA+DXbjVquUM5wV1Ukrid+L4m8iJsmYeoshI1elJL0gCYVwhtvIAuGX5yzH9QdRLQ/YAuisEG5PZbPg1S5BHhvEhPktJUnM5KgXEZESkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFjcPVMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFjcPVMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757345519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3/AmiyqDL9vHReNzfhyWcNWwH+eng+cyq2XKxF08kzk=;
	b=jFjcPVMXqTw5D/MZ6d1B08FZVpUqIcvsYiK2XVyceu8cPu4hdzwMcLLNZLpindf35VFSYA
	81lt9HWxSzwaryGFAmi0/CLtbSXMjD/RFAzQGZ5wtJUajhPR38YWvBZ9V/je447DYbD9DG
	bDQPxtFcOiQmBqTxvuCDC8gXg75CVhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-d3yygy71OjCET_Q6fw_EBg-1; Mon, 08 Sep 2025 11:31:56 -0400
X-MC-Unique: d3yygy71OjCET_Q6fw_EBg-1
X-Mimecast-MFC-AGG-ID: d3yygy71OjCET_Q6fw_EBg_1757345514
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dde353979so12572075e9.3
        for <sparclinux@vger.kernel.org>; Mon, 08 Sep 2025 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345514; x=1757950314;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/AmiyqDL9vHReNzfhyWcNWwH+eng+cyq2XKxF08kzk=;
        b=uWmA/3l8mTnP0yXInUISm1/OHrLRAxbdySfSUKnCclzwdbgnsu7pku6X2MGnsDCBfd
         iZdDeq4jo5ghgXQzKLwMb0ktUxKA/wP8hTLbKb0CjpxfJ5v+ceBuaz2Z+BzrnXagjvSQ
         hHeYSS+w2bz/hBa0+BQEbELVyyTri81SST9DQ8VjXQeH+YfffKGxTE+2J8T3S3LxtGZ6
         ymRv8QBn3KPOwat/yLkHq++pkOI5BmYARWhjzIVRX0FjmxOV7HUQwCtWnLq2hGYL5GOz
         faohxwRSFSXKZxgC74FHVpc5bkwzaFwNCgUp0cdgtfAOzGz+N0L+9hpNFYTTQ4Qi4w7k
         dIWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z9F6G+egpT4eD8O2IRmJeeI1berO++3xPW5gbZE5uhOPNiK3Y8Y41c3CLk58Q0EMUbEq8+YAA9GC@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOp/oRqvN55bsP/RaqAgOzK323ExLvw4Q+/XReelopACcxlwM
	Y/Ali0pwzDDYoOweTF+TklT4SSGxXyf3EpWo7uvmteSNO5aLux0prz8APfXBiySEq8Qlw9KULPG
	kpdaqGqvLFP4+sQ0YIjwPjv7ljGy7QdaYLKTkm3DBPQH0fAVtwKs+bpFStfXSFCk=
X-Gm-Gg: ASbGncuAxIwQSR2TYxBLnTCaWi4c3nMQ+DCpCXj4PNOXYe+UUWi3fMqADGR+10/IaSW
	7BWJ4F2v72HFzd5kyLtAmEq6lzoUbkkyOCEJqhSk5en+dBmvCZNNPSo2XF4WBq8WIkqWPRMk0wc
	U802tCQmlRp7Ivt/IZS/LT2ri0ElmerZ6V/MzkXGBevB6UmJdP10IHphTcmaV5kGOgxU8uN9hL7
	qbQ7UzquNKmRUQxUUJb00NUSTU+BigXIdYGG7jaSIIYI+4SKP+7TW/qUUnW2f9EoDO4QkQ+1epX
	0nWGRcPnIXVKMMY7mUiz8VPEYF3YOog0mlPGONr6PzBNksM8bMRATgdk5Ig6xTajr0/XxEJEb9n
	p/p5qq1MYyDSnUqQCNtX3YGGISwuAbxB2k8iSWBgzWm0ok3h/AWXWOiBcww4NO3IH
X-Received: by 2002:a05:600c:468a:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dddeb7e1cmr77122285e9.10.1757345513976;
        Mon, 08 Sep 2025 08:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9rpy3InIS+5sr81R5XgCQln42twosPUaVcPgtYPShPoeqkbUoM5WXvKiqBYV5iWkxlAlPFA==
X-Received: by 2002:a05:600c:468a:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-45dddeb7e1cmr77121535e9.10.1757345513379;
        Mon, 08 Sep 2025 08:31:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d7ac825b88sm28792480f8f.7.2025.09.08.08.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:31:52 -0700 (PDT)
Message-ID: <cb2f3d85-928f-4a48-9f14-0628c189f10d@redhat.com>
Date: Mon, 8 Sep 2025 17:31:49 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] device/dax: update devdax to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <85681b9c085ee723f6ad228543c300b029d49cbc.1757329751.git.lorenzo.stoakes@oracle.com>
 <e9f2a694-29b0-4761-ad7a-88c4b24b90b7@redhat.com>
 <a97321dd-d8a4-4658-8894-14b854661d34@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a97321dd-d8a4-4658-8894-14b854661d34@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 17:28, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:03:54PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:10, Lorenzo Stoakes wrote:
>>> The devdax driver does nothing special in its f_op->mmap hook, so
>>> straightforwardly update it to use the mmap_prepare hook instead.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    drivers/dax/device.c | 32 +++++++++++++++++++++-----------
>>>    1 file changed, 21 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>>> index 2bb40a6060af..c2181439f925 100644
>>> --- a/drivers/dax/device.c
>>> +++ b/drivers/dax/device.c
>>> @@ -13,8 +13,9 @@
>>>    #include "dax-private.h"
>>>    #include "bus.h"
>>> -static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>>> -		const char *func)
>>> +static int __check_vma(struct dev_dax *dev_dax, vm_flags_t vm_flags,
>>> +		       unsigned long start, unsigned long end, struct file *file,
>>> +		       const char *func)
>>
>> In general
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
>>
>> The only thing that bugs me is __check_vma() that does not check a vma.
> 
> Ah yeah, you're right.
> 
>>
>> Maybe something along the lines of
>>
>> "check_vma_properties"
> 
> maybe check_vma_desc()?

Would also work, although it might imply that we are passing in a vma desc.

Well, you could let check_vma() construct a vma_desc and pass that to 
check_vma_desc() ...

-- 
Cheers

David / dhildenb

