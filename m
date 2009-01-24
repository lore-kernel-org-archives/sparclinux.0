From: David Miller <davem@davemloft.net>
Date: Sat, 24 Jan 2009 03:50:42 +0000
Subject: Re: opps building sparc64 packages
Message-Id: <20090123.195042.64093493.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200901021435.23972.dgilmore@redhat.com>
In-Reply-To: <200901021435.23972.dgilmore@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 23 Jan 2009 11:31:48 -0600

> On Tuesday 20 January 2009 12:52:28 am David Miller wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Mon, 19 Jan 2009 22:35:17 -0800 (PST)
> >
> > > The code in sun4v_data_access_exception() needs some logic to properly
> > > handle the case of the kernel doing a userspace access.  Currently it
> > > does an OOPS unconditionally when triggered from kernel space, which
> > > is wrong.
> > >
> > > I'll fix this up and post a patch.
> Dave,
> 
> The patch does fix the issue.

Thanks a lot for testing.
