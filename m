From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 05 May 2017 13:30:29 +0000
Subject: Re: [PATCH v3 4/4] mm: Adaptive hash table scaling
Message-Id: <20170505133029.GC31461@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1488432825-92126-1-git-send-email-pasha.tatashin@oracle.com>
 <1488432825-92126-5-git-send-email-pasha.tatashin@oracle.com>
 <20170303153247.f16a31c95404c02a8f3e2c5f@linux-foundation.org>
 <20170426201126.GA32407@dhcp22.suse.cz>
 <40f72efa-3928-b3c6-acca-0740f1a15ba4@oracle.com>
 <429c8506-c498-0599-4258-7bac947fe29c@oracle.com>
In-Reply-To: <429c8506-c498-0599-4258-7bac947fe29c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Thu 04-05-17 14:28:51, Pasha Tatashin wrote:
> BTW, I am OK with your patch on top of this "Adaptive hash table" patch, but
> I do not know what high_limit should be from where HASH_ADAPT will kick in.
> 128M sound reasonable to you?

For simplicity I would just use it unconditionally when no high_limit is
set. What would be the problem with that? If you look at current users
(and there no new users emerging too often) then most of them just want
_some_ scaling. The original one obviously doesn't scale with large
machines. Are you OK to fold my change to your patch or you want me to
send a separate patch? AFAIK Andrew hasn't posted this patch to Linus
yet.
-- 
Michal Hocko
SUSE Labs
