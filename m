Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154009;
	b=2uwikmSH91GoWv759mwVPWOttUiHLC2xRKVrfrKGmMpNNrmAfqk6I88y5doe3exgUVEk
	 lm7v6sOOelUexevw2/nb4rIrJaWTAsBD0z071Sa7egwhx/1BNfesg1IcTqujMnjbYuCZQ
	 sBqzD0ri5kkSe3JOzMpQSN5FqjIB5a98RLXpNbtyLk5rcY79+yFxTOcC0eCyy7n579rqB
	 StCO10qU3c8p6FZb5bFzQetq/miitOJ6iIVWDcMTRXoc41Jf3gkI+XXg12RyL6tU4vx1Y
	 DAdulL5N5BP+FdqE8zEBpQYHYrACGfFzBN6FA3ZJ5qyy2xI+gXXDDjUhQiVH685VtYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:From:To:Cc:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zKU37HZGnlOr2SpDH8kKzJt0C5H6nwLRcRdZw0Yvx9g=;
	b=V/tcH3ceyubqM37T2V4RQ5hAm5twSV+lbkSX8omVNvo/4UJ5Fcr0VkQblsmrrXleWZGV
	 H7l+NVQ/7x0OZi2E1y7AcWnxMMehj4ZM2+7sEOWu1oaIWhzm94Xh7h48UndHDrWgoIstG
	 pXxH8MYfSbFagHyIAAfHf51QRQC/HSWh6MFBs+agoRh8Kr84wyU8SGTzaGtWIFe4Gq2kB
	 enUmuHe0Vn2xPn54gSEQoOlQCCFLPxuSJ/wN+302YBAPJRgrYWaTf0lCKwmfTXkm+htyL
	 1aRwjxc+2jdRQd8UPBg8G/K3UPT8quZUN2Le+NGCpo65m/UmTTextK4Pa3VpnYN4tIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AQuZjDD;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2F606A31A
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 02:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AQuZjDD
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a17a332ecso620328eec.1
        for <sparclinux@vger.kernel.org>; Tue, 27 Oct 2026 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793154008; x=1793758808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zKU37HZGnlOr2SpDH8kKzJt0C5H6nwLRcRdZw0Yvx9g=;
        b=0AQuZjDDtB1CmsWGjeK+90Q2Q8wVWoHP/9E4JxjRfn/9UrMKA3lHYQ61xjOnmug7BP
         gY3n55MoXZD5UDyIxrfKUbFN/y+AwbA9Gvm0q+NPfT3Pt3Wb6WZ+rZFDlKSDhae799eU
         SxSdMnSNK0ayAawlvmSmyUV1Nxl6Tfprqis/4yxYz3+PCmjps4Xz3G3PYsqaVNy8euYV
         VSaEL2MD28r4YvmXgGo8MR+enLQK0Dnt0S+EEyWAQL69BFrnkTaespBe635jj/PNZJ6G
         t54Zkr7wxZUjfo8W3iyBO2hXHN3j9z/YteGiXQbZWgCYh+VpB+6dlo+i6UPk5AI06ueX
         vFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793154008; x=1793758808;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKU37HZGnlOr2SpDH8kKzJt0C5H6nwLRcRdZw0Yvx9g=;
        b=spLZ/nRbDpPSL0LV8haCf+CAIuntQBp9G+/Usp22v29yHgf2BDTU89xKmr7jKOcSSy
         6J+zEBLZvE2jW7bCX3CQMLnWvxYymJS+hAkKuSMF40U6Lsca4FOk/Hf3wQEbilwhjbCC
         1fDaZuW7P5E9HemnOVMGiaeopDoGFyREwpHC5q9QsTNgey2YelM+8kdDzqJt+vk1LMew
         F24XcUHT6ZAJ9tXxlKOTt0mCPE9gvwHKiXuunG4yMbxrGErlZ7nPni1Y3wCYrynqYY4a
         WP4iqRmT04Qwb5HD+W7+CVKg+YhIEYJeteMba6FAdF72NNVn+NmboIWr5av/LtiNT2Nv
         b1Tw==
X-Gm-Message-State: AFq9FYIKor8OUQrL5zl385o/E61Bm/NsNHjk3sZht37x9wIPemIF2Wb0
	FOrM+iKmF5mrGBJvFeW6MqynTPosiDSMvA/bk/1YZ+k6MmJaJKuWTuf2grnPdmHt
X-Gm-Gg: AYBFou13UljunQklgQp2sdisbmSvMvOb05wa3F3EA8yfEPEvsNWCK6/8Dfns17yPNW2
	qysjCigqufp1XkWvn/R4OwPg0rtL+vu0iHNgNZK6CNB+EyTOHD1r71l/wQECb184bR8LODK4nz+
	Zgj0PI8OIx4B3c04KTwB/4GowvZXB/Vt/22yAhAXPYbEQY+upCVrfYxVK002TK7PY+4YbEAYEgj
	6Wbhqa5ct+6O+nO1+nnYOdO+sCDQiN5uHpoLRF5SbpI/HsmEW8KKLaTLoPrpmX5ediFhOAs6wlv
	raEB104iD3sQaBlRevEPmyh+WwmeNytzxT/Zxelvcx8InMGDgR1+l3rKp7Q+XdEysIw3ohf0e+k
	wLdUzHMwZDPvajiSqOZ5dd4I0XfTzmd3Q7+c5DoLRAWZOlwfG4O+ZqTFbcaW7Nj+OCVe5hroDaN
	YGhgTPvPkoKmN5QQksPBsf3QpoaerOT9YG/jONMpuRu7SK9TE/TbD7pHzvvRnusLT6JwYjNYpVH
	9F1aUs2r06i2s22kWhfkJKVvpxoDWaIA08OBK1BzYwslF/C/8yf+6uWIvyXElIxVG8Qz3I/HQ+S
	v1tI0KNRTGCjorGegHVq9ep8cSclPIxKsYyv3h4aX1XU+6RtrtM48IxeGcvMPFw9kXM=
X-Received: by 2002:a05:7300:f587:b0:369:fc38:6821 with SMTP id 5a478bee46e88-36a20113296mr1455284eec.12.1793154007687;
        Tue, 27 Oct 2026 19:20:07 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2396276asm1040342eec.22.2026.10.27.19.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 19:20:07 -0700 (PDT)
Message-ID: <b57295bd-941f-4df9-990d-c044951f9ddc@gmail.com>
Date: Tue, 27 Oct 2026 19:20:05 -0700
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3] sparc: populate sysfs cache topology information on
 sun4v
Content-Language: en-US
From: Tony Rodriguez <unixpro1970@gmail.com>
To: Jan Engelhardt <jengelh@inai.de>, andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, stian@itx.no, glaubitz@physik.fu-berlin.de
References: <20261028010100.24792-1-jengelh@inai.de>
 <63f51c81-4ad4-44ea-b8bf-32f9ff6a4871@gmail.com>
In-Reply-To: <63f51c81-4ad4-44ea-b8bf-32f9ff6a4871@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 10/27/26 7:00 PM, Tony Rodriguez wrote:
>
> On 10/27/26 6:00 PM, Jan Engelhardt wrote:
>> The SPARC port also lacked reporting L3 caches, present in
>> Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4
>> onwards and Fujitsu M12, respectively.)
>
> This seems like a typo.  Instead of "Oracle S3" shouldn't this be 
> "Oracle S7"?

Never mind about the "Oracle S3" S3 core —my mistake. From my 
understanding SPARC S7, M7, and T7 use S4 cores and T8 and M8 use S5 cores.

Tony

