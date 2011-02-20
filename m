From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Feb 2011 13:01:01 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq support
Message-Id: <20110220130101.GA10317@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1298130424-6934-4-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298130424-6934-4-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Josip.

> In this case the diff output isn't really useful, it has to be re-diffed
> manually to see the actual difference. Granted, it's nothing important
> in this case, but you should try to keep the mostly identical functions in
> the same place in the same commit, and then move the new version into
> a new place in a later commit, so that functional changes don't get
> obscured by formatting changes.

The sun4d_irq file almost saw an rewrite and as part of this I had
to move the sun4d_init_timers function to avoid a forward declaration.
I will try to do so in a preparational patch in v3 - the patch is
in no way easy to review as it rewrites so much in one go :-)
> 
> (Sorry not to be of any actual help - the oldest sparc machine I have access
Peer review is great - please continue to do so!

> to is an Ultra 5, and even that one is so slow that it makes the simple act
> of compiling the kernel to test it - really tedious *shrug* :)
I always build my kernels on my snappy Intel box (Intel Atom dual-core).
I have a patch to crosstool-ng that I need to dust off and get submitted
so it is trivial for others to build sparc toolchains too.
But my sparc todo list is growing atm...

	Sam
