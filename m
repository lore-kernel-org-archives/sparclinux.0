From: David Miller <davem@davemloft.net>
Date: Mon, 06 Jan 2014 18:16:21 +0000
Subject: Re: [PATCH] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <20140106.131621.1483599790873673521.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <52AF6A0C.4000400@oracle.com>
In-Reply-To: <52AF6A0C.4000400@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hugh Dickins <hughd@google.com>
Date: Mon, 6 Jan 2014 00:42:34 -0800 (PST)

> On Sat, 4 Jan 2014, David Miller wrote:
>> But I wonder about the original bug that Hugh was trying to
>> fix :-/
> 
> That worried me too, but I think you're okay.  I bet your
> b270ee8a9fc9 "sparc64: Fix offset calculation in compute_size()"
>     
>     The fault address is somewhere inside of the buffer, not
>     before it.
> 
> , also included in 2.6.38, was the actual fix to that bug.

That does seem to account for it, thanks Hugh.
