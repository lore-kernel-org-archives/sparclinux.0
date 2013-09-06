From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 06 Sep 2013 12:56:13 +0000
Subject: Re: [PATCH] sparc64: Export flush_ptrace_access() (needed by lustre)
Message-Id: <20130906125613.GA6396@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1378372110-19094-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1378372110-19094-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 05, 2013 at 11:08:29AM +0200, Geert Uytterhoeven wrote:
> ERROR: "flush_ptrace_access" [drivers/staging/lustre/lustre/libcfs/libcfs.ko]
> undefined!

This seems to be more copy_to_user_page fallout, so instead of all these
arch patches we should figure out why lustre absolutely wants to use
this API that so far has been for core MM code only.

