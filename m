Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92C8C11
	for <sparclinux@vger.kernel.org>; Fri, 22 Mar 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073889; cv=none; b=M6bWWhstgupHlBzTtIcP64etEzoUsTYaf4n8vFg2VAgUPCf/eyGjpkAjbhAm8THqFL/SGhNthYnZ5Y9QZjCrMNTZlrQuXC/RqJs44B8gztgNGrf6FCjkCUGZrAC+zbSWJV9qTylJB7QA1lIqE6yXds+Kk3o1GYtl/heWQ0RD9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073889; c=relaxed/simple;
	bh=okMxw21g5ErPlSKWeHdG3qWKEX0bS7jcuyxPtq7fbow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=lbfche20JBlIKy2Ivjz4FCMG4RXpJ0vjAnTSxZPc4FechYVJGRXS/X2kRBWWCJ1DHoog4ljmaM1+qDnErdXCPHrgyQLKZvZmhEMwZYuZx7ExEZITRMwyA0VgvFhcSYzg10YROTJdRddpw+z/w2npAwwTQLCJChCdgCjVSSyuPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=b3vqPaUq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="b3vqPaUq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430ca04b09bso11827111cf.1
        for <sparclinux@vger.kernel.org>; Thu, 21 Mar 2024 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711073886; x=1711678686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gmzu/tiA+wS1NVvzFexpqs83DytKPN0o3wMDhT4Zkik=;
        b=b3vqPaUqgxIYWkOEm5Jgr9zzFY2xeIeqFmqIWMp+PNea0izXm/9AFV76KjefaRZtnk
         W7lOl1u5qtArx0uYcAgh7C3gV5keee5ztrIFIvmqWBqDU58CFG4c52FREav9jWMnwzKP
         qyTcSKmDMV5jpe2NFFIsw/2DXQqYb05H4o5A/g7kcp3G6wDRinDWsw6PBb5T/MuGeWLY
         a7v9Ot296iZwuljC4IxrHhUGrC+fLKPN9bmXg04Mprpzgr5imh2Oq0s8sUqmuULhJg7m
         NXTqUz/b8QRLbncZ+81ea2EOIFs5rmun/fo9HP6yKHFq0YSgHfwa2mDlJiBeFHb89ECW
         XrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711073886; x=1711678686;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmzu/tiA+wS1NVvzFexpqs83DytKPN0o3wMDhT4Zkik=;
        b=eX5XwsQZJFrvHsgVQoBoBUdiRmMe4rSQN14ge0fmzBsKj32hAcmL4n/h3ezlCIFxnM
         Vb3JdAHz227AmUbOBw5UAdIdOzp2ZfsCRPtv0TUyyLYYg6KYVqSAiI/4zx1SaWqCEZzi
         /tqfO+BWM7PMzvnHxs8WdoFFzuK2SBqSDdbOYoRsjbNmdR10OnV5YyWlM/FCI/QMxrI4
         t1kyQkk6sdUCGXw6aGiZF3Is/CdMzomHxkL5Kpani1gbQS/b/fDKgihscOLdzJE0jw+e
         M5O4hrmj9TBgon6CX6a9lyh9bn1H5lEnjZzqBhrAVfF9za0/x8azgkupUVYUwd07jhqp
         N0YA==
X-Forwarded-Encrypted: i=1; AJvYcCWOLHDukdXcPKdZmiTC3jfZwWLLJxhdfe/neNeQIvCT/M6Vian1e1Oz9sNcHLn1X6I5Xvk9npLKas1b4dzOK/Tj+rqH6preBbbIGg==
X-Gm-Message-State: AOJu0YyIghJSc5ZjiQG8pIR/ZUGR3hKl1uGBewxEs5JNdsT5kL8gCzh7
	HNIqQ8duHRBB/6R9IEgXC0AvOxknT+Mq7MwVvNWX6d76OxSF66K0X+c+Hl8kG8Q=
X-Google-Smtp-Source: AGHT+IGo2KkRpEpH0s6zMyPR+I0a2w2mAG9OV5ZW0444Xf0w3nwPQWwFn/u8EaOQg0zgGEkfIaM1kA==
X-Received: by 2002:a05:622a:4e04:b0:431:3069:4601 with SMTP id dh4-20020a05622a4e0400b0043130694601mr405161qtb.6.1711073886370;
        Thu, 21 Mar 2024 19:18:06 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bv8-20020a05622a0a0800b00430d8e11bebsm463840qtb.64.2024.03.21.19.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 19:18:06 -0700 (PDT)
Message-ID: <7c9b4c27-e179-c136-e327-4c467ece81a2@draconx.ca>
Date: Thu, 21 Mar 2024 22:18:05 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: Linux 6.8 build failure in sun ffb driver (regression)
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 regressions@lists.linux.dev
References: <5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I bisected this build failure to the following commit:

  commit 8813e86f6d82a7931446c3cbc5d596f77d0f1ba6
  Author: Thomas Zimmermann <tzimmermann@suse.de>
  Date:   Mon Nov 27 14:16:01 2023 +0100

      fbdev: Remove default file-I/O implementations

If I revert this commit on top of 6.8, the build is successful.

On 2024-03-21 21:00, Nick Bowler wrote:
> Hi,
> 
> Linux 6.8 (and 6.8.1) are failing to build for me:
> 
>   LD      .tmp_vmlinux.kallsyms1
> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x270): undefined reference to `fb_io_read'
> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x278): undefined reference to `fb_io_write'
> make[3]: *** [/home/nbowler/misc/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> 
> This problem does not occur when building Linux 6.7 which builds successfully.
> 
> Kernel .config attached (gzipped).
> 
> Please let me know if you need any more info.
> 
> Thanks,
>   Nick
