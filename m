From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2014 18:57:54 +0000
Subject: Re: [PATCH] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <20141007.145754.1412151318086549496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5433E6C5.9060304@oracle.com>
In-Reply-To: <5433E6C5.9060304@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 08:12:37 -0500

> This is the longest boot string that silo supports.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Ok, given how the rest of this thread went, the comment needs to
be adjusted to match reality which is something like:

/* We limit BARG_LEN to 1024 because this is the size of the
 * 'barg_out' command line buffer in the SILO bootloader.  And
 * it trusts bootstr_len over that buffer's size.
 */

Right?
