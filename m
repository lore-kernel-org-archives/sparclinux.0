Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175468;
	b=z0J8gz1BgXleWAiFNXDnxTGiC9Tb7xTq2d7mKZDrq6QWwT6ZVY4JOfyicQv3a+c95whz
	 xdxq9sK4faqU3tohfDlN+R955ETxLz5F5z294sp2/y3U6MRXq1zoQ0XkBeVfOLh7Cpb09
	 LUYPKnI4aJl5Frlu8hL2ZmOfLt+b28GEXqLGi8PRLolJ/oC4zTUJmQpbK+t8lDA5LgaMV
	 0WZtHY9ECfdgLZZ0mBJK4x47EjnosT+FtN3dr+CJuKbRt8yD/FwwFH+zSJKrLQAMP9alb
	 j4bo+VBWpIyDYoG2E9A81nGSFBldSXEAOL9JzbcKiQoOmfyo1H028JZAIPvO7zoeHXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175468;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UWPu8votaLY0w3pnFTc0TdaM2ReoM77qH1U4vK0extg=;
	b=dzxD1K86BhM3iQBNaFHBo9vjlNG3kknM+ILnwHCjecotSIQchVCV6W8gQavIkAsP4IDP
	 LmT9/HEsksf3DjxXJGJLjlqqwaY+kFOyWQO5gyG+dYryLkUKXgB5JI54a4EAHv2nOB2oN
	 uJjPY/Sv4+usQwmFZm8h8zBCx8EPH3IGgelltkg1vk42B0/OA8aaaudj8y1rAuBRAZ1fn
	 P54Wv+P6DtXIo9QhYjaZhJysiyWvrv82ODQgXWNo1FvmMrzM8E3qrk4JsIQpOsq0MGTHq
	 9SsbmOOmO05QlfP1rCer5ow9MNXxg5pGee9qQU6SVMMuG9gKGUfpFDPYDHbVJtOFAbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFD7606A323
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id CD03A1019D1D83; Wed, 28 Oct 2026 09:17:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id CCC7B1100C3F62;
	Wed, 28 Oct 2026 09:17:45 +0100 (CET)
Date: Wed, 28 Oct 2026 09:17:45 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Tony Rodriguez <unixpro1970@gmail.com>
cc: sparclinux@vger.kernel.org
Subject: Re: [PATCH v3] sparc: populate sysfs cache topology information on
 sun4v
In-Reply-To: <63f51c81-4ad4-44ea-b8bf-32f9ff6a4871@gmail.com>
Message-ID: <0r5s3nnq-op8s-90r7-418r-n174nn3487s9@vanv.qr>
References: <20261028010100.24792-1-jengelh@inai.de> <63f51c81-4ad4-44ea-b8bf-32f9ff6a4871@gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wednesday 2026-10-28 03:00, Tony Rodriguez wrote:

> Hi Jan,
>
> On 10/27/26 6:00 PM, Jan Engelhardt wrote:
>> The SPARC port also lacked reporting L3 caches, present in the
>> Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4
>> onwards and Fujitsu M12, respectively.)
>
> This seems like a typo.  Instead of "Oracle S3" shouldn't this be "Oracle S7"?

It seems to be a law of nature that the chance for projects to 
fumble-and-stumble with their numbering scheme, without changing the 
namespace, increases with project time.[1] From what I could gather:

T1000 machine, T1 chip (microprocessor), S1 core(s)
T5120 machine, T2 chip, S2 [2]
T5240 machine, T2+ chip, S2
T3-1/2/4 machine, T3 chip, S2 [3], "UltraSPARC KT"
T4-1 machine, T4 chip, S3 [3], aka "UltraSPARC VT" (name in MDESC) [5]
T7-1 machine, M7 chip, S4 (?), aka "SPARC 3e40"
S7-2 machine, S7 chip, S4 [4], aka "SPARC 3e42"

[1] https://www.youtube.com/watch?v=MipuN4RU4m8
[2] https://en.wikipedia.org/wiki/UltraSPARC_T2
[3] https://www.touchpoint.com.au/resources/insights/oracle-sparc-cpu-overview-comparison-table/
[4] https://serverental.com/sparc-sonoma-sparc-s7-server-review/
[5] https://www.oracle.com/technetwork/server-storage/sun-sparc-enterprise/documentation/120214-t4-d04-p-ext-2305974.pdf
