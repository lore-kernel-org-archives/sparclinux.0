From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 11 Feb 2006 12:15:47 +0000
Subject: Re: [PATCH] sparc32: Fix div, udiv, mul, umul, rem, urem breakage
Message-Id: <20060211121547.GQ27946@ftp.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20060211113817.GA25564@palantir8>
In-Reply-To: <20060211113817.GA25564@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Feb 11, 2006 at 03:51:20AM -0800, William Lee Irwin III wrote:
> On Sat, Feb 11, 2006 at 11:38:17AM +0000, Martin Habets wrote:
> > Thanks for explaining. As far as I remember this all started with
> > the cleanup of an ugly #define, but I could be wrong there.
> 
> Acked-by: William Irwin <wli@holomorphy.com>

NAK.

a) namespace pollution()
b) it was a lot more than ugly #define, RTFArchives, please
