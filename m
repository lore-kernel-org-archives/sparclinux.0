From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 05:17:57 +0000
Subject: Re: [PATCH] sparc32: drop unused btfixup features
Message-Id: <20120514.011757.1531772578022178282.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513112021.GA15625@merkur.ravnborg.org>
In-Reply-To: <20120513112021.GA15625@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 May 2012 17:14:28 +0200

> On Sun, May 13, 2012 at 01:20:21PM +0200, Sam Ravnborg wrote:
>> >From d855682558cd176f326bf07e705331d72040083e Mon Sep 17 00:00:00 2001
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Sun, 13 May 2012 13:17:16 +0200
>> Subject: [PATCH] sparc32: drop unused btfixup features
>> 
>> We no longer use any of the const replacement features.
>> Also drop the support code in btfixupprep
>> 
>> Boot tested up+smp on my ss5.
>> 
>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I have started to look a bit more into the btfixup stuff.
> And I am a bit confused of what I see.
> The content on btfixup.S does not match my expectations.
> 
> I am right now not sure if I broke it somehow by this patch,
> so please do not apply!
> 
> Will take a closer look during next week and respin.

I say hold off on this, we have completely eliminating btfixup
in our sights now.

Let's blow away the remaining references and then kill btfixup off
completely with one final stroke.
