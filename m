From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 11 Aug 2017 16:24:27 +0000
Subject: Re: [v6 07/15] mm: defining memblock_virt_alloc_try_nid_raw
Message-Id: <1d93e0eb-080a-ed2b-de2d-092f397a981c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-8-git-send-email-pasha.tatashin@oracle.com>
 <20170811123953.GI30811@dhcp22.suse.cz>
 <545b7230-2c09-d2f9-f26a-05ef395c36d4@oracle.com>
 <20170811160646.GT30811@dhcp22.suse.cz>
In-Reply-To: <20170811160646.GT30811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> Sure, I could do this, but as I understood from earlier Dave Miller's
>> comments, we should do one logical change at a time. Hence, introduce API in
>> one patch use it in another. So, this is how I tried to organize this patch
>> set. Is this assumption incorrect?
> 
> Well, it really depends. If the patch is really small then adding a new
> API along with users is easier to review and backport because you have a
> clear view of the usage. I believe this is the case here. But if others
> feel otherwise I will not object.

I will merge them.

Thank you,
Pasha
