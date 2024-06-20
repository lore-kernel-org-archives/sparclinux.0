Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8C3CF6A;
	Thu, 20 Jun 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884176; cv=none; b=EfXDoZei12u0MLW0ZRCmjHB4GGeUj9nWUTDdMLQVf9xov5STJTBIQEiD07c0vVCfMM2G6+gq+FcG6muqmucM4mE1jlqdwQZks9tDDHbQu/fI668i0fTJehqkV7285y0Wrq9HmYc5GNQWRyd4A+UxbiwvDSCLQKIJf3EfUIpeWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884176; c=relaxed/simple;
	bh=dY8z+smoB7m2JuIIGgKesBPayVZV0SvtARYT3rVvhvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GF7Jzomcmz3zNhVGi8QTkyAwWCyCKn9DMMZppTOWtx4kvizoDqyJ1jc1ffSUIaBJ/D/qpS6Fd3T9pFvT+nDqzElAONBd3BefoYaiDj+TsFC8izQQEGgCHPQ2JU8N1OfvcevR8RKc/ULFg3npasmWjWKVsyIYHT3fOmyMU7gEXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TNfv5+js; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TNfv5+js"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4W4dqj1SZxz67xy;
	Thu, 20 Jun 2024 13:41:37 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4W4dqh6S7gz680P;
	Thu, 20 Jun 2024 13:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1718883697;
	bh=fRfd3BQtT7px5Q7LqnzxUXpp3PwV32t2tLWoVB0AXGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TNfv5+jsGU315+0/fG1eyBCiE9nAjozPshqaWQl8sLPaF33ct0AIX1CGZz1axyZev
	 dwnP+1aww/F/qsVMv1j5mdYpMxHB0X6Jzmuf/2dQwNCjChDb3RdIe1Y0jd0lumhinW
	 TjW2XeLu6ns9w3Z/sRk4ottzcCFTVart03c3ZUrQ=
Message-ID: <74331eda-9582-48f7-a343-1dd0e785323d@gaisler.com>
Date: Thu, 20 Jun 2024 13:41:36 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build regressions/improvements in v6.10-rc3
To: Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
 <20240610071049.933142-1-geert@linux-m68k.org>
 <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>
 <20240611173739.GB545417@ravnborg.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240611173739.GB545417@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-11 19:37, Sam Ravnborg wrote:
> Hi Andreas,
> 
> On Mon, Jun 10, 2024 at 09:28:25AM +0200, Geert Uytterhoeven wrote:
>> On Mon, 10 Jun 2024, Geert Uytterhoeven wrote:
>>> JFYI, when comparing v6.10-rc3[1] to v6.10-rc2[3], the summaries are:
>>>  - build errors: +6/-1
>>
>>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x34), (.fixup+0x10), (.fixup+0x0), (.fixup+0x28), (.fixup+0x4), (.fixup+0x18), (.fixup+0x20), (.fixup+0x1c), (.fixup+0x8)
>>   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
>>   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
> 
> Did you have something in a local branch that would address this?
> I have no idea how to fix it.
Hi Sam,

Yes, I'll try to get it sent next week.

Cheers,
Andreas

