From: Nicholas Leippe <nick.leippe@whitecanyon.com>
Date: Sun, 18 Jan 2009 23:21:21 +0000
Subject: Re: config for v880
Message-Id: <200901181621.21213.nick.leippe@whitecanyon.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200901160946.41267.nick.leippe@whitecanyon.com>
In-Reply-To: <200901160946.41267.nick.leippe@whitecanyon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun Jan 18 2009 00:16:03 you wrote:
> Herman L. is reporting a similar problem that I need to get
> back to.
>
> Have you saved a failed boot log and could you post it here
> if so?  That might help us find this bug.

I have no experience w/kernel debugging yet.
What debug options would be most valuable to enable?
I'll be happy to build & boot any kernel you want to try to solve this.

I have built all my kernels on a sparc64 gentoo box w/gcc 4.1.2.

So far, I've had it hang at various different points.

One of which is at:

...
console handover: boot [earlyprom0] -> real [tty0]

another (which was on a 480r, not sure if same prob on 880) was:

...
rtc0 = alarms up to one no, 114 bytes nvram

notice the "no" instead of "month" for example.

I've also seen it hang on the 880 at other places.
So, I'm not really sure where it's dying.

-- 
Nicholas Leippe

