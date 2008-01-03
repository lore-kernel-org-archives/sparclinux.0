From: Daniel Walker <dwalker@mvista.com>
Date: Thu, 03 Jan 2008 16:01:59 +0000
Subject: Re: [RFC PATCH 01/11] Add basic support for gcc profiler
Message-Id: <1199376119.5160.39.camel@imap.mvista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080103071609.478486470@goodmis.org>
	 <20080103072226.776141236@goodmis.org>
In-Reply-To: <20080103072226.776141236@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Gregory Haskins <ghaskins@novell.com>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, "William L. Irwin" <sparclinux@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>


On Thu, 2008-01-03 at 02:16 -0500, Steven Rostedt wrote:
> Index: linux-compile.git/Makefile
> =================================> --- linux-compile.git.orig/Makefile     2008-01-03 01:02:28.000000000 -0500
> +++ linux-compile.git/Makefile  2008-01-03 01:02:39.000000000 -0500
> @@ -509,11 +509,15 @@ endif
>  
>  include $(srctree)/arch/$(SRCARCH)/Makefile
>  
> +ifdef CONFIG_MCOUNT
> +KBUILD_CFLAGS  += -pg -fno-omit-frame-pointer -fno-optimize-sibling-calls
> +else
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else
>  KBUILD_CFLAGS  += -fomit-frame-pointer
>  endif
> +endif
>  
>  ifdef CONFIG_DEBUG_INFO
>  KBUILD_CFLAGS  += -g

I'd much prefer if you used -finstrument-function since it's already
architecture independent .. It was suggested not too long ago.. There is
also another tracing patchset that is similar to this one which uses it
(KFT)..

Daniel

