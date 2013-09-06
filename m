From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 06 Sep 2013 12:58:39 +0000
Subject: Re: [PATCH] sparc64: Export flush_ptrace_access() (needed by lustre)
Message-Id: <20130906125839.GB6396@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1378372110-19094-1-git-send-email-geert@linux-m68k.org>
 <20130906125613.GA6396@infradead.org>
In-Reply-To: <20130906125613.GA6396@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 06, 2013 at 05:56:13AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 05, 2013 at 11:08:29AM +0200, Geert Uytterhoeven wrote:
> > ERROR: "flush_ptrace_access" [drivers/staging/lustre/lustre/libcfs/libcfs.ko]
> > undefined!
> 
> This seems to be more copy_to_user_page fallout, so instead of all these
> arch patches we should figure out why lustre absolutely wants to use
> this API that so far has been for core MM code only.

Looking at the code is seems to be for a reimplementation of
__access_remote_vm.  So at very least it should use that, but I still
requiestion why it's doing that at all.

Geert, please don't just export stuff for staging/ use only.   Code
wouldn't be in staging if it weren't a steaming pile of junk, so
adjusting anyting in the real tree for it needs proper discussion first.

