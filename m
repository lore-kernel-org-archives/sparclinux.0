Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDF4305979
	for <sparclinux@vger.kernel.org>; Mon,  8 Sep 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343595; cv=none; b=b0JuZTVP2MIujcCgDvytvCt3mFfGJUyhUUab3eWSH1cwycdosPurDeK7qowGoaRc9DGw5rQX6DFfjBuVM9nKeSXR1rwiPmDDo5am/T+wbL2OlVDChkMweypZ7QfbotoUQFwsASqoebhlGfV31qx8+Dl7BOR/agGGug7XiDcGCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343595; c=relaxed/simple;
	bh=xmvrKh04vv8VwSqcxidQ9l7jswlHHBjPeSY+T4u8JEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aACEHQ8E/aSKbQ7PFbVgnDtndCJtQriI12ylGiN0CKpYU0RhWq0CZSAjjpGuhOgJ9S974gUSHjtMWuugGQImyz2C7S/xgCw/djkdAuvDwD0cGh/G4CfZIBkXXJzvpKxiClOq8JblYuFWRzqRXd6OTMLxkLHljJ6oL8pFsNH8Xc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g0azDLjH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0azDLjH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757343592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zj/W2A1w620z3uj4NM/KYzIZPfPCpjNHUO9sqnkbSZI=;
	b=g0azDLjH2FGswG2EkIm7gDE9ga15Rezl2FR4a2MZUO1iV4FbT08oQ4W0B/MtjDF3b6aqR0
	xvj8f0AZZwV+bRgx6SmMSyn0sh54mO6mDVE2EIHTo2CQakl8fvZn9bbE1Cy58+5j6UqKxg
	J3ZbY0ezupWWsXGlPb26pwm98kcoz5E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ED41SQMMNjCocAOANxaBLw-1; Mon, 08 Sep 2025 10:59:51 -0400
X-MC-Unique: ED41SQMMNjCocAOANxaBLw-1
X-Mimecast-MFC-AGG-ID: ED41SQMMNjCocAOANxaBLw_1757343591
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e2055ce94bso2678138f8f.2
        for <sparclinux@vger.kernel.org>; Mon, 08 Sep 2025 07:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343590; x=1757948390;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zj/W2A1w620z3uj4NM/KYzIZPfPCpjNHUO9sqnkbSZI=;
        b=HbVZXjFL/asIuwTUCPrhfvMmei4jbcN40mtGLBm1ETrClBBOngZ3mKxLDT/TW1Ma11
         aIhhtxBSiF29XpSGuAVSpi50a7ZW5Z4W1MGNuzug8TfVzz/kHj0Lwv2xPP+DL5Rm/udv
         lSroWVe/JIN1GHzVvK7HPSMmBJx56TBgCyuLX8dXOarlJsRVCw+tnZna566refBXyaSW
         yIpt26MFSp1QgmFp1v0QCH98GkEO5ygqgthFw+yZE4P4x1gA0er3TCRaarS+feGxbbIq
         wx9XR0QGbYFwNNQoS2PVs7Bji48iR+SpevSHrWx5cU89NCJnhkz7lO6pEWH49lNzEZbF
         n4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvKH6A2cQenuLtRyiB/+4pu/c5sBBt6m50JiIlDOGXswTY13igooVEUjhfSHlwuOakNDxOvt0hKkRf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdn4y0+YRKmf6h3EQzSnF8K3I0ZghukbmxUvVzTuDh0zV1kPMy
	2Nk9xuEkgOtZwHq/CMrZ5VipF6wYiByL2I7n2Xq8heNJXKytgTQJD9iJufTrNOBBec2ACIWk7cd
	qhJR7E7lK7u6afmO41KCRIL9GbZsPiIOAw+btbH1gHRCo1ws+R+KKq/3szjFvNyk=
X-Gm-Gg: ASbGncuPa++eFAHFeAmneooieaaGmsk1OozFZ9Xmr6xyda8yPfZUnppN4MbFvWm8uj8
	2IYRedVd3w/Aueermjfk1B/VSOI8D5lPFlcmzdVsStxABY7Agp5Vab8OpNNcx5nbSyjwuo6++10
	xxG4zR/HswOxvtdXOWlJxFs7L+wPpO11YErPidFN8tqgGjh81kbggiuT+1Z24n6xeU2CtUwIwsK
	6jPN5W81cuEcIm16z7xtIBi14oXMbARUELg+mRtFfK3jBQhDpxJZzTlWvtMNfzajESLSxCFxgqG
	/fyHTwbsHVg/v0zL7RKJS9jBquo6BkSSFx1lCCjEBpgKwaXS5chjDfSruSc3wVrEm6M4D8kFqjc
	kFPjglZ5x3KLWL+4sDAOo35b3v0Uud4mPnh9liCNl/kxuD6B0t7RqHxv5ewno4MWY
X-Received: by 2002:a05:6000:18a9:b0:3cb:5e64:ae8 with SMTP id ffacd0b85a97d-3e636d8fceamr8124649f8f.11.1757343590409;
        Mon, 08 Sep 2025 07:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Sl+7I843zNJKDyb1TeCWtEYDDRjw0tVeJKWAZDqQ44OZCVI4FghBC+qHaOA5/2UP0jatjQ==
X-Received: by 2002:a05:6000:18a9:b0:3cb:5e64:ae8 with SMTP id ffacd0b85a97d-3e636d8fceamr8124577f8f.11.1757343589898;
        Mon, 08 Sep 2025 07:59:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da13041bcasm25975587f8f.35.2025.09.08.07.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:59:49 -0700 (PDT)
Message-ID: <cc59a58c-266c-4424-9df1-d1cec8d740c5@redhat.com>
Date: Mon, 8 Sep 2025 16:59:46 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] mm/shmem: update shmem to use mmap_prepare
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
 <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2f84230f9087db1c62860c1a03a90416b8d7742e.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 13:10, Lorenzo Stoakes wrote:
> This simply assigns the vm_ops so is easily updated - do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

