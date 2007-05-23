From: David Miller <davem@davemloft.net>
Date: Wed, 23 May 2007 22:57:45 +0000
Subject: Re: [PATCH]: Better serial console identification
Message-Id: <20070523.155745.102122154.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070520.140354.92582888.davem@davemloft.net>
In-Reply-To: <20070520.140354.92582888.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 23 May 2007 16:56:59 -0500

> On Wed, 2007-05-23 at 14:27 -0700, David Miller wrote:
> > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > Date: Wed, 23 May 2007 14:04:02 -0500
> > 
> > > Just for kicks, I tried passing esp_bus_reset_settle, but it doesn't
> > > change the result at all.
> > > 
> > > I also grabbed a log with esp_debug 47, that log is attached.
> > 
> > Does this fix the problem?
> 
> Nope. No change. Do you want the esp_debug 47 from that?

No, thanks for testing.

I'll dig some more.
