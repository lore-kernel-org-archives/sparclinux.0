From: "David S. Miller" <davem@redhat.com>
Date: Tue, 06 Jan 2004 04:14:24 +0000
Subject: Re: [SPARC32] Fix BUG-on-swapout
Message-Id: <20040105201424.6297fcd4.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040106040805.GA13026@foobazco.org>
In-Reply-To: <20040106040805.GA13026@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 5 Jan 2004 20:08:05 -0800
Keith M Wesolowski <wesolows@foobazco.org> wrote:

> This fixes BUG-on-swapout for srmmu-based systems.  The problem is
> caused by kmap_atomic_to_page being fed an aliased (pagetable) address
> and returning bogons.  This also adjusts the pkmap and fixmap base
> addresses so they cannot overlap.
> 
> Dave, unless it's braindead, please apply.

Looks good, I'll apply.

Thanks Keith.
