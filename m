Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4B2DECB2;
	Wed, 14 Jan 2026 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382441; cv=none; b=BTn08BXgjtqrinj5M/SXaMH9/8lUZE0R151O1bc9VrIWJ1+9El1elrdvr7Q0jYWdGTYyDFndq7VcNkgbhAn96C789C2HOh1qoEUHqB0vRuDXhNK5hNv7VgP0S5HHk0nTWdZHllsZlxV1Ec5vlfIXXJDl9VXn0pqOZBgOKf3vYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382441; c=relaxed/simple;
	bh=AGidN8rHxYVYrRfPkhxcLscYC3zh/M2+Vo3Rgs6UAFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4jOFyAo7Zc3JeFu5H5Vtx47svA1kutvxixDbUOwVxbuEc9vqPgCGuPY7+wFTjVw47EJ+ooPKGW0qqmcZWE9yZWKfBwlNbdU6OZKkjNCfrAY7uN6yQpocrtk41AgwKMqDHuCkTdwkj2TDBnW267A6dQHYJHJcE6mMQE3u6dwC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=n4HWMf4v reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="n4HWMf4v"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4drgZX6HB6z1FDXH;
	Wed, 14 Jan 2026 10:20:36 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4drgZX4kb9z1DQs3;
	Wed, 14 Jan 2026 10:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768382436;
	bh=htXKSCfwi/rRlWCimVMkpN3SKdsCeXQPXerxlhbzfq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n4HWMf4vQ4+AK7sXrSJ1x+E4ZyVzqSOm2U01Nk5yXiv+SdO0872bjMHKIg0C3ao7w
	 qcSZ3JSufZFoetXUFCLIR16YzpTYvzFyEYfiYyXUVZJe6E4vAQJlRcJmOS5vzaTMYP
	 JsPgHWKPp8e8Y+BsxIqUBb5zhxZF76GajNyBMr/TEn46HYtuh9XCbCaxDxKbV0mZpC
	 +35yzbFj4FX9cSSGy4UDTl2kN2IyOe+m6tY0wS44jXptZI81trByTEQBt6G4ieCWOb
	 RhgCqycMUmi5XpUhfaZ3x8RQM7OILfjHesA0nlntkVUK4Xcss2DISwf2QVZBSRg3Mg
	 0wbG0YGFLlBkw==
Message-ID: <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
Date: Wed, 14 Jan 2026 10:20:35 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: don't reference obsolete termio struct for TC*
 constants
To: Sam James <sam@gentoo.org>, "David S. Miller" <davem@davemloft.net>
Cc: Stian Halseth <stian@itx.no>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
 <e11ecaf723594bf01c66fc5c80c25bda0621f34f.1759359616.git.sam@gentoo.org>
 <87ecqyaefl.fsf@gentoo.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <87ecqyaefl.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-19 21:18, Sam James wrote:
> Sam James <sam@gentoo.org> writes:
>> Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42

Please refer to the referenced commit also with "commit", the SHA ID and
the oneline summary of the commit, like so:

commit ab107276607a ("powerpc: Fix struct termio related ioctl macros")

>> drops the legacy termio struct, but the ioctls.h header still defines some
>> TC* constants in terms of termio (via sizeof). Hardcode the values instead.
>>
>> This fixes building Python for example, which falls over like:
>>   ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'
>>
>> Link: https://bugs.gentoo.org/961769
>> Link: https://bugs.gentoo.org/962600
>> Co-authored-by: Stian Halseth <stian@itx.no>
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>> v3: Fix constants.
>> v2: Fix title.
>>
>>  arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Ping.
> 
>>
>> diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
>> index 7fd2f5873c9e7..f26befbf690fb 100644
>> --- a/arch/sparc/include/uapi/asm/ioctls.h
>> +++ b/arch/sparc/include/uapi/asm/ioctls.h
>> @@ -5,10 +5,10 @@
>>  #include <asm/ioctl.h>
>>  
>>  /* Big T */
>> -#define TCGETA		_IOR('T', 1, struct termio)
>> -#define TCSETA		_IOW('T', 2, struct termio)
>> -#define TCSETAW		_IOW('T', 3, struct termio)
>> -#define TCSETAF		_IOW('T', 4, struct termio)
>> +#define TCGETA          0x40125401
>> +#define TCSETA          0x80125402
>> +#define TCSETAW         0x80125403
>> +#define TCSETAF         0x80125404
>>  #define TCSBRK		_IO('T', 5)
>>  #define TCXONC		_IO('T', 6)
>>  #define TCFLSH		_IO('T', 7)

Please also, like in commit ab107276607a ("powerpc: Fix struct termio
related ioctl macros"), add the previous definitions as comments in
order to be able to know in the future what these hard coded constants
really should correspond to.

Don't forget to make sure that the subject gets a [PATCH v4].

Thanks,
Andreas

