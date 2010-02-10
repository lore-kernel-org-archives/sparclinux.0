From: David Miller <davem@davemloft.net>
Date: Wed, 10 Feb 2010 20:51:16 +0000
Subject: Re: [PATCH] sparc: Align clone and signal stacks to 16 bytes.
Message-Id: <20100210.125116.193618581.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100209.165006.142022647.davem@davemloft.net>
In-Reply-To: <20100209.165006.142022647.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 10 Feb 2010 12:12:17 -0800 (PST)

> From: Dennis Gilmore <dennis@ausil.us>
> Date: Wed, 10 Feb 2010 13:59:00 -0600
> 
>> http://sources.redhat.com/bugzilla/show_bug.cgi?id855
> 
> As the patch in this bug does, it should be fixed in glibc.

As an update I just learned about this commit:

http://sourceware.org/git/?p=glibc.git;a=commitdiff;hj147cc6e402e7167fa1213c31dc42a6fa38f52b

which should fix this problem.

It's in the feora branch, but not mainline.  But hopefully
it will propagate to mainline soon.
