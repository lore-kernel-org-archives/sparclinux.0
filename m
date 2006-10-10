From: David Miller <davem@davemloft.net>
Date: Tue, 10 Oct 2006 21:21:21 +0000
Subject: Re: [PATCH 1/4] fix sparc32 modpost warnings
Message-Id: <20061010.142121.34759537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061010154416.GB30909@palantir8>
In-Reply-To: <20061010154416.GB30909@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 10 Oct 2006 16:44:16 +0100

> Subject: [PATCH 1/4] fix sparc32 modpost warnings
> 
> Fix these 2.6.19-rc1 build warnings from modpost:
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text:_sinittext from .text between 'core_kernel_text' (at offset 0x3e060) and '__kernel_text_address'
 ...
> @@ -36,11 +36,11 @@
>  
>    . = ALIGN(4096);
>    __init_begin = .;
> +  _sinittext = .;
>    .init.text : { 
> -	_sinittext = .;
>  	*(.init.text)
> -	_einittext = .;
>    }
> +  _einittext = .;
>    __init_text_end = .;
>    .init.data : { *(.init.data) }
>    . = ALIGN(16);

This doesn't make any sense.  No other architecture specifies
the init sections in this way in their vmlinux.lds.S file.
Why is this change correct?

Can you try to track down the real problem that causes this
and then explain it clearly in the patch that you end up
posting?

I have trouble applying patches that are of the form "get rid
of this warning" with zero explanation for the reasoning
behind the fix being proposed :-)
