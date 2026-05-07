Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6715123D283;
	Thu,  7 May 2026 01:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118108; cv=none; b=C017uQKxDtmDDw8+jwVn6pw8/ERCP00tOMxhUyjs+54e1rkdZeY6/t/7cYDoUigae61X+Lm4n1h1EjPXzgvv1V/kJ8lGgxZBvRu0uKd/7WNoaZVlL5zp0XOUEdQBTBFZrhbdiYiMCOBIhI5TlL07NPO0jAAud4lU85kvcYQh33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118108; c=relaxed/simple;
	bh=I3A5cWscMoEuGYe7noxywM4Tzupe8cCfmFvIgdz/SGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gwTEoSUYVTzythzZ7z44IZKiV53Tbruq9/DLGCjmFYg6D8NloGm+QwlqkMxEBK++ffthdo+WZdYHUuLc7Kdv2KfzjlJvSu9jBdf4lqjwjNDZGJw+BORJdt/j8qfqdKzfoX1MVRmMdhyqM6WZvNyKpc9DWIWF3AaUFfRVHxrabzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj4XLLe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj4XLLe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00BAC2BCB0;
	Thu,  7 May 2026 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118107;
	bh=I3A5cWscMoEuGYe7noxywM4Tzupe8cCfmFvIgdz/SGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bj4XLLe/8mgAZLCzPzFAi3j05BHK9TkFjj4TWH4ZAuS+4GKxkfB/X07hPJ4uLILCC
	 mRhvEiJneZfZn8SIBmoqph96qZhIQi364+FbzEcGuz99TKvVwD/q8PbPvOBtEn98p7
	 NFMYRNm6i45+B88ECI0s74jxeXv9Xt2LEXYoKU8cnyn2J8Sd6Cu7g64bSfMuCEitro
	 +DuK3289GvAMhN7OKJmR6dWQ4PJ/RUn2B6BfJsHGqek6j7Y7PynyMhHuaDMHvipSQ/
	 pOPNbz6ZT3iOaXsAwTXiZkreVxbm4DD9OjJ10G+fuPLwm4EFiXsn9bgf3wERc+YlVy
	 QEgfRTYRrBYHA==
Date: Thu, 7 May 2026 10:41:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, linux-trace-kernel@vger.kernel.org (open
 list:UPROBES), sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
 (sparc/sparc64))
Subject: Re: [PATCH] sparc64: uprobes: add missing break
Message-Id: <20260507104145.ca21edc6e4597b85e8c8b0cb@kernel.org>
In-Reply-To: <20260506031815.779909-1-rosenp@gmail.com>
References: <20260506031815.779909-1-rosenp@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 20:18:15 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> Missing fallthrough causes failure with newer compilers:
> 
> arch/sparc/kernel/uprobes.c:284:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>   284 |         default:
>       |         ^
> arch/sparc/kernel/uprobes.c:284:2: note: insert 'break;' to avoid fall-through
>   284 |         default:
>       |         ^
>       |         break;
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  arch/sparc/kernel/uprobes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
> index 305017bec164..c8cac64e9988 100644
> --- a/arch/sparc/kernel/uprobes.c
> +++ b/arch/sparc/kernel/uprobes.c
> @@ -280,6 +280,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
>  	case DIE_SSTEP:
>  		if (uprobe_post_sstep_notifier(args->regs))
>  			ret = NOTIFY_STOP;
> +		break;
>  
>  	default:
>  		break;
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
