From: Joseph Myers <joseph@codesourcery.com>
Date: Fri, 18 Dec 2015 13:10:32 +0000
Subject: Re: [PATCH] sparc: Add all necessary direct socket system calls.
Message-Id: <alpine.DEB.2.10.1512181309400.32726@digraph.polyomino.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20151217.224753.1441573007785005706.davem@davemloft.net>
In-Reply-To: <20151217.224753.1441573007785005706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 18 Dec 2015, David Miller wrote:

>  #define __NR_membarrier		351
> +#deifne __NR_bind		352
> +#deifne __NR_listen		353
> +#deifne __NR_setsockopt		354

"#deifne" can't be correct....

-- 
Joseph S. Myers
joseph@codesourcery.com
