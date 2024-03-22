Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAB7E6
	for <sparclinux@vger.kernel.org>; Fri, 22 Mar 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711083460; cv=none; b=Bm0HHSBbYvtU77EpmvX4tij1ukD48kJ3ESEnFSQohh9rGrpziCn4s64Lj9GMj0yim4RLHHQfCbVez+2w+Vjj8uHF3FGI0vFRY7KFyhTWZuAtdD9/hEp1qwN8RTwDu/1a5u+vrMLXmO5BNA1KIvu8ArmhNOCjY2PWCygN4jN/vMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711083460; c=relaxed/simple;
	bh=fF5rQyHQWkmRrGj1g5vNHmvUdV2jYxwEEWFntwt3mQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH24c8niE6Lr6DsZeOAQmE94UHP7E1OqcxB63HsEHDZzlJ/cift68L9EWiwJATRUpVgxmAlSpSsu8WE9WtRqQC/xkZf5rnCBCQiCKGMipxbzW2VtCT1I6QJxaBjKpqno57t3jMaXXdWeiQgCWeuBOQfQ1qnTYe/4JNB0D4PS8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=XTDtkdSc; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="XTDtkdSc"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430b870163eso24027661cf.1
        for <sparclinux@vger.kernel.org>; Thu, 21 Mar 2024 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711083458; x=1711688258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4moE6UNpA9SIxqGdVmnT/LKS1e/fLbBXDD3FIgn3m9U=;
        b=XTDtkdScNFkcF4CigirtjL1hg1DNSj0URKs8xP+UrqQAjVNgfzfUBxWJ7gq1+RjJ2r
         hngAnxBb72TYsVJ2dVSEsEnUbqvdd8E+tyxbyd2GfSQ3LwLyGV+NsgTf2xUGfiEhGjhG
         CEKQVXDPj5XSskFAsAe/0BX9NwFeGO3JrrRoaU85nom+ODU9AYoD/Wt0ca+oAbec03lX
         FN0DmisqtPbu1knPLzUM/ms9HyfEaErO0L7ct1Tg1QjdL8tdhnngvwz/e4mESXMJVCvw
         11z/FWElfOXSGnW7nx0Cg3jVvahZCHh3IEYx4dskGQ82lsUhMhSCrKAmNjn/OnZjN1qz
         eifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711083458; x=1711688258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4moE6UNpA9SIxqGdVmnT/LKS1e/fLbBXDD3FIgn3m9U=;
        b=Kqz9VHcn38pLam9vc7tGTOPmkBkxQinWxW7F+lH8bcaNU2XJL5Dy4o78TJyg53UisS
         ohGsLfunBOSCBK7SGz2f3GtiCvOzvbNTQpPjfsQK1rKj2AnDWfglTJaBIjMUf4T20qjd
         IJUG+5/1c872CObPsdCjFvBeZ433LxshQgH8FGv9jET3VtgWiQD8aGkNA6z3m928ylJ8
         KVS8CmU20ffv9BTryPok+947qL5h5NXpzEBjzAmcvQdqDGv6s4g9Pj8VF7Tym1Z4HFme
         6RMEmz/5gkyc/wZHKrL4j0ry8RLEG27r/eyxFH+YKhpY2k4oNUYtyG58250vPanzWQZL
         Y8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpxp9hQw2+TYDvvnN5aEv50H9zPDeskjLQUptX7TYLtiJQacoWj0Gfg1fzAZAwHRpERizO3LztLgwPctBICfXIDYIc8So23rRQA==
X-Gm-Message-State: AOJu0YyC0OYyXlsUhD6NwG6yMaBvXt8AMMut13YxSH1FHafevvaArcB+
	jUy0tV/FD/NPNI5OkUVCNKHJTQfTkQtzF5jiUWbEU+YkBEIu2rClXJpnAraDyOI=
X-Google-Smtp-Source: AGHT+IFDVzdsNTf0W2w6oKUGYAk+vCLJ348WVZdcAHzdnqbFdRV88jezCeF+eTR98FPPhDmSdzt2NQ==
X-Received: by 2002:a05:622a:1210:b0:430:c6d3:b4e6 with SMTP id y16-20020a05622a121000b00430c6d3b4e6mr1592464qtx.12.1711083457763;
        Thu, 21 Mar 2024 21:57:37 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id c17-20020ac81111000000b0042f07081f26sm558521qtj.22.2024.03.21.21.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 21:57:37 -0700 (PDT)
Message-ID: <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
Date: Fri, 22 Mar 2024 00:57:36 -0400
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Just a friendly reminder that this issue still happens on Linux 6.8 and
reverting commit 9b2f753ec237 as indicated below is still sufficient to
resolve the problem.

On 2023-01-21 08:31, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> CCing the sparc maintainer. Also CCing the regression list, as it should
> be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html
> 
> The the mail address of the culprit's author bounces. There is another
> Atish Patra still active; does anyone known if those two are the same
> person?
> 
> Anyway, that's it from my side.
[...]
> On 20.01.23 04:15, Nick Bowler wrote:
>> Hi,
>> 
>> I'm resending this report CC'd to linux-kernel as there was no response
>> on the sparclinux list.
>> 
>> I tried 6.2-rc4 and there is no change in behaviour.  Reverting the
>> indicated commit still works to fix the problem.
>> 
>> On 2022-07-12, Nick Bowler <nbowler@draconx.ca> wrote:
>>> When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
>>> CPUs, I noticed that only CPU 0 comes up, while older kernels (including
>>> 4.7) are working fine with both CPUs.
>>>
>>> I bisected the failure to this commit:
>>>
>>>   9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
>>>   commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
>>>   Author: Atish Patra <atish.patra@oracle.com>
>>>   Date:   Thu Sep 15 14:54:40 2016 -0600
>>>
>>>       sparc64: Fix cpu_possible_mask if nr_cpus is set
>>>
>>> This is a small change that reverts very easily on top of 5.18: there is
>>> just one trivial conflict.  Once reverted, both CPUs work again.
>>>
>>> Maybe this is related to the fact that the CPUs on this system are
>>> numbered CPU0 and CPU2 (there is no CPU1)?
>>>
>>> Here is /proc/cpuinfo on a working kernel:
>>>
>>>     % cat /proc/cpuinfo
>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>     fpu             : UltraSparc II integrated FPU
>>>     pmu             : ultra12
>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>     type            : sun4u
>>>     ncpus probed    : 2
>>>     ncpus active    : 2
>>>     D$ parity tl1   : 0
>>>     I$ parity tl1   : 0
>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>     Cpu0ClkTck      : 000000001ad31b4f
>>>     Cpu2ClkTck      : 000000001ad31b4f
>>>     MMU Type        : Spitfire
>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>     State:
>>>     CPU0:           online
>>>     CPU2:           online
>>>
>>> And on a broken kernel:
>>>
>>>     % cat /proc/cpuinfo
>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>     fpu             : UltraSparc II integrated FPU
>>>     pmu             : ultra12
>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>     type            : sun4u
>>>     ncpus probed    : 2
>>>     ncpus active    : 1
>>>     D$ parity tl1   : 0
>>>     I$ parity tl1   : 0
>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>     Cpu0ClkTck      : 000000001ad31861
>>>     MMU Type        : Spitfire
>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>     State:
>>>     CPU0:           online
>>>
>>> Let me know if you need any more info.
>>>
>>> Thanks,
>>>   Nick
