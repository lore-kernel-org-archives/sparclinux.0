From: David Miller <davem@davemloft.net>
Date: Tue, 12 May 2020 20:04:57 +0000
Subject: Re: [PATCH 1/3] sparc64: enable HAVE_COPY_THREAD_TLS
Message-Id: <20200512.130457.1412393753257936462.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
        <20200512171527.570109-2-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: christian.brauner@ubuntu.com
Cc: arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 19:15:25 +0200

> +sys_vfork:
> +	flushw
> +	ba,pt	%xcc, sparc_vfork
> +	add	%sp, PTREGS_OFF, %o0

Please follow the convention of indenting an extra space before
instructions in the delay slot of branch instructions.

> +	ba,pt	%xcc, sparc_fork
> +	add	%sp, PTREGS_OFF, %o0

Likewise.

>  sys_clone:
>  	flushw
> -	movrz	%o1, %fp, %o1
> -	mov	0, %o3
> -	ba,pt	%xcc, sparc_do_fork
> -	 add	%sp, PTREGS_OFF, %o2
> +	ba,pt	%xcc, sparc_clone
> +	add	%sp, PTREGS_OFF, %o0

Likewise.
