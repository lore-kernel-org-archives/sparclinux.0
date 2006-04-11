From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Apr 2006 06:36:08 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060410.233608.88038021.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Mon, 10 Apr 2006 23:12:07 -0700

> The bottom line somehow the writing of the header is not being done 
> correctly. If it's fdisk or something related to the kernel, that's what 
> I'm trying to determine.

So let's start from the very beginning.

If you have an existing system that works, and you run a gcc-4.1
compiled kernel on it, does that work?
