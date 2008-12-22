From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Dec 2008 22:31:52 +0000
Subject: Re: Unify module.*
Message-Id: <20081222223152.GC30716@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081222220745.GA30716@uranus.ravnborg.org>
In-Reply-To: <20081222220745.GA30716@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> I think it should be safe to do:
> 
> 		BUG_ON(((unsigned long)location >> (unsigned long)32) !> 		       (unsigned long)0);
> 
> As to my best understanding unsigned long
> is 32 bit on sparc32 and 64 bit on sparc64.
> So we should with the above code not get any warnings.
> 
> But I did not really see the point of the BUG_ON in the first place,
> and my limited digging did not turn up when it was added.
> 
> So to be safe I kept the ugly ifdef for now.
> If is easy to spot/remove.

And just tell me and I will respin the patch serie
with this or any other modifications requested.

Just to make sure this was explicitly stated.

	Sam
