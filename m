From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 31 Mar 2016 05:19:41 +0000
Subject: Re: [PATCH 1/1] sparc32: fix trap number in call to kgdb_handle_exception
Message-Id: <20160331051941.GA30936@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20160330184930.GA25233@ravnborg.org>
In-Reply-To: <20160330184930.GA25233@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 30, 2016 at 08:49:30PM +0200, Sam Ravnborg wrote:
> >From ae7ae09c77621331f8aa18f2281f74640fcc39f2 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 30 Mar 2016 20:39:11 +0200
> Subject: [PATCH 1/1] sparc32: fix trap number in call to kgdb_handle_exception
> 
> While browsing this code for other reasons this disprecancy
> was noticed. It looks like the code originates from sparc64.
> 
> The trap number is in the generic code only used as argument
> to a few methods that for sparc is simple stub functions.
> So the trap number is not used, thus this patch does not
> have any functional impact.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> I was tempted to modify kgdb_trap to take the trap number
> as argument, like we do for sparc64.
> But in first try I did the minimal fix.
> 
> If you prefer I will redo the patch so we pass the
> trap number in %o1 and pt_regs in %o2 like
> we do on sparc64.
Scrap this patch.

I ended up doing as I suggested above. Needs to sort out a toolchain issue
so I at least have done a test build before I submit it.

	Sam
