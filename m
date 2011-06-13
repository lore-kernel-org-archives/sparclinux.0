From: Mathias Krause <minipli@googlemail.com>
Date: Mon, 13 Jun 2011 20:28:20 +0000
Subject: Re: [PATCH] sparc, exec: remove redundant addr_limit assignment
Message-Id: <09961391-F83F-4499-A0A3-00AA5C2028CE@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1307642718-22257-1-git-send-email-minipli@googlemail.com> <20110609155630.0f734351.akpm@linux-foundation.org> <1307711453-17412-1-git-send-email-minipli@googlemail.com> <20110611.160842.2135350880385482648.davem@davemloft.net>
In-Reply-To: <20110611.160842.2135350880385482648.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 12.06.2011, at 01:08 David Miller wrote:
> From: Mathias Krause <minipli@googlemail.com>
> Date: Fri, 10 Jun 2011 15:10:53 +0200
> 
>> The address limit is already set in flush_old_exec() so this
>> assignment of USER_DS is redundant.
>> 
>> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> ...
>> @@ -368,9 +368,6 @@ void flush_thread(void)
>> 
>> 	/* Clear FPU register state. */
>> 	t->fpsaved[0] = 0;
>> -	
>> -	if (get_thread_current_ds() != ASI_AIUS)
>> -		set_fs(USER_DS);
>> }
> 
> Yeah but now you're doing it unconditionally, the guard is here
> because the %asi register write which set_fs() does is extremely
> expensive on sparc64 and %99.99999 of the time we can avoid it.

As Linus already pointed out, that set_fs() was never called because
we already had (and still have) an unconditional set_fs() in the arch
independent code. So this patch just removes some dead code.

Mathias
