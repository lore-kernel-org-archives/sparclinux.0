From: David Miller <davem@davemloft.net>
Date: Tue, 13 Aug 2013 19:07:41 +0000
Subject: Re: broken PCI mmap confession
Message-Id: <20130813.120741.1456436973036093068.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CACVxJT_vFSQUuRQG6-ZGw6oeD60Q9fAZUp1AWvVGVxv=FJHLzA@mail.gmail.com>
In-Reply-To: <CACVxJT_vFSQUuRQG6-ZGw6oeD60Q9fAZUp1AWvVGVxv=FJHLzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 13 Aug 2013 15:08:14 +0300

> 6 years passed, code still the same, noone complained (at least to me).
> What should I do?

Fix it?

The only major user is the graphics card MMAP'ing done by the X server.
And not to many people use sparc as a desktop any more, that's why it
hasn't been noticed.

I used to keep making sure it kept working, but I'm on an x86 desktop
these days so haven't been doing so lately.
