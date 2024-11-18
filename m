Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486E1547E8;
	Mon, 18 Nov 2024 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920218; cv=none; b=sjSM+b63zY8P2W8Y2tLwZc03Pg+NfbWnHTxj4CJHqYRQXeqOoA35LyfE153y/KXXwNs0CSDEWmZsmKRBmMAJbuSb8tAiWFV85Jx4Igw1at7LtwhD0xD49HXtDQL+cWCpYz4u4gaR79Taz5e1zEdSAuuF0Ef47wqQEXYbDr/ocaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920218; c=relaxed/simple;
	bh=2U7wGQ9m2NCDWn7AGB2gkQ9TsQ3ZFz7HnNSljH6wIwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6UO2gArWw08Nzs9FG4dKuC6gdSrgfkVuvHIJaZFtbuP4MD1WMwXBrRwPvzfpjh8Nvhv9tEHMrgVj0WB//FpcqcUXR7/SsipRL3Wk1NrLiw1dCir7KVTKndL6BpRx/dJUzPuC0iU2UGwAy7xjvxTxCkMGpMJY/iowDVK8i6MjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kKJM8VXZ; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kKJM8VXZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4XsM1n5qNPz1DHYn;
	Mon, 18 Nov 2024 09:56:45 +0100 (CET)
Received: from [10.10.15.6] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4XsM1n1wZ8z1DHYt;
	Mon, 18 Nov 2024 09:56:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1731920205;
	bh=AZ2xmScEhh4sMIaYAomJrulPARaT80ep1DcAlgorYws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kKJM8VXZPx50OpbtfTmKJO0DWFKcfv+7yMhBeib4mYxufmI8oe3r8lJ43S1xkLIDF
	 ljYmQWSy5DwsrIvoC5oECW/Z3oZA2941zGc7gj8ADOXSU0HVrGsU6OiN6K0I1BPvlM
	 t3sX5DzjgZndl7RxnxTjm+4E6gWKOOop3PozEj9Q=
Message-ID: <0963a508-6014-43e4-b64c-89b09538b68e@gaisler.com>
Date: Mon, 18 Nov 2024 09:56:44 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc/vdso: Add helper function for 64-bit right shift
 on 32-bit target
To: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
 <1b2e776e-0ae3-4f48-a2b9-99b486d49368@gaisler.com>
 <gecz9pMRccdD2v_dImhonTGStG4FmiUko8IM2fkc9Rh2thw_QuSOvlsYTspZSf9bjtidQOD2uVL2aSaQ29-neWABRm1cpyXQr6xV0wELTU0=@protonmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <gecz9pMRccdD2v_dImhonTGStG4FmiUko8IM2fkc9Rh2thw_QuSOvlsYTspZSf9bjtidQOD2uVL2aSaQ29-neWABRm1cpyXQr6xV0wELTU0=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-17 00:44, Koakuma wrote:
> Andreas Larsson <andreas@gaisler.com> wrote:
>> Koakuma via B4 Relay wrote:
>>> +notrace static __always_inline u64 __shr64(u64 val, int amt)
>>> +{
>>> + u64 ret;
>>> +
>>> + asm volatile("sllx %H1, 32, %%g1\n\t"
>>> + "srl %L1, 0, %L1\n\t"
>>> + "or %%g1, %L1, %%g1\n\t"
>>> + "srlx %%g1, %2, %L0\n\t"
>>> + "srlx %L0, 32, %H0"
>>> + : "=r" (ret)
>>> + : "r" (val), "r" (amt)
>>> + : "g1");
>>> + return ret;
>>> +}
>>
>> Can not residual in bits 63:32 of %L0 potentially pose a problem?
> 
> It shouldn't be a problem, upon returning the caller should treat
> the upper bits of %L0 as an unspecified value and not depend on/use
> its contents.

Yes, of course. Lapse of logic on my part.

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas
