Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F856C433EF
	for <sparclinux@archiver.kernel.org>; Mon, 31 Jan 2022 07:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiAaHtC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 31 Jan 2022 02:49:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237945AbiAaHtB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 31 Jan 2022 02:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643615340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAt16hzi0jARVC2SH2tfH/9B/mqcxkzoEuuB90n1AMk=;
        b=DLNgAquRIbUZTcV6FsD5ygfGUQ5xtsO4FBrARcgfAJzBD3fJ8B+VGw/YqlADGy9tt7PXZp
        7efpEfocNzPCn2ioe1ow3QnAT2/he84B3OcuQaGMgdXoqL+vYrHpVQ1M7G4OPLl0qDDlbB
        sOq6wP8BgOlE2DOgLUmJ/UtqfL5HQhw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519--iHKBil-Nt614SvKQgO5sA-1; Mon, 31 Jan 2022 02:48:58 -0500
X-MC-Unique: -iHKBil-Nt614SvKQgO5sA-1
Received: by mail-wr1-f71.google.com with SMTP id j21-20020adfa555000000b001db55dd5a1dso4460658wrb.15
        for <sparclinux@vger.kernel.org>; Sun, 30 Jan 2022 23:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZAt16hzi0jARVC2SH2tfH/9B/mqcxkzoEuuB90n1AMk=;
        b=4OoA9rb1JEyIj1cqDNbwFt7dBIqEZIll0zC8YyW3hhw7tC8X4D1z8/sh9N0cYXRsmJ
         kwsW6noHjxp1T1iVjlnLaOjMPUSLnf++6PJKMUgn9ToNr1uZkQy/4gOSW5K+KY7fUvID
         7tS43Yk2YXu5FdgVaj4CGA/iH5UZzWON2vzpFtyk3pAP0L5NhpDjrMW6Bv8lY9v4EmRb
         /e0h9+vNKr0g5WhD7wuW/tXercIW3yrCO/VfNmZ9cvQxMOUZzQtjT5nrowRSOj1auk7V
         mOXr65WNSoRfhAeH4mW5p044dH2guYnVGt+6N8JcjvGCZBsQpsgKiStEzooR68Mc32UU
         rUnw==
X-Gm-Message-State: AOAM532Mae0TPppNdOhXPPRlTrBdaP+BN5eyfrfCxZDVOwHoQXglZ/MB
        1KW6dTQeNxBQ3L9vRct15QQVNZiR2GwIPYZCuLGjydcP5cyKBw8SJBUfQaNdRdRwSqo8cxsHbu3
        z3Jyg9U9KjdG3e5CJHCrHiQ==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr15911196wrx.563.1643615337602;
        Sun, 30 Jan 2022 23:48:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziNLNeLdU3x1hO5PuIt8mvz7fg18Pv6lGvSgHdK7fS7xha3a7EYrVkbUytI3CwE4ViZc3ZTg==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr15911171wrx.563.1643615337390;
        Sun, 30 Jan 2022 23:48:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:b200:f007:5a26:32e7:8ef5? (p200300cbc709b200f0075a2632e78ef5.dip0.t-ipconnect.de. [2003:cb:c709:b200:f007:5a26:32e7:8ef5])
        by smtp.gmail.com with ESMTPSA id y6sm5081791wrl.46.2022.01.30.23.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jan 2022 23:48:56 -0800 (PST)
Message-ID: <3be2e20c-f0b9-c080-adf4-b0e17c046eb0@redhat.com>
Date:   Mon, 31 Jan 2022 08:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v1] drivers/base/node: consolidate node device
 subsystem initialization in node_dev_init()
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
References: <20220128151540.164759-1-david@redhat.com>
 <YfeARpenqPii1WQH@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YfeARpenqPii1WQH@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 31.01.22 07:23, Oscar Salvador wrote:
> On Fri, Jan 28, 2022 at 04:15:40PM +0100, David Hildenbrand wrote:
>> ... and call node_dev_init() after memory_dev_init() from driver_init(),
>> so before any of the existing arch/subsys calls. All online nodes should
>> be known at that point.
>>
>> This is in line with memory_dev_init(), which initializes the memory
>> device subsystem and creates all memory block devices.
>>
>> Similar to memory_dev_init(), panic() if anything goes wrong, we don't
>> want to continue with such basic initialization errors.
>>
>> The important part is that node_dev_init() gets called after
>> memory_dev_init() and after cpu_dev_init(), but before any of the
>> relevant archs call register_cpu() to register the new cpu device under
>> the node device. The latter should be the case for the current users
>> of topology_init().
> 

Hi Oscar,

> So, before this change we had something like this:
> 
> do_basic_setup
>  driver_init
>   memory_dev_init
>  do_init_calls
>   ...
>    topology_init
>     register_nodes/register_one_node
> 
> And after the patch all happens in driver_init()
> 
> driver_init
>  memory_dev_init
>  node_dev_init
> 
> I guess this is fine as we do not have any ordering problems (aka: none
> of the functions we used to call before expect the nodes not to be
> there for some weird reason).
> 
> So, no functional change, right?
> 

Right, and the idea is that the online state of nodes (+ node/zone
ranges) already has to be known at that point in time, because
otherwise, we'd be in bigger trouble.

Thanks!


-- 
Thanks,

David / dhildenb

