Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A63A7F7E
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779235029; cv=none; b=j4Wh2qKP/b+VnV55YF0CVpHjO9MzM6xgGS0o6n17tTyUJB1cQViG+XUisqUk77hfoH7P/OxfOJMMHAodNkfgQfswgA8nEjQAcM9yDF/fGeVDmGfwBIIgtcmHKQlenaai6k3CIWyhuhZgFtlZJP1hspn+fpawRNZhJSqfGM1bojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779235029; c=relaxed/simple;
	bh=s+3OhO8jaiv4gp4W2MmMu1vTmS+Aqx0YsvRWaoIeR9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msA689yW2DIcJUGIyz8ps+/NkGeE+0hcUi/dur2zQ+O6mm37xno+BvfAxGyV/QcObMHkrCcmqRG6899Q1uhMvtBeDaOUNJMbEhkn0GmgVLlgLxvFq6IIzS4px0WXzRA14x1s11RmbJ22fk5YREcWMXJE/HOI7aeBOh7pj3whkwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a87O32tl; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a87O32tl"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so15180113eec.0
        for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779235026; x=1779839826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwVNzBda9+o6BwkcgCejimTHlfEURUsk3PVURqJTo84=;
        b=a87O32tlOK17uO+m4T3LC33csKERnF8IFn/bN0Y7nR/bel8amFKiW56WB4EjLulu/M
         E3FDZebp0GEj9ekFLZhuyyrulk7GcA77laPjSiry3Rj+NymvUHEak5VrM1GRzzkq8DJV
         9veFPA0T8lVzlriCps5SH1cUI+1zTDjsLwstr/zO3q7rCHQbmsKvI7Oa+E49dIQhCq2u
         IL0oGuLnk58Z3LV+wF40UYMHATHy1XlToQJNgTG8q1U5FILYF0mGaSRHAi6PwGyOeuhW
         K+YAppcoAF3+2QrkvbAsdOPmg0mOywqSZR6UR+4f1zRf+nMdJxGc1WB5groEVCo8/5O9
         sV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779235026; x=1779839826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwVNzBda9+o6BwkcgCejimTHlfEURUsk3PVURqJTo84=;
        b=M8MJn6LUWiphDTU66LcjK8ZC3xWeJdIWRZdH4ckWX0wdNxF18JEtJd4ncPO3GHwWws
         eE+UinhOntK+U9V9FvJCT9hWM0P3Go0XSQ0s3Fo/JCs1X+e/1ECMjvUnPzM/7DBPe84x
         NNO1KqctG9FSKVlPYI6BYC7wwfhicrDHatxKw7FU6xfakEitCDmvOIXgJ+NUNKGmc4vq
         KTgq8+YwWWG1+FcRQxYvXDNLNimANuPf7Cj168cCcBbsX7i3YhtxhOjGukq7Y+9a31PV
         fc9+y9qhJ6zs5fkMjzT6JHj766jlSdTorsWePPUYWrNnkWiwndNI95Ra8fjIUVC5Pcw6
         PLVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9us6IqM1ijXiBDPdiWvV8VQLCKi16W9L1Tr+ORewAHGB+0cI1M1+CJ+6TLXJTgm62Zmc5XWRbLf0JI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5oZ+ntBgyjBFZUw6+FonUIQJ6GcNzAGbtvW1GsPnyrAzv5qL
	438Y1hngW7rXjD7amQf8QKGMYKro2gZvJnXl3/rclA+pOrdJtJgKNKGQ
X-Gm-Gg: Acq92OEvEawKDtZOkK7KSrx1Ui2eQKhuYWssdw21auYFYIW0coPIiAurRfARqJtAKvl
	GnejczUNXbdvl6ZTOcI10SkyNa1qUMx0E1mZ5c8ClL0IXLPV0F004owxFfhvOc0oJ12CYqEcmnn
	8e3mXc37x5KAc4/Eir7tsjfcztVngw7CzMbKSbEkwCYNBCbBRjVtX9kGhVSPER7/YAB8XKp2Lh0
	U6cILDviI3f+2PlrWClsTGdRs203w+/xwmZpTq4QHULSjKGG0NPftueJQVbHrOihpGirhWGXc9J
	/lhENQjXcm2F2Qf4vrAFZ4W1h12iRkwj0bu5xsaF23anj1bTg54A9nODcPzJ9zMNHMHDGtBFhAx
	XCI7IKBxKXZyHsEI6z/yKgQcbxGUHSExUKdmwG6kFmLwWjuE46gS7/FXKo2XOYms+vL+jYo4ZFN
	TKFkiAjicf+AhsEv8GxpKFEEWS3gSmZQ==
X-Received: by 2002:a05:7300:a286:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-303981914a5mr9989210eec.3.1779235026049;
        Tue, 19 May 2026 16:57:06 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304052f79ecsm3305232eec.11.2026.05.19.16.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 16:57:05 -0700 (PDT)
Message-ID: <05e0e7a5-107b-410b-853b-883810b1be3e@gmail.com>
Date: Tue, 19 May 2026 16:57:04 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Content-Language: en-US
To: David Laight <david.laight.linux@gmail.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas@gaisler.com, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de
References: <20260519075809.8993-1-unixpro1970@gmail.com>
 <20260519110223.5aeb88e3@pumpkin>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20260519110223.5aeb88e3@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/19/26 3:02 AM, David Laight wrote:
> On Tue, 19 May 2026 00:57:54 -0700
> Tony Rodriguez <unixpro1970@gmail.com> wrote:
>
>> This patch fixes a reproducible stack exhaustion issue on SPARC64
>> that occurs during USB hub enumeration. This regression may have
>> started sometime after kernel v6.12. With the default 16KB kernel
>> stack, the following panic is triggered early in boot:
>>
>>      [   25.528399] Call Trace:
>>      [   25.528403] [<0000000000433cd4>] dump_stack+0x8/0x18
>>      [   25.528419] [<00000000004297ac>] vpanic+0xdc/0x318
>>      [   25.528429] [<0000000000429a0c>] panic+0x24/0x30
>>      [   25.528436] [<0000000000be2280>] __schedule+0xa8/0x7bc
>>      [   25.528445] [<0000000000be2b60>] schedule+0x24/0x4c
>>      [   25.528452] [<0000000000be6970>] schedule_timeout+0xc8/0xe4
>>      [   25.528459] [<0000000000be3318>] __wait_for_common+0x78/0xf0
>>      [   25.528466] [<0000000000be3550>] wait_for_completion_timeout+0x1c/0x2c
>>      [   25.528473] [<000000001005e2f4>] usb_start_wait_urb+0x68/0x128 [usbcore]
>>      [   25.528502] [<000000001005e468>] usb_control_msg+0xb4/0xf8 [usbcore]
>>      [   25.528518] [<0000000010051180>] set_port_feature+0x44/0x54 [usbcore]
>>      [   25.528530] [<00000000100530f0>] hub_power_on+0xc8/0xe8 [usbcore]
>>      [   25.528543] [<0000000010054fd8>] hub_activate+0x12c/0x644 [usbcore]
>>      [   25.528557] [<0000000010059438>] hub_probe+0xdd4/0xeb0 [usbcore]
>>      [   25.528570] [<0000000010062360>] usb_probe_interface+0x234/0x26c [usbcore]
>>      [   25.528585] [<0000000000a10a40>] really_probe+0x1ac/0x3b0
>>
>> This is caused by large SPARC64 trapframes, register-window spills,
>> and deep call paths in usbcore. A 16KB stack is insufficient for
>> this workload.
> Increasing the stack size for all threads seems overkill.
> That stack doesn't even look deep.
> I suspect there are large on-stack buffers in there.
>
> Unfortunately the traceback doesn't print the stack pointers making
> debugging hard.
>
> -- David

Hi David. Any specific grub command line keywords and values, and 
functions you recommend for debugging this?  I would be happy to share 
Trace Calls, etc. so it is easier to reconfirm and zero in on the issue. 
-- Tony

>> The new logic is:
>>
>>      SPARC64:
>>          THREAD_SIZE = 4 * PAGE_SIZE (32KB)
>>          THREAD_SHIFT = PAGE_SHIFT + 2
>>          THREAD_SIZE_ORDER = 2
>>
>>      Non‑SPARC64 with PAGE_SHIFT == 13:
>>          Retains the existing 16KB stack behavior
>>
>>      Fallback:
>>          Retains the existing 8KB stack behavior
>>
>> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
>>
>>
>> Tony Rodriguez (1):
>>    sparc64: unify thread stack sizing and add explicit 32KB stack
>>
>>   arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> --
>> 2.53.0
>>
>>
