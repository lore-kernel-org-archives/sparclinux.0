Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19642ABA
	for <sparclinux@vger.kernel.org>; Thu, 20 Jun 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894175; cv=none; b=CpUKZ4918pJj+aFrE/2njcb0ebOxiyT1lDVzBeYXWp28hu57K5U+adAGZNSFEKirvVDVyMW285e9vaojdjm0RF2PnM9P1iQdQvNWAIDCcYxYWEEHD6c+BdDdAXY7ZTpXV15CSMCQYkAAnBWzEyedQl0DWPh4nSxLAx/ShgTf6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894175; c=relaxed/simple;
	bh=C/7etpkN1EyOxZMX7kH6rf1YdH7lnLSLobU/qcTAhKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtYteUAsDl6ZqQ1soF54MxYXS9GbA5ZyzrJEFfHeeMZI5zgtGa33copkbfvX71mdHvhMUH4ttyJTbCzzPNj5jS3N58/fFqeEFK1NRdW0BrbdsIWNWLtrYWztPlehlZb0WJhreCnS7R2gkuc+VEzHPUwCMU5h3ytB23NfdnqfDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Vjbi0zXY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Vjbi0zXY"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375f43e005cso2904295ab.0
        for <sparclinux@vger.kernel.org>; Thu, 20 Jun 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1718894173; x=1719498973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A98UevaERdbTC/YwOFyWmTbSR1N+hw0zQSVldl8RhYU=;
        b=Vjbi0zXYpYweq3mJUapFzCctHjKrGGk0yxW9yXU+KJRbQPYkcP0dow2FwNaIzb/5/j
         xZzLJBhBLaQl8AyagdIxzf3RLNzEEHPrzfSK6mRb5fnNBkqEdnyDgDRmcs79RBowlwD3
         28miW94Ktr+ugSKGSw6pjvAlya6KaI7fMS6oyn9YWgeyK6CkQH5EnN4/a969hklvKnlt
         smR0BJyqyRTGg0cRwDPftQA9QXRrJrsbUSM/VJXKjOg6pLf9SKpnF1lcnJgw1elcNZcE
         3mgpCrhBKh+l3T9SZjVw2FBLUGzXp9dy7zLP6VjiiVtuwL8o8FPnc/pviSSW+uUZ3LCv
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894173; x=1719498973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A98UevaERdbTC/YwOFyWmTbSR1N+hw0zQSVldl8RhYU=;
        b=gBVbmVtEWuTp/K706jKd2Yx05l0jZ+MfIEMCj0ArWByhVoAGcjJoc8ZoXbNc+v9/OI
         6RcvFpE9ZYOXT/rZ0pwcrei1jlVlIA7+7Ae9b+c2MEgAqlLNJQ3up+M6lZCEa+VMNsPk
         j6tlWxbVMbuufb3tmAlJOb344xwqFLJ5qZ42j+Npn0hjq/LAGV1aEyluHDL9ZiBq8rW0
         SG0yHSA5gfJmcLOA+ULDPNUSeQyoNNQ51Dkb0ZyNK0PcDbrfGZQorNZCwJR1aFPHBsXb
         xjVa5HZz2OezIPII7b4icdgJ72cnuXeads5l1CDmtQ3D4HSXpH/IOTdzAl2AFOdoTCnl
         vvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK9Lx9afc10yRGYoCK30eufBSW9zncSgZ+L2gXqe2ImIxENpuSLOhWe/7f5C45T8QPBSv1tuMIrVptTDqvBeUhWNUni9J3R7HL/w==
X-Gm-Message-State: AOJu0YzOD6GpbRshZtXlKDsOJwLQ2ri2Qe60HmqEORdQgAl6Ggjj6/eb
	czfGOAbgzfl5ZnFZBGClSEhrhPLEg7xp2oQykyw8sW4SHzGjOZWfsOgccOoQKuM=
X-Google-Smtp-Source: AGHT+IHEX4VWi6NFf2OYvYNfmsh9bNN5+QvL49KMSIcQjonXWJpIa7TVyKkpnYOby5F1SBrP2YKhQw==
X-Received: by 2002:a92:dd0c:0:b0:376:296b:1754 with SMTP id e9e14a558f8ab-376296b17c3mr7852465ab.15.1718894173249;
        Thu, 20 Jun 2024 07:36:13 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568dfb15sm4517876173.18.2024.06.20.07.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:36:12 -0700 (PDT)
Message-ID: <012b7244-fa12-452c-9d76-7768e59f7e03@draconx.ca>
Date: Thu, 20 Jun 2024 10:36:11 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Content-Language: en-US
To: Hailong Liu <hailong.liu@oppo.com>
Cc: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <20240620063742.7qugmebodtlogn5r@oppo.com>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <20240620063742.7qugmebodtlogn5r@oppo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-20 02:37, Hailong Liu wrote:
> On Thu, 20. Jun 02:19, Nick Bowler wrote:
>> After upgrading my sparc to 6.9.5 I noticed that attempting to run
>> xfsdump instantly (within a couple seconds) and reliably crashes the
>> kernel.  The same problem is also observed on 6.10-rc4.
[...]
>>   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
>>   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
>>   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>   Date:   Thu Mar 30 21:06:38 2023 +0200
>>
>>       mm: vmalloc: remove a global vmap_blocks xarray
[...]
>>   spitfire_data_access_exception: SFSR[000000000080100d] SFAR[0000000000c51ba0], going.
>>                 \|/ ____ \|/
>>                 "@'/ .. \`@"
>>                 /_| \__/ |_\
>>                    \__U_/
>>   xfsdump(2028): Dax [#1]
>>   CPU: 0 PID: 2028 Comm: xfsdump Not tainted 6.9.5 #199
>>   TSTATE: 0000000811001607 TPC: 0000000000974fc4 TNPC: 0000000000974fc8 Y: 00000000    Not tainted
>>   TPC: <queued_spin_lock_slowpath+0x1d0/0x2cc>
[...]
> I guess you can patch this
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-unstable&id=00468d41c20cac748c2e4bfcf003283d554673f5

I tried with that patch applied on top of 6.10-rc4, and the crash still
occurs.  There is no obvious change in behaviour.

Thanks,
  Nick
