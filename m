From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 10:18:32 +0000
Subject: Re: [PATCH] sparc32: avoid build warning at mm/percpu.c:1647
Message-Id: <20110420101832.GB32415@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303293448-13168-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 20, 2011 at 11:57:28AM +0200, Daniel Hellstrom wrote:
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  arch/sparc/include/asm/pgtable_32.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

I guess this is the same warnign that has annoyed me.
In general always include the warning that you fix,
so we can google for it etc.

	Sam
