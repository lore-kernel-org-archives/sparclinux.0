From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 14 Aug 2017 13:39:17 +0000
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-Id: <aac7b5f1-5c5e-e716-af49-bc150449ddbc@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
 <20170814113445.GE19063@dhcp22.suse.cz>
In-Reply-To: <20170814113445.GE19063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>> #ifdef CONFIG_MEMBLOCK in page_alloc, or define memblock_discard() stubs in
>> nobootmem headfile.
> 
> This is the standard way to do this. And it is usually preferred to
> proliferate ifdefs in the code.

Hi Michal,

As you suggested, I sent-out this patch separately. If you feel 
strongly, that this should be updated to have stubs for platforms that 
do not implement memblock, please send a reply to that e-mail, so those 
who do not follow this tread will see it. Otherwise, I can leave it as 
is, page_alloc file already has a number memblock related ifdefs all of 
which can be cleaned out once every platform implements it (is it even 
achievable?)

Thank you,
Pasha
