Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106EE299AB4
	for <sparclinux@vger.kernel.org>; Sun, 14 Dec 2025 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765749885; cv=none; b=uGtJxISLWjyI9LtXbgDZfWUYHphQoiXsYXNNggpfRUE0CglMWxzF3nL1iGlV8DpzRWdHQaQi1dcMVjG1XNDLQBjmsfCIX0Ib5cZQhpsJ34rrYsSh33vsHnB/M/+fsF4M7hjDM7CcxoXnD/wVsjEFbGNbPTqplfNVjP2MchCviCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765749885; c=relaxed/simple;
	bh=OsZtNvC57Q0MTvQ0L0dGnqvyWUsxJxn5my2UaWA/0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAZxX5zrupV/bRsSirUNmIFv2N/38pTyxkS7ldr5e3nECe6yy0WTdSZLo5wRZkU1YN282DKMzZttvCXgBJ73tKGPjKgsbecCeK318jYx3KNo1d9DikRXnuYkvdsTk0G6MfmOmO4Sx53aaZ7bW8AXmFhm0sVOJxOc6eSfE1w+6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=POEj1WJ/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="POEj1WJ/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8887f43b224so35544436d6.1
        for <sparclinux@vger.kernel.org>; Sun, 14 Dec 2025 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1765749883; x=1766354683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cTj72ha+a5XJMJvRmgDZDY2gaP3p8aX5U73ylQ5QC8=;
        b=POEj1WJ/MCTEcFpJB7A/t/8hB8kN4iW+jypO9pdrCDiMmXktoDW1uimdy/TlbOpWWE
         Qcj1fyl5Vl3Ba+T9Zv3ByfhWtvlA8GZGEiaR+qRXTJsFVN7Og10c6nr/4evqUM7kmRj4
         hD9CLYFB+bL5AE7UEGIQ+bkxeKAYcyDIK4lU+nMrYyiNK5OdOHsihUit1U3I9bsgfCE8
         weriQ36ITho+DB/T/2vf+ai29+0iUK8kIN8lb8qv4XJKOkKUPGmEE4U1RWFSiAWB70Bq
         zmjzEYGxHURk2Sa3eQXyPLTVuNMxb4Es7hJMJjzhgjCQn2e1PQjwEphvB29OSYF1jGSU
         EtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765749883; x=1766354683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cTj72ha+a5XJMJvRmgDZDY2gaP3p8aX5U73ylQ5QC8=;
        b=A9JbXqLQ2sYy5ew4kzl7udVOiz/PhXgP87PTsq5hst5jABSL8YwVbp0hs2F+EpccXi
         P7Xk4vk57upq0NdvcuPvyWzmTnfCvNWtqx1T66Iz0jOXVMxxAUJEntLsanthlh8HIF2S
         mDWVZh+UXon6Z+la2vdxmWe97+QzXS0sQrFppMx/iTnWgZ+ETBbIZEoTz/Pk9/9uCK4v
         sQr1Oj7jR8dsvtcGeFKnuzKzZYrD6L1nKiHjaKzeFp3mSE70uzTeICxj4sLEJ0RlzPqn
         lhwiHfQwLgwvGmwejEnuQi5EXjjm1EN9AG+U2jmYkq0Zp6bSS3j+t1rcpZK6BVSzZlbC
         SRkw==
X-Forwarded-Encrypted: i=1; AJvYcCWb0+Q4PLsfolqJcN6uVJ78sl+DFphPraTH7MXcSwK1qmI2gYF7CDbuEtMszz3lhXrAAv891PNkOro/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08UxnAcOHmZats8FtZR4CunA6tprJUbtdv3k627prKuIYZ9sE
	v9bk+22IYK7Z/BhRS8kVrWrtlNpFb5U/8lY6CGbyXnzw4kShXuLz+zPGorHu8+n1Qnk=
X-Gm-Gg: AY/fxX7liBrk+oZvW7Wc1wuHTqObHBNhYPp74zKgWPxKx98jbpcV/R/cdH8eN5o/MQq
	FmvYoLel7Tkb/53rnh7qb8P6+8murwTDaFd6prKBFCwovOjDR1oKfkEzQfi+2qFTZtoK27qUSFl
	8Wz6nRRVC5QnMyloT9K1Z4+0HcGrBNALp9deJ7MUXGVTe+KJW0nSzWAQQ4f3tKTDW1yYaiyRCOJ
	EQVTudPXtyaCUybmvywdKZD1VLYS4pwibXC5zTGa9IxTDUIxviqDdpoQUcsd9WOqcGZxFJ9ne9+
	8ANawT01575vVUyVd7BamnekYkV+q5xOg0srLGvn5TM0bWaody0bUyXjssBFfJTVIV3Qf60/1P1
	6C1myiXdOviTXOX/6+PUpVmTmHPcYiLRBrJ0xzVYCb2tDCsFIajBZjJ87kZC9UCd9GclPHmDo/p
	Vabs2C5nJczksiohhRsdMJcj+3vk9RHRCTFVsDCK03
X-Google-Smtp-Source: AGHT+IEDFcxqfAIv8Lzvd0GjECj/WpfJVYeBMCOAIQ4Nzc4ZxKDvXtd5bV1zeaqceaQ7pMz4WHhP1g==
X-Received: by 2002:ad4:5c48:0:b0:880:5cc1:692c with SMTP id 6a1803df08f44-8887e1957ccmr128935286d6.17.1765749882988;
        Sun, 14 Dec 2025 14:04:42 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88993b597f7sm39205576d6.14.2025.12.14.14.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 14:04:42 -0800 (PST)
Date: Sun, 14 Dec 2025 17:04:41 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org, Esben Haabendal <esben@geanix.com>, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <2t6bhs4udbu55ctbemkhlluchz2exrwown7kmu2gss6zukaxdm@ughygemahmem>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <gfwdg244bcmkv7l44fknfi4osd2b23unwaos7rnlirkdy2rrrt@yovd2vewdviv>
 <48db01b1-f4e5-4687-8ffb-472981d153ed@leemhuis.info>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48db01b1-f4e5-4687-8ffb-472981d153ed@leemhuis.info>

On Mon, Dec 08, 2025 at 03:35:42PM +0100, Thorsten Leemhuis wrote:
> Lo!
> 
> On 11/26/25 04:18, Nick Bowler wrote:
> > Any thoughts?
> 
> Not really, just a vague idea (and reminder, this is not my area or
> expertise, I'm just tracking regressions):
> 
> Two fixes were proposed for the culprit, see:
> 
> https://lore.kernel.org/all/BN0PR08MB69510928028C933749F4139383D1A@BN0PR08MB6951.namprd08.prod.outlook.com/
> https://lore.kernel.org/all/BN0PR08MB6951415A751F236375A2945683D1A@BN0PR08MB6951.namprd08.prod.outlook.com/

The first link is a patch for a totally different driver, as far as I
know not relevant to any system I have, but I guess that makes at least
3 different systems which have regressed...

I can't figure out how to turn the second link into a correctly-
formatted patch file, but since it is a one-line change I just manually
applied it on top of 6.19-rc1.  This appears to fix the problem.

Thanks,
  Nick
