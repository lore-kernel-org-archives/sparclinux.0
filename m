From: David Miller <davem@davemloft.net>
Date: Wed, 16 Sep 2009 17:19:24 +0000
Subject: Re: [PATCH v2] sparc: Clean up linker script using new linker
Message-Id: <20090916.101924.186960949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1253119592-19598-1-git-send-email-tabbott@ksplice.com>
	<1253119592-19598-2-git-send-email-tabbott@ksplice.com>
In-Reply-To: <1253119592-19598-2-git-send-email-tabbott@ksplice.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tabbott@ksplice.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, geofft@ksplice.com

From: Tim Abbott <tabbott@ksplice.com>
Date: Wed, 16 Sep 2009 12:46:32 -0400

> @@ -51,70 +51,27 @@ SECTIONS
>  	_etext = .;
>  
>  	RO_DATA(PAGE_SIZE)
> -	.data :	{
> -		DATA_DATA
> -		CONSTRUCTORS
> -	}
>  	.data1 : {
>  		*(.data1)
>  	}
> -	. = ALIGN(SMP_CACHE_BYTES);
> -	.data.cacheline_aligned : {
> -		*(.data.cacheline_aligned)
> -	}
> -	. = ALIGN(SMP_CACHE_BYTES);
> -	.data.read_mostly : {
> -		*(.data.read_mostly)
> -	}
> +	RW_DATA_SECTION(SMP_CACHE_BYTES, 0, THREAD_SIZE)
> +

Can you do this cleanup without moving the relative locations of .data
and .data1 sections?
