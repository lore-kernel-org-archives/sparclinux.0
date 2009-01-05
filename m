From: Harvey Harrison <harvey.harrison@gmail.com>
Date: Mon, 05 Jan 2009 22:59:24 +0000
Subject: Re: [PATCH] module: clean up initialization of variable
Message-Id: <1231196364.11902.7.camel@brick>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org>
	 <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com>
	 <20090105195415.GA6204@uranus.ravnborg.org>
	 <alpine.DEB.1.10.0901051523370.25066@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901051523370.25066@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 2009-01-05 at 15:30 -0500, Steven Rostedt wrote:
> +	hdr = vmalloc(len);
> +	if (hdr = NULL)

A bit pedantic but,

if (!hdr) perhaps?

Cheers,

Harvey

