Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8071519E97B
	for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538335; cv=none; b=LPZqFzRzAqJ3IFCwQ0QkPyGll+iyXgML6YBYWI9CilCRmr+2zHlfWv6NxfhFUqlITq7PxtuIXG5KCq59o1mwp6j0tzCeYKgH+9vVLhHT4J1KZFQka11p9nZFjWISEQ8Izc1aEv2ESeIEtBZuZ7jAwUbAMD8ieIq0Xd/r86kTRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538335; c=relaxed/simple;
	bh=/cujPmecUjAGwaUlj4yjPwoinlTozZS+pNkkXc0ZRlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkVQMkfZMVM19vX/zUqHDLBhHcnbyN/STb8XxLJbqgvarxpceI3D9LAf/DrfzFEjhvUamftUVjkdIYWxXCAwhEAFjB8owIpy2RJ10IP8mCs1LTGHrwhgg3a5lF8X30xgXpMYqDPOaMTRZmFVYrCM1Y/0JQusMz2zestTPUE/EC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HA0dzhYg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HA0dzhYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748538332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVXYcQRv3WLSWQAfJBtkuGRCwO3gzeCu1+3GwyAE/8U=;
	b=HA0dzhYg2/d2e9xCOQ6+qrQfdSIoIjKIE54Hfm2mZGs9AEUR7zBotVe4IYg8usT0jPM5Rv
	vNgz+nUnERNME4jNE7M6Q0KewvGDiq/+8HnWr/vRa9F/jswDSiBHMYPvH6yxP4MB2h/8on
	oBX5gNXG+HXcEacttTNL6TZSFOW/pGk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-ZvMk98YpOV-ImLLqCiS67A-1; Thu, 29 May 2025 13:05:30 -0400
X-MC-Unique: ZvMk98YpOV-ImLLqCiS67A-1
X-Mimecast-MFC-AGG-ID: ZvMk98YpOV-ImLLqCiS67A_1748538330
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dc772d43ccso1307025ab.3
        for <sparclinux@vger.kernel.org>; Thu, 29 May 2025 10:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538330; x=1749143130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVXYcQRv3WLSWQAfJBtkuGRCwO3gzeCu1+3GwyAE/8U=;
        b=LBLxSh/08covI3Hjg3gjKi+jzYzOvbJBXbvHuy6TeNhLlCtsm7xqbVlBoHk1TLqS5H
         wu0gAGMRQvQIU/CnIAckVo4XFMp6NbBviBXeTCY7u/crd1+Firxfd/ptTUrK0thmSR57
         oDeIS9bx7yg1mZWo04N5jC9Uq9vpq10zBfj7kXUMl6TAHLoC49z5bW5Ll7uinSGUsq5u
         yYVu6sH2CVi8ziszvNQQ3+dp5R875YSzbQz+iqVzukLPoihULL/F+cu1jgO4db+EZwsv
         zpoYexVrzLz0Ewny+UGdOUYxgy7lpF/iiBc3OYVDbi9hiOy3c/3WH2zk/wmgaLvqPUVe
         25ew==
X-Forwarded-Encrypted: i=1; AJvYcCX41b4mU2LeslP2Po4WCkuhD/g33dEaJHQ4WU0bVsC08kL2hc7OvS5UvnlTE4fvNfcioYD1F15S/jXw@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWXxAdmTj59FHLA5qh47aULzlpe4nGxoXC7IGAALWAJqT8lil
	Asjk0yVvH41saAEdNvaq1z9sfSH35VptYO/71PkLQVeGT/igrjN4PsTTKl4mmVwSZq9KTnSu4MY
	m+68E+T8DEc6K8qDsHat5uDiQVA/yhcINhdI0Z4Kz25JSGGCNJQ5EDWKnkxBJ3Wg=
X-Gm-Gg: ASbGncsvh1KGffmBfXZk6f7nYBZaEsZ/bec5RXQhDQjOEnQJTTwiRZ+nhu6E/r6uZ+1
	AByXJcn8v38wlX21e+Wmfhub7k8XCXpZyt9r2TIOUP7HXrfmU0REmvzzY5VoE1KswcSpEjt/mvO
	/ypilDEzkMrCX44fwpycMhHzXWH4vyaRQxNBg2AhiSpL862/VEOUee+4wM2GJpnf1lmuFPFW5ID
	ExiQQbzBrpJSWEvPxx2tHOpkwUMjNM4du9tlZY7VfTvxB1x8BjSX0GGKzY0R9CW8CN0e2i1A/jo
	W1FNRDlGQ75Hb6E=
X-Received: by 2002:a05:6e02:2789:b0:3dc:7cd7:688 with SMTP id e9e14a558f8ab-3dd99bd0681mr1264935ab.1.1748538329896;
        Thu, 29 May 2025 10:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfF2IypLjTHDTvX90AOSKarc6ttkVaDkLoPGB0d3lYBRme4WFH0Ya+stqq3YBkEYUuHUQECg==
X-Received: by 2002:a05:6e02:2789:b0:3dc:7cd7:688 with SMTP id e9e14a558f8ab-3dd99bd0681mr1264795ab.1.1748538329510;
        Thu, 29 May 2025 10:05:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dd935462c8sm3928805ab.36.2025.05.29.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 10:05:28 -0700 (PDT)
Date: Thu, 29 May 2025 11:05:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel
 <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library
 instead of shash
Message-ID: <20250529110526.6d2959a9.alex.williamson@redhat.com>
In-Reply-To: <20250428170040.423825-9-ebiggers@kernel.org>
References: <20250428170040.423825-1-ebiggers@kernel.org>
	<20250428170040.423825-9-ebiggers@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 10:00:33 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> Instead of providing crypto_shash algorithms for the arch-optimized
> SHA-256 code, instead implement the SHA-256 library.  This is much
> simpler, it makes the SHA-256 library functions be arch-optimized, and
> it fixes the longstanding issue where the arch-optimized SHA-256 was
> disabled by default.  SHA-256 still remains available through
> crypto_shash, but individual architectures no longer need to handle it.

I can get to the following error after this patch, now merged as commit
b9eac03edcf8 ("crypto: s390/sha256 - implement library instead of shash"):

error: the following would cause module name conflict:
  crypto/sha256.ko
  arch/s390/lib/crypto/sha256.ko

Base config file is generated from:

$ CONFIG=$(mktemp)
$ cat << EOF > $CONFIG
CONFIG_MODULES=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_SHA256=m
EOF

Base config applied to allnoconfig:

$ KCONFIG_ALLCONFIG=$CONFIG make ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- allnoconfig

Resulting in:

$ grep SHA256 .config
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_LIB_SHA256=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SHA256_GENERIC=m
CONFIG_CRYPTO_SHA256_S390=m

Thanks,
Alex

