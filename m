From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 12 Jun 2007 14:52:16 +0000
Subject: Re: [PATCH]: Better serial console identification
Message-Id: <1181659936.3561.10.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070520.140354.92582888.davem@davemloft.net>
In-Reply-To: <20070520.140354.92582888.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2007-05-24 at 16:56 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Thu, 24 May 2007 08:12:58 -0500
> 
> > So, while I certainly don't disagree with your findings, this is not
> > the resolution to the problem.
> 
> Thanks for double checking everything Tom.
> 
> I'm going to put this patch on the back burner for now
> until I come up with some better ideas or some ways to
> diagnose this further.
> 
> I'd suggest you don't put it into your tree until I find
> a way to resolve this regression.

Well, I've spent a fair amount of time trying to figure this out, and
I'm glad to say that while I'm not exactly sure why this patch was
causing the failure, it was not this patch. I discovered that other
patches would also cause the esp driver to stop working, which was
baffling.

Eventually, I discovered the failure was the kernel configuration
options I'd chosen. When I altered the sparc32 kernel config options to
closer match those of my working sparc64 kernel config, everything
started working properly.

I've tested this patch on the SS4 with my new configuration, and it
works great. So, take this one off the back-burner and feel free to
apply. :)

Sorry for the confusion.

~spot

