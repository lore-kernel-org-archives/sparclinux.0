From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 14 Aug 2017 13:42:43 +0000
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-Id: <20170814134243.GM19063@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
 <20170814113445.GE19063@dhcp22.suse.cz>
 <aac7b5f1-5c5e-e716-af49-bc150449ddbc@oracle.com>
In-Reply-To: <aac7b5f1-5c5e-e716-af49-bc150449ddbc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon 14-08-17 09:39:17, Pasha Tatashin wrote:
> >>#ifdef CONFIG_MEMBLOCK in page_alloc, or define memblock_discard() stubs in
> >>nobootmem headfile.
> >
> >This is the standard way to do this. And it is usually preferred to
> >proliferate ifdefs in the code.
> 
> Hi Michal,
> 
> As you suggested, I sent-out this patch separately. If you feel strongly,
> that this should be updated to have stubs for platforms that do not
> implement memblock, please send a reply to that e-mail, so those who do not
> follow this tread will see it. Otherwise, I can leave it as is, page_alloc
> file already has a number memblock related ifdefs all of which can be
> cleaned out once every platform implements it (is it even achievable?)

I do not think this needs a repost just for this. This was merely a
JFYI, in case you would need to repost for other reasons then just
update that as well. But nothing really earth shattering.
-- 
Michal Hocko
SUSE Labs
