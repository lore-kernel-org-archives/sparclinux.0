From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 17 Apr 2007 02:27:49 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <1176776869.4182.2.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2007-04-16 at 15:21 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Mon, 16 Apr 2007 15:56:25 -0500
> 
> > Yep. Absolutely. Aurora's got this patch in it, to have the old behavior
> > on FB ordering, since people expect it.
> 
> Yes that would maintain the status-quo from ages ago, but
> it still doesn't actually fix the core problem :-)

Which is why I never actually submitted that patch upstream. It's a
hack. :)

> Oh btw, Tom, does my scsi bus reset patch help your SS4 at all? :-)

Yes, but I'm waiting for testing with a CDROM hanging off the bus before
I send the all clear.

~spot

