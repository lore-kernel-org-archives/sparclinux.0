Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B31FF1A0
	for <sparclinux@vger.kernel.org>; Sat, 15 Mar 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050545; cv=none; b=Kj1mxqfJKZ+l0L9pTtpWD8nw3zpJwQ7OJhCZsNhXwlzmYX5IO84yC4ki+3M9ugD4HALs3i/Tvt7KItzbt/5/3R8KGqhmq0r3VMI8tYb+BN52DnnLvNFmRV5rbzIL8fTri4qJK14uyx+lkK+qXtly2KSu6LcOmf0eXo5p9ey4v04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050545; c=relaxed/simple;
	bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=aK6J8SL0vjQXG2E/2aLL0s6rWlMOxXFj5IeOu8aVYjYCUvqsFZyDOIqDGbAZpPXRkh6qvZFktxp5rih3fBGZgdJp8F6qejdu34XMI2eFAzzbUa/f2ZoSVohZotc2iiYTCept0Nfozuu1Q/ZV9oQmFSMLODX0KdR4e30VvK1cWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmSjBQ9i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmSjBQ9i"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3014ae35534so763911a91.0
        for <sparclinux@vger.kernel.org>; Sat, 15 Mar 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050543; x=1742655343; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=PmSjBQ9iXnLJUW2idUj4k2rryQQVbg/u4JfQq9Z7sOLQAWkwBeOXLDdObkRKX/YwA5
         VZKXGNshnwN3FzHVih5sE5LsjfahwEYo8mTxY+LFfphTknebNzB/lfuO8AgeHLHwztzw
         hsQclR4CmM2Swg9TQqh+7yBxVTAaMFPsWwwstd/omtTWD9gRwkFkiw3zLoYoHumY5V1+
         OGK3MYKiA74blXWHYoH8LmYf767Z13BBpm0aBv2/F0xio5h/xsfr2n+3+iVpbq4gm1iX
         bEVfjWwVFbRAM9csDsJGmDcIdCcvalQvxWekpf6eq4XRcvLFvrtmew58O7LnVVFdwxXC
         yFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050543; x=1742655343;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=jMvZ+taC6RjnAzZcR1VgxD3ReAlmkup3V0EOZOsC62U19yccnmf9L/+ORTYzaKuwbs
         BHmoq5O07cfZTNDTEtRDEkLGbOUoks0NFH7sOM9tgMJU8XRb5bK6TnXh1BKnCRlXEZxj
         5oB6gs64qSV1tKuGfPfWGd4jgaCmOE7rAhQ/IOaGIvgDe0C5Fl0gi83To0QWIHso8IcG
         axW3jM2B9JZHQpe+SsFJbsLMa77loIMRyU1JahE/qp301mJ8pm2G+cYO1VZv9cZGtehu
         A1RaezcN47otl5ls+2zUwZHS4RC0THgZLs1c5tZex1dEF73Plrv9ZYREn4jN2EtayYSP
         cWcA==
X-Forwarded-Encrypted: i=1; AJvYcCX0szryyZIAhdZBxlTpf0UzJWMS0pFQjUggsSyf+/A17CmQeFAAxDoRvn5lNyp8URUDm/0ZEPcZhh/+@vger.kernel.org
X-Gm-Message-State: AOJu0YwqD0INKW4n2yGBSXJSHxpQDIUHi2iusfwDLwH3pOq0BDnqQtfm
	cz5p3B7hThF1xRNDC7Rn8ND6YtChNCWTG9O1mIDciT26ZtBAJlRNVaXOGcmcD5P02smsybzznrU
	kspA39la0ygTWBaukszmaEV8us80=
X-Gm-Gg: ASbGncvrM8FgcSYn50aykMVUcaYWzKol8c9WZ4fqHiodWzJNoz7y80P3SEoyDw1A01t
	E+nNHPIazh6GaCTS41zWr24/0jf7+/YHNqh/LvVRpumrAo1ISla2zLI3AluOftp9Hb4lj0ARaqf
	EQtjkshE/emoCevzQx71pGw+4=
X-Received: by 2002:a17:90b:2e44:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-30151cc2490mt7920220a91.16.1742050543260; Sat, 15 Mar 2025
 07:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
 <Z9ErEBuMMvd6i2n9@kernel.org>
In-Reply-To: <Z9ErEBuMMvd6i2n9@kernel.org>
From: DiTBho Down in The Bunny hole <downinthebunnyhole@gmail.com>
Date: Sat, 15 Mar 2025 15:55:33 +0100
X-Gm-Features: AQ5f1Jrmv7KQRCuWBIo_vXTI9aIDRsZr_EQ5uQHAURWeudjXpiSlHPWiANvw4jg
Message-ID: <CAAZ8i80e6CsD1Y36-sVrVs4QPB-82J1gPOeDvHa_+sQtfUpMtQ@mail.gmail.com>
Subject: Soekris crypto 1411, where to find ?
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

hi
this is probably not the right place to ask, but I've been searching
eBay and similar places for 2 years and haven't found one yet.
I support older MIPS hardware and need to find a Soekris crypto 1411
miniPCI module or two, to add VPN acceleration.

Anyone have an idea where to buy it?

Soekris company went out of business years ago.

Let me know.
D.
