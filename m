Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BE1E1A3B;
	Fri,  6 Dec 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473674; cv=none; b=UIdsPo+WHXNaKwXoRzuia/TrxgJXJkiflW3qkhBf7+vVfaMNrM09Y6QmoKzxDTfFcHLZltCUoSHiz9juC8rDrdhkmnlfj4AcUFpEV8VgF6wdUp7+CRsJZW570mnZSePuovu49pLmaPeDWbvTra0KpXyX1E8wZ614BtFshedA63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473674; c=relaxed/simple;
	bh=yg9cG3z9v1uGca8OxptmQy1is0mfUpEEq8+L2Ssfyr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEQChm5Gc3UPvGWTVhO+WrnjaOqnx1954L5AHigLJ/PsETwXrkcHAvSpEqM/kq7DbUkNWpeske1i02pnevfM9xTAytK2cw+HkWc0LjzOm2152+XP6lGKnJntrghdC3yJhFFkkBfGLOgyKOKOB6N0K+BoM25INxqle8ZMu6dOTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=IrSORVTE; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="IrSORVTE"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Y4PLt09zWz1DDBf;
	Fri,  6 Dec 2024 09:19:50 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Y4PLs4HbZz1DHWD;
	Fri,  6 Dec 2024 09:19:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1733473189;
	bh=4urAkc/3MHuHZa0TymfWY2lk/3IpIrXpJmcfgt0ecRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IrSORVTEhTWWKSevKebjQvY3EuBImCZO7FrBxuM2yJQuTGvxgq5v4O03Zwjd7eLWN
	 xzNIDXgbAV/iaa4L42LFFGzz2d3kGZDUSq76DgjbW67M84R6pqnZbyg0pYXSRXWvSC
	 lwvkvAReC7MFUM2IU6/V2S1UAvnu0hy/FulzCUGs=
Message-ID: <6bc7817c-6044-4999-b901-1b87e88fef42@gaisler.com>
Date: Fri, 6 Dec 2024 09:19:49 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Move va_end() before exit
To: liujing <liujing@cmss.chinamobile.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204112145.6987-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20241204112145.6987-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-04 12:21, liujing wrote:
> [PATCH] sparc: Move va_end() before exit

Please use exit() rather than exit also here. As it is the calls you are
swapping order of and not an implementation perhaps phrase it "Call
va_end()..." or "Move va_end() call..." or something like that. Please
also indicate where this change is happening, not just in sparc.

> This patch makes a minor adjustment by moving the va_end call before
> exit. Since the exit() function terminates the program, any code
> after exit(1) is unreachable thus notexecuted. Placing va_end before
> exit ensures that the va_list is properly cleaned up.

Please also describe how you found this.

> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
> index dc81240aab6f..372e3330850a 100644
> --- a/arch/sparc/vdso/vdso2c.c
> +++ b/arch/sparc/vdso/vdso2c.c
> @@ -90,8 +90,8 @@ static void fail(const char *format, ...)
>  	vfprintf(stderr, format, ap);
>  	if (outfilename)
>  		unlink(outfilename);
> -	exit(1);
>  	va_end(ap);
> +	exit(1);
>  }
>  
>  /*

Cheers,
Andreas
