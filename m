From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 02:20:39 +0000
Subject: Re: PATCH [0/14] sparc32: removal of sun4c platform support
Message-Id: <20120511.222039.1182638322706775780.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120511213143.GA1518@merkur.ravnborg.org>
In-Reply-To: <20120511213143.GA1518@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 23:31:44 +0200

> This is the bulk of the removal of sun4c support.
> I have tried to be careful not to break the build
> during the removal process.
> 
> I like the diffstat summary:
> 
>  36 files changed, 75 insertions(+), 3726 deletions(-)
> 
> The final result is boot tested on my ss5 box.
> I also boot tested a few of the steps.
> 
> So all-in-all I feel rather confident about this
> patch-set.

Thanks for doing this work, I'll review this stuff now.

This opens up some exciting possibilities, for example we
can also ditch Cypress sun4m support and therefore eliminate
the software integer multiply/divide stuff and thus build
the kernel with -mcpu=v8 or similar.
