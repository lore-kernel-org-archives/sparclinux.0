From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 08:28:05 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <A8CFBA2A-C7EB-424A-BBF2-59A75D2412CB@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> On 26 Oct 2016, at 03:44, David Miller <davem@davemloft.net> wrote:
> 
> 
> If the number of pages we are flushing is more than twice the number
> of entries in the TSB, just scan the TSB table for matches rather
> than probing each and every page in the range.
> 
> Based upon a patch and report by James Clarke.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> James this is the final version I pushed into the tree.

Great, thanks. Any progress on TLB flushing?

James

