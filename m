Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3572331A44
	for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910040; cv=none; b=r1u7QjmoXdaLn7+xhDuQ1u+0YhMHaDasQTX72PJtDXvrgpkBvNXJldwkYv7pOc0dcu00VhBHg4PUwRncQwmZlBoo/AIJ+PfwL0B5NthPV63pMCJLxkAU5s0ptaVlb9zTnvgZk6BU/JhGOO703i4rg3V1ImVna6U/VTAOueYnu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910040; c=relaxed/simple;
	bh=plC+/6CrEBYyMLwLcmmekRAtRmr4crxYvfBWrqa4EsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/Lg1rLpGX1/ZMNNbK5pjSJgORADiThNOl0krg05rp7QGAR8A9y8qxslpX8sSw0VYudRtkeE1oqS7iKRUd+TjXhjMb4b5zuG1JZpzwVpxcZzqw9P74HHlu79f8pbeSXDRYnASwA/UneNoi5j8aknGMCbWJ50q7yZCdg8UU7IdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mVx0TeTu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mVx0TeTu"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso19281345e9.0
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 04:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761910037; x=1762514837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwf871RDbtgle/X+gHRRa1kmehrfWm8Nitz2OZjIhxk=;
        b=mVx0TeTuTskgFvVTRNFRNe6XPJ94tkP1BMM3Y+K2B68F7NwdV8zrYxQtzarW4GnYHN
         2akQ1i0UOJPhSqXG78UBb3x/gjoD+M1vtBRBMoRzCz+nr5/hoE1RUzwdR6sK30PiSC0N
         UKgyltXMeNnjYB8zeitgS/3/LFrhIXkoDINbmEfZtBL4SvulrJ4jZmymUYq0y+khpK5q
         H0Xqr0TMWLZ/853vx/Z2BIy84xuxgKHy+s+RKgYKNiQnj1Yk8XOnpcZUREm2FZev0Vns
         Ex34fuxZ7RZBIM/sWha4ANvIYjrhV9aubPIfpZQQeEu1rcWjUVVCaY8Scvt9JYx6O+1p
         Ltyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910037; x=1762514837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwf871RDbtgle/X+gHRRa1kmehrfWm8Nitz2OZjIhxk=;
        b=u5/Z7C3ortGxBNEWa82Wgm+Z3etuGmDtP34+nCHHQaO4Jukc7Qbl4J60V3Dt+seosh
         k9caftmZLHeB56+IObd19IYWANN8kvSCsjz2zShq8cOLRIQ2BlxiBUjoxhhz+5naUkyJ
         Tf9n1vAzZ5bQmHcUzBLjo87IRCVl61XKXMFITkY0rxBnRKEe++GGWAp5LexMlbcywd65
         pN8TPbd/4K+3jqwk/FzGmRl+W1MkHRNVUgopPJh0XgYxd9CVskWnmzsppEA2b9hH/2uD
         MSZu0gBy7ztOxOALoGpR2aAXni8HPOmSvv5ZT8juPE8beGQhrWMgiTzDL+j3kJcEYh+T
         PFug==
X-Forwarded-Encrypted: i=1; AJvYcCXAZcef2f5nF5JL/jjiWe52xzYu2xZ67lBbKL/L1MYrU6mJ4VUzHOO6CnDpPP8MoIxwOioCx/L/c5Qp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XtAY0NMK87E6F8Ku/89StohwTQ//gsnZhmc42UJPFu7eEd/J
	gR6QZY3r6lBa6DjDd2lB1qBtueRcKmeftMWiHiC9mX9UIUucvQQx+hYRoniQV3I4HDg=
X-Gm-Gg: ASbGncuEQK7N14vFyJAlU078FwsM91UONgSvdKGYG7DvqQxFtXhhXxIyiZHwd9KRRNk
	BtTf3w70W6G9eE8BYPFZlvh21QrglnJnQIQo11uXQcNXuh/2TAWeIyVV+igRBC8MGNRqR/MUNpZ
	ff0CEOndu3wcd3EBGE5PT9yK1chDBomtCun3/19RQ6EZE7vMcBa3o6rL+H2WlgmOf8E3ZLUTw0g
	hJrrn+/lVr3ZQ9Ejai5gVo0rz6JEVp1Bc06irXGxrH22kj6jcmphnccOdAbXzQ2cUAXWD1q8f8O
	ZiSq7HO3nzei+Bwdd62fu2zWa7F6gIVka8n0cY3drKE2GrkP8QNU5DrPcsZkrO9yskCNwoHAElK
	5WRxTRX2VvoFXW+8lhxKd9TNIe0zGjnAMz51Tk6Eh0jUtstT5EaNnQ+tNuI5Yoh7BtTrSLnv/pn
	XPuucV7Q==
X-Google-Smtp-Source: AGHT+IHOCxnrV9vNtIsoHM6missOnF5vwOTnrAGX8+16mZQ7e1sifCeCAgu5UUuGQnX7eDw9qPPn1A==
X-Received: by 2002:a05:600c:5387:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-477307c23d9mr27753125e9.9.1761910035750;
        Fri, 31 Oct 2025 04:27:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47728a96897sm90006865e9.11.2025.10.31.04.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:27:15 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:27:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, sparclinux@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Christoph Lameter <cl@linux.com>,
	"David S. Miller" <davem@davemloft.net>,
	Finn Thain <fthain@linux-m68k.org>, Tejun Heo <tj@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
Message-ID: <aQSdD5RFHvzJOlak@stanley.mountain>
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
 <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
 <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
 <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>

On Fri, Oct 31, 2025 at 11:08:39AM +0100, Geert Uytterhoeven wrote:
> 
> The above function could be shortened by writing
> 
>     (sevt = memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent,
> sizeof(*sevt)))->cpumask = cpumask_of(smp_processor_id());

Heh.

regards,
dan carpenter

