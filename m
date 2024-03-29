Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A3139D16
	for <sparclinux@vger.kernel.org>; Fri, 29 Mar 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743071; cv=none; b=DH6YhxMVUyK1tydcbeK6urVTdesm+YMaLsjimBNzJQ1qEAHORT2galDjknYmpOMq1E2Z+YRBJc4BXkPQzHdixfkFTXwP9PiGcIX2tfs7LpyGji4zWMzYkUtyUCiwC6EMKXNF6AFO6gUxZsG+iB/E4RIyqQyN/Lp+HYLd61+X2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743071; c=relaxed/simple;
	bh=JFOQEXfKJj6L95cbNdEhqXmDor0VdRGOyQdHZQcmfBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrS/ZFBEfAubrwCD7nLg+fPgrFZgQ+bBFVuUwBr3uMXvVIYO9RKqV9f+FQy9vxYqV1nnkSkyhkTfn+Az1gpZJwobwGOBQLuTOyM8Yu3B7l+IqcUuS2iUS4SjQTstY0+CU5plQgFoD64GTfhIV+in3hxTsbRE2MShm+Az0DJ/upY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=eGnal7S9; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="eGnal7S9"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789ddcd57f4so138036185a.2
        for <sparclinux@vger.kernel.org>; Fri, 29 Mar 2024 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711743069; x=1712347869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLdrq5ApysJPOm9cC9+h8scwdpRx9Rxz159Ug4BYLkQ=;
        b=eGnal7S9fPkzGHWD28wmWPX+DSadOBiG3QCbh3EZXgiBvPtk0WT0rxaLUXDCzETc92
         usUmqOLiQNnbSksJ7nYeQOoI3WsQVpFtLkCpjh5Se4AS5QDsd+5xKGVq3IR/My9s1e4o
         od4zn/gMhh/xMHJ6uZTUoyv+AgDYzg5m9wpk5ukf0ZaUynEy7jqkVPh41ZyuLRsfN58b
         f2e7suqd+hB7vWEbtyKjJwe8F2JI6pQLGXkzKtGFlFUrlNnnRK/bG6vCVuWZ7zb5d7Ki
         qA+HENIklp7SD3B+kueaUbzZqNr2Y8UhWD9alYrtGX6V1hoAGNKW1G6ruIfXouAvWl6N
         /epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743069; x=1712347869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLdrq5ApysJPOm9cC9+h8scwdpRx9Rxz159Ug4BYLkQ=;
        b=e3gClXAsmiFcQAcYEdE8DLMYC4/i/qTBmVP9CdyogDwRfi1G76RxdHCY7JnUIcUEM3
         Jd93kBOYobiSlwYBo1MnA9+IMBiAp6CD2o5YElpAW9Xvbv3hNboimnwplPXJQQkoxikW
         UDgxU1mZBafeFcVxchZODw/jHWk2Z1dAa8diZHR8Eypfx7T96xSxr/8Jkdanb8vLsXZD
         trMKtI4YoFqIm5BnDKngyYeokbHWZhQqEqHFJvqgiGTeZJ4UTnEkwVUWm5G2YTEjoMCj
         cVXJ4owrs94NGrv49q5EY84SxRWgHz6oIG/7AxsiaVc4IAHtAym/cEaRldFhBqdSWXQm
         QAPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9i5BTCj9AmD3zgvMT0IFOWF+dYSia7deEcYtyjBbGuduD31RWkpylDD0XIhYPYynit90pRUy+5otQ5wAtixJ79zVQboLEF8WYew==
X-Gm-Message-State: AOJu0YxjUUHwtNOOrLlHgOgTLftrWsKHlXYTlDfMQ9hqAd+cPDJ6OiZb
	dbW95Lx/Jr5W+hGU0ISbzmqWfwwILdUlVbhRwigqCWP43hAujAdYbAi/Yzsr+KCR/FfzuC9QG0B
	4Fe8=
X-Google-Smtp-Source: AGHT+IF6m8gLB1IT6KnRdGCEpVEVEafj0Co9hKlODWBQcr9Sla0q1oME3n9YfdiX5aJhbEn2RLaxRg==
X-Received: by 2002:a05:620a:224:b0:788:4891:53d0 with SMTP id u4-20020a05620a022400b00788489153d0mr3458538qkm.30.1711743069122;
        Fri, 29 Mar 2024 13:11:09 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id 10-20020a05620a04ca00b0078a6a010d81sm1600271qks.49.2024.03.29.13.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 13:11:08 -0700 (PDT)
Message-ID: <a7c155ed-71fc-4ed9-a8c8-f98024b74651@draconx.ca>
Date: Fri, 29 Mar 2024 16:11:06 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Content-Language: en-US
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
 <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
 <943c6d11-e214-43c8-8813-8e1aba6be15c@draconx.ca>
 <20240329094456.GA44268@ravnborg.org>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240329094456.GA44268@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sam,

On 2024-03-29 05:44, Sam Ravnborg wrote:
> I took a look at this and may have a fix. Could you try the following
> patch. It builds - but I have not tested it.

With this patch applied on top of 6.9-rc1, both CPUs appear to come up:

  % cat /proc/cpuinfo 
  [...]
  ncpus probed	: 2
  ncpus active	: 2
  [...]
  State:
  CPU0:		online
  CPU2:		online

Thanks,
  Nick
