From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 Aug 2017 14:01:52 +0000
Subject: Re: [v6 15/15] mm: debug for raw alloctor
Message-Id: <b4eb28ad-2d58-fb23-2139-427df46c2773@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-16-git-send-email-pasha.tatashin@oracle.com>
 <20170811130831.GN30811@dhcp22.suse.cz>
 <87d84cad-f03a-88f0-7828-6d3bf7ac473c@oracle.com>
 <20170814115000.GJ19063@dhcp22.suse.cz>
In-Reply-To: <20170814115000.GJ19063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> However, now thinking about it, I will change it to CONFIG_MEMBLOCK_DEBUG,
>> and let users decide what other debugging configs need to be enabled, as
>> this is also OK.
> 
> Actually the more I think about it the more I am convinced that a kernel
> boot parameter would be better because it doesn't need the kernel to be
> recompiled and it is a single branch in not so hot path.

The main reason I do not like kernel parameter is that automated test 
suits for every platform would need to be updated to include this new 
parameter in order to test it.

Yet, I think it is important at least initially to test it on every 
platform unconditionally when certain debug configs are enabled.

This patch series allows boot allocator to return uninitialized memory, 
this behavior Linux never had before, but way too often firmware 
explicitly zero all the memory before starting OS. Therefore, it would 
be hard to debug issues that might be only seen during kinit type of 
reboots.

In the future, when memory sizes will increase so that this memset will 
become unacceptable even on debug kernels, it can always be removed, but 
at least at that time we will know that the code has been tested for 
many years.
