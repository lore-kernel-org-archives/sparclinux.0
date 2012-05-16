From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 May 2012 12:39:46 +0000
Subject: Re: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <20120516123946.GA854@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514202951.GA4439@merkur.ravnborg.org>
In-Reply-To: <20120514202951.GA4439@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > 
> > All other differences looks manageable if we can find a way around
> > the ASI_M_MMUREGS issue.
> > 
> But I think we should resolve the remaining issues that keep LEON
> builds from working on other cpus first, because the thing you're
> after will fall transparently out of that.
> 
> For one thing there is no reason in the world to have a different
> value of ASI_M_MMUREGS.

Konrad / Daniel - any inputs on why LEON uses a different ASI?
As we uses this in head_32.S this is really annoying...

	Sam
