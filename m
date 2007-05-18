From: David Miller <davem@davemloft.net>
Date: Fri, 18 May 2007 21:45:27 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <20070518.144527.85722422.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 19 May 2007 23:44:53 +0200

> I overcame the problem with too big kernel with the attached patch, but 
> I run into another problem. Now, the silo says:

You haven't told us why you simply cannot make the kernel
smaller by building more things as modules, why kill yourself
with all of these SILO and kernel hacks when you can solve
your problem more easily?
