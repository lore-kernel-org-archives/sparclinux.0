From: Michal Hocko <mhocko@kernel.org>
Date: Mon, 14 Aug 2017 11:34:45 +0000
Subject: Re: [v6 04/15] mm: discard memblock data later
Message-Id: <20170814113445.GE19063@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-5-git-send-email-pasha.tatashin@oracle.com>
 <20170811093249.GE30811@dhcp22.suse.cz>
 <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
In-Reply-To: <42a04441-47ad-2fa0-ca3c-784c717213f7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri 11-08-17 15:00:47, Pasha Tatashin wrote:
> Hi Michal,
> 
> This suggestion won't work, because there are arches without memblock
> support: tile, sh...
> 
> So, I would still need to have:
> 
> #ifdef CONFIG_MEMBLOCK in page_alloc, or define memblock_discard() stubs in
> nobootmem headfile. 

This is the standard way to do this. And it is usually preferred to
proliferate ifdefs in the code.
-- 
Michal Hocko
SUSE Labs
