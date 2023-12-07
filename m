Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="MUCKjKmS"
X-Greylist: delayed 481 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Dec 2023 08:57:45 PST
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A89170E
	for <sparclinux@vger.kernel.org>; Thu,  7 Dec 2023 08:57:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4SmKxg1qzNz6866;
	Thu,  7 Dec 2023 17:49:43 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4SmKxf0YJ2z681W;
	Thu,  7 Dec 2023 17:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1701967783;
	bh=s/G502eP+Cz2m/ZK1OaaSSp3o7NLys4j+0lG8KQXq4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MUCKjKmSABArRO38H6OQjCTq6BWId1ZumE+Sn8+qXf8mer+5CrsaVwH4zelm1BEm6
	 l34fljhYPpTf8l15472iqYulgsZttNurBTZODBiP3Sm+KsehXedoq2H4S9VXHdgTTH
	 OfM1TKxKmAvkadqIZJSLpDk03dY4WEdXQy/sUYEc=
Message-ID: <030e57e1-13a0-4c62-8302-2b0008c6e92e@gaisler.com>
Date: Thu, 7 Dec 2023 17:49:40 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, sparclinux@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
 <20230713145536.GA5300@ravnborg.org>
 <20231204110512.wz6qfsah632bcuh5@pengutronix.de>
 <add3c37a-08ef-41e1-b717-091d9bffd66a@app.fastmail.com>
 <20231205180506.GA242352@ravnborg.org> <20231205202630.GA290248@ravnborg.org>
 <93c22029b8523c5380f126995481002246eabfa7.camel@physik.fu-berlin.de>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <93c22029b8523c5380f126995481002246eabfa7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-06 10:31, John Paul Adrian Glaubitz wrote:
> Hi Sam!
> 
> On Tue, 2023-12-05 at 21:26 +0100, Sam Ravnborg wrote:
>>> Agreed, it is long time since I got any indications that people
>>> actually use these old machines.
>>> The sparc32 machines I have, have not been powered up for several years
>>> now, and they were only used to test new kernels on anyway.
>>>
>>> I sent out a small patch series to do more or less what you suggested
>>> maybe one year ago. Back then the resistance was only from nostalgic
>>> people (like myself) and no real users.
>>>
>>> If you or anyone moves forward removing the non-leon sparc32 support
>>> then starting new would be the best approach, I do not think it makes
>>> sense to dig up my old patch set.
>>
>> Never mind, I digged up the old patchset and will try to prepare
>> something. Then we will see what reception the patch set receives this
>> time.
> 
> No objection this time. But maybe we could sort out the maintainer question
> first, then start with new patches.
> 
> I like Arnd's suggestion that Andreas Larsson takes up (co-)maintainership.
> 
> Can someone reach out to him?

Hi,
I feel honored to be suggested for such a responsibility. I could in the
long term be available for a role as some kind of SPARC (co-)maintainer,
with backing from my organization. My SPARC experience is mainly with
SPARC32 rather than SPARC64, so discussing a co-maintainership with a
SPARC32 focus would feel natural as a start. I do not have much in terms
of SPARC64 or non-LEON SPARC32 hardware available for testing.

Has someone reached out to Dave? I think discussions like these might
be better served in a thread of its own.

Cheers,
Andreas Larsson

