From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Mon, 25 Jun 2018 16:41:09 +0000
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
Message-Id: <20180625164109.GF30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180625163410.216168-1-jannh@google.com>
In-Reply-To: <20180625163410.216168-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, security@kernel.org, Christoph Hellwig <hch@infradead.org>, Serge Hallyn <serge@hallyn.com>

On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:

> +	char tmp[32];
>  
> -	if (namelen > 32)
> +	if (namelen < 0 || namelen > 32)
>  		namelen = 32;
>  
>  	down_read(&uts_sem);
>  	kname = utsname()->domainname;
>  	len = strnlen(kname, namelen);
> -	if (copy_to_user(name, kname, min(len + 1, namelen)))
> -		err = -EFAULT;
> +	len = min(len + 1, namelen);
> +	memcpy(tmp, kname, len);
>  	up_read(&uts_sem);
>  
> -	return err;
> +	if (copy_to_user(name, tmp, len))
> +		return -EFAULT;

Infoleak, and similar in a lot of other places.
