From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 03 Oct 2017 15:10:35 +0000
Subject: Re: [PATCH v9 02/12] sparc64/mm: setting fields in deferred pages
Message-Id: <3c410186-0af9-dae8-84eb-8f4d4651d355@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-3-pasha.tatashin@oracle.com>
 <20171003122823.mdzkhxs4xza7sb2w@dhcp22.suse.cz>
In-Reply-To: <20171003122823.mdzkhxs4xza7sb2w@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> 
> As you separated x86 and sparc patches doing essentially the same I
> assume David is going to take this patch?

Correct, I noticed that usually platform specific changes are done in 
separate patches even if they are small. Dave already Acked this patch. 
So, I do not think it should be separated from the rest of the patches 
when this projects goes into mm-tree.

> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pasha

