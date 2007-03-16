From: David Miller <davem@davemloft.net>
Date: Fri, 16 Mar 2007 01:01:29 +0000
Subject: Re: sparc32 esp connected CDROM failures
Message-Id: <20070315.180129.18287630.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
In-Reply-To: <1173976389.16911.13.camel@dhcp-32-109.ord.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 15 Mar 2007 11:33:09 -0500

> While this isn't technically a blocker for Aurora, its a rather big
> annoyance. Not sure where to look on how to fix this one, but very
> willing and able to test. First test will be with a gcc34 built kernel
> to rule out compiler.

Let me see if the same bug triggers with current trees on my
sparc64 sbus machines.  I tested those, but I don't think I
hit CDROM's.  :-/
