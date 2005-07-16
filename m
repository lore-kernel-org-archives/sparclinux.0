From: Bob Breuer <breuerr@mc.net>
Date: Sat, 16 Jul 2005 16:29:06 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <42D935D2.4070706@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Bob Breuer wrote:
> 
> My suspicion is that highmem may cause problems.  I'll try rearranging 
> the ram this weekend and see if I can make an initrd fail.

Yes, there are problems with highmem on hypersparcs.

With ext3 root and ext3 as a module in the initrd and 3x64MB:
  banks 0,1,2 - boots ok
  banks 0,5,6 - failed to mount root (tested both 2.6.11 and 2.6.12)
error message was "mount: error 15 mounting ext3"

I also tested the latest Aurora corona kernel (2.6.11-1.1166sp1) and it 
mounted root without problems.

And I tried appending "memdM", but it crashed before initializing the 
console (-p showed an endless loop of errors).

Hope that helps,
Bob
