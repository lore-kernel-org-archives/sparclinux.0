From: David Miller <davem@davemloft.net>
Date: Sat, 11 Jun 2011 23:08:42 +0000
Subject: Re: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <20110611.160842.2135350880385482648.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1307642718-22257-1-git-send-email-minipli@googlemail.com>
	<20110609155630.0f734351.akpm@linux-foundation.org>
	<1307711453-17412-1-git-send-email-minipli@googlemail.com>
In-Reply-To: <1307711453-17412-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: minipli@googlemail.com
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mathias Krause <minipli@googlemail.com>
Date: Fri, 10 Jun 2011 15:10:53 +0200

> The address limit is already set in flush_old_exec() so this
> assignment of USER_DS is redundant.
> 
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
 ...
> @@ -368,9 +368,6 @@ void flush_thread(void)
>  
>  	/* Clear FPU register state. */
>  	t->fpsaved[0] = 0;
> -	
> -	if (get_thread_current_ds() != ASI_AIUS)
> -		set_fs(USER_DS);
>  }

Yeah but now you're doing it unconditionally, the guard is here
because the %asi register write which set_fs() does is extremely
expensive on sparc64 and %99.99999 of the time we can avoid it.
