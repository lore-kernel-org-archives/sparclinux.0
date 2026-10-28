Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152841;
	b=bs1uzZQIiOsHT4e9z8N7Znp4ZL+IBeaqzxPs6jfkFsofFDQvP9i1YKCm3FjyB7XX+wu1
	 lslyM8JcNjODRAN1ycXAH/DnQW5wSa5uhzGNCQH2/L9NLnvP/SpsD/PtIpfyhJgebuAYr
	 9kB08frKvKRwaMmsoQ7HrH3s+ZYgvyWLvo8H81wVhhnqzaRxT86a9UH4OdVIsTSt/3FtY
	 HtvSly75LHw/z/XsrL9ItqNQIMEXElJIuGj3eSC9n6RJ6wZW/dBcYnVKm4kMNsEe6EX82
	 +V+E60KGjBwLg1jH3Ba9KYNIIHQ4Vw9XYS8LLTDO+LxipfWckqzMzk4+IsbvtYY2lLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TIwV8nXpN7bymBiEJqfhpz1Lc+44vm76tTCC169+enM=;
	b=uJFxk5yI271wGKtV1HaAWoXE6wkDGSjp1hC/E6AYDlnN4E74NwL3LkVqIMwSLVhW90yp
	 EHdWZzGHF17XKpD9GwvxyWr9CxvxM6AondyRlvoy7CyXx+6K6nTd7alxDfVM/ZPXHQjOa
	 k5ttfDvmxpYMXjLqisw7wawuFWCpRVcS4NaH6tJJYYuK0v5SPJchJ0Zyz3VYjx485nX2A
	 geBCNZKUcSqnpuPSzMcERiZTYT2Gen1m9mWI6Fkm1BasxHuNrfxw9Ku8XN4w2mI4SmdJS
	 Wg8wUKWiJLd9JXNSWGA/kuNyts1dB6b8FJ/jrIph+jQ5Nfp51L9IlGVeW0uOu3TQsoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjaRp0jm;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B90606A31A
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 02:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70B90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjaRp0jm
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9f6a16aedso2676515ad.2
        for <sparclinux@vger.kernel.org>; Tue, 27 Oct 2026 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793152841; x=1793757641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TIwV8nXpN7bymBiEJqfhpz1Lc+44vm76tTCC169+enM=;
        b=HjaRp0jmMupdDGMMdAnnEcwZ5hYh8Nqu4y1efDsZtVXGIm7Xv2cZ4xOjvlZcvV7Lkn
         TIhKoZyIVhNEQmpSgsaCV/u9ck2kpSI7an+vxJ7fE68ZaDHqH/KVGxBIIY82qBIBpiHP
         09XbOrO5+vuV8JZo6hi5SyuSaA29I88ogdHSjzYC6RkJim52mqMgECtRrg02pO0nJHtS
         kq3Z2OPufTrrJqEE+jyjg2meh0/hNjkwgW9Se6rLEhETMrRzIvMG1KcqISI4NsegHIGu
         gsYXpvx7oZRvbyzbyNwiw2NTEUXzE7GRJGqLNliV/HZc63yzRJK/hkYEXphuvIcnlHmz
         pJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152841; x=1793757641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIwV8nXpN7bymBiEJqfhpz1Lc+44vm76tTCC169+enM=;
        b=PXZqu0H1xfPAlLe1SN3uIQoEWknzz2NZNEsOSvFFAxtCOYkU36AFAV2Ym7HT0Vly4H
         bmngWINMmMyb1NnUCRiywKwa5DcU9RblEsG8aoWJF8ArrPyxIbnjaGqLcZ9xN1THhv+1
         TghX8r9onvYl30fYzSXZamUcPsfZmMW/PWAT0cjzZDH5sBMqEMW+fS2pgNdacHwBrWhc
         33cCOZ7FIGl8o3kYQvLoml7cBqDbbrsEIT+0b2QH2Ot0P0VUTitEaTLhyDNUcIchOQ7D
         uautJ2UrtuFuz9NktkVAEZik/0mwBgHS89V3zXtmEc/kvtTPCXXcq4XPpPxUb0s7gpDT
         uI5Q==
X-Gm-Message-State: AFq9FYIN+GLdAAujngGmi4ub8QpscY6xs0BASI7e5IQK85JeX7J74yW6
	mIn4IyA17qwSzeaanTQXM4T2KqSjZTmZHbwAb4xK/BBzYZy6qdNzzt8o9xEcdmfm
X-Gm-Gg: AYBFou3H5RzYV3CEqqx2XMKVSBtGKQmVevY44L64hrPgOJ8cb79yhZB7w0UT0eJqhCv
	U0gQYkoPjp3eJvaMyVBuVlBi6I0Tqk5HG2jX3vXp2yENRpFqmVU8b8ihyYT4wQnYaDliJHh4Cir
	mtBc/y+MTJpZva0Rtpjx0FOIsmJYxwAYECvBMsoS2NeDRbdDSOWpMOG/yV1OJwaRmk9+NV4jvN2
	2NB9yKMMGXescbH1lewAktGTM4l86fR842LI+w24GjsUpX0h6MkBLj2cw+VzlBu3NsDQJa8TJAc
	Sd7x2/XEB79vfaXCtVfZzSh9EIuKdsI+H5eb88MGB1gColx8ltOMKiQJMzuCU3/HgJpWpOyafiZ
	3tQ5AGYg8wGfYkwBmWOvKgAyUcAuScSkZ4iGWDGqsLAv4l62Ljt5HF8e3pMopNbVr37vOBS+qMk
	+HGBG1bOHR7OLi3t0kV+G88HNx6e9UpBuAMBJaGgh9ZR5jBWsvo8sHGryobw7yfBCUeETJydWDg
	5vvTmH4qwu1cZW/pt/tOGuf8V/fPLEbYokDThhDPC0AVliYLOSpaQ2KWqE+EBxVoczzgOaJNK74
	sUedt814fy3Qcfe9seJJ2JSYIrOuqYR4Q4rvSvawQUFw3ULxRivzbE2P5O4syRb9lA==
X-Received: by 2002:a17:902:d54a:b0:2e8:3190:73a with SMTP id d9443c01a7336-2eb0057c299mr9511085ad.58.1793152840529;
        Tue, 27 Oct 2026 19:00:40 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6c9d2cesm15596405ad.65.2026.10.27.19.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 19:00:40 -0700 (PDT)
Message-ID: <63f51c81-4ad4-44ea-b8bf-32f9ff6a4871@gmail.com>
Date: Tue, 27 Oct 2026 19:00:36 -0700
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
To: Jan Engelhardt <jengelh@inai.de>, andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, stian@itx.no, glaubitz@physik.fu-berlin.de
References: <20261028010100.24792-1-jengelh@inai.de>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261028010100.24792-1-jengelh@inai.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 10/27/26 6:00 PM, Jan Engelhardt wrote:
> The SPARC port also lacked reporting L3 caches, present in the
> Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4
> onwards and Fujitsu M12, respectively.)

This seems like a typo.  Instead of "Oracle S3" shouldn't this be 
"Oracle S7"?

Regards,

Tony


