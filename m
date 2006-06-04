From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2006 06:41:35 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <20060603.234135.63130873.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 3 Jun 2006 12:01:24 -0700 (PDT)

> On Fri, 2 Jun 2006, David Miller wrote:
> 
> > Great, please watch for any dpkg database file corruption.  That's the
> > reason all of this started :)
> 
> I've finally got to reinstalling my machine and re-run the same 
> upgrade/install which triggered the bug last time. With patched up kernel 
> everything worked fine. Thanks a lot for taking care of it so fast, Dave.

Thanks for testing.
