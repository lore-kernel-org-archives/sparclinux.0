From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2014 19:34:05 +0000
Subject: Re: [PATCH] sparc64: Increase size of boot string to 1024 bytes
Message-Id: <20141007.153405.57016312007927067.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5433E6C5.9060304@oracle.com>
In-Reply-To: <5433E6C5.9060304@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 14:29:25 -0500

> I'd leave off the last sentence:
> 
> /* We limit BARG_LEN to 1024 because this is the size of the
>  * 'barg_out' command line buffer in the SILO bootloader.
>  */

Works for me.
